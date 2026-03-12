<?php
// app/controllers/AdminController.php
// All admin actions require admin role (enforced via requireAdmin())

require_once BASE_PATH . '/app/models/Article.php';
require_once BASE_PATH . '/app/models/Category.php';
require_once BASE_PATH . '/app/models/User.php';
require_once BASE_PATH . '/app/models/Comment.php';

class AdminController extends Controller {

    private Article  $article;
    private Category $category;
    private User     $user;
    private Comment  $comment;

    public function __construct() {
        $this->article  = new Article();
        $this->category = new Category();
        $this->user     = new User();
        $this->comment  = new Comment();
    }

    // ── Dashboard ──────────────────────────────────────────────────────────

    // GET /admin
    public function dashboard(): void {
        $this->requireAdmin();
        $db = Database::getInstance();
        $stats = [
            'articles' => (int)($db->fetchOne("SELECT COUNT(*) AS c FROM articles")['c'] ?? 0),
            'users'    => (int)($db->fetchOne("SELECT COUNT(*) AS c FROM users")['c'] ?? 0),
            'comments' => (int)($db->fetchOne("SELECT COUNT(*) AS c FROM comments")['c'] ?? 0),
            'pending'  => $this->comment->getPendingCount(),
        ];
        $this->view('admin/dashboard', [
            'pageTitle'  => 'Admin Dashboard – GameNexus',
            'stats'      => $stats,
            'latest'     => $this->article->getLatest(5),
        ], 'admin');
    }

    // ── Articles ───────────────────────────────────────────────────────────

    public function articles(): void {
        $this->requireAdmin();
        $page   = max(1, (int)($_GET['page'] ?? 1));
        $result = $this->article->getAllAdmin($page);
        $this->view('admin/articles', [
            'pageTitle'   => 'Manage Articles',
            'articles'    => $result['data'],
            'totalPages'  => $result['pages'],
            'currentPage' => $page,
        ], 'admin');
    }

    public function createArticleForm(): void {
        $this->requireAdmin();
        $this->view('admin/article-form', [
            'pageTitle'  => 'Add Article',
            'categories' => $this->category->all(),
            'article'    => null,
        ], 'admin');
    }

    public function storeArticle(): void {
        $this->requireAdmin();
        $thumbnail = $this->handleUpload();
        $slug = $this->article->generateSlug($_POST['title'] ?? '');

        $data = [
            'title'            => $this->input('title'),
            'slug'             => $slug,
            'summary'          => $this->input('summary'),
            'content'          => $_POST['content'] ?? '',
            'category_id'      => (int)$_POST['category_id'],
            'author_id'        => (int)$_SESSION['user_id'],
            'status'           => $this->input('status', 'draft'),
            'is_featured'      => isset($_POST['is_featured']) ? 1 : 0,
            'is_breaking'      => isset($_POST['is_breaking']) ? 1 : 0,
            'thumbnail'        => $thumbnail,
            'meta_title'       => $this->input('meta_title'),
            'meta_description' => $this->input('meta_description'),
        ];

        $this->article->create($data);
        $this->redirect('/admin/articles');
    }

    public function editArticleForm(string $id): void {
        $this->requireAdmin();
        $article = $this->article->find((int)$id);
        if (!$article) { $this->abort(404, 'Article not found'); }
        $this->view('admin/article-form', [
            'pageTitle'  => 'Edit Article',
            'categories' => $this->category->all(),
            'article'    => $article,
        ], 'admin');
    }

    public function updateArticle(string $id): void {
        $this->requireAdmin();
        $article  = $this->article->find((int)$id);
        if (!$article) { $this->abort(404); }

        $thumbnail = $this->handleUpload() ?? $article['thumbnail'];
        $slug = $this->input('slug') ?: $article['slug'];

        $data = [
            'title'            => $this->input('title'),
            'slug'             => $slug,
            'summary'          => $this->input('summary'),
            'content'          => $_POST['content'] ?? '',
            'category_id'      => (int)$_POST['category_id'],
            'status'           => $this->input('status', 'draft'),
            'is_featured'      => isset($_POST['is_featured']) ? 1 : 0,
            'is_breaking'      => isset($_POST['is_breaking']) ? 1 : 0,
            'thumbnail'        => $thumbnail,
            'meta_title'       => $this->input('meta_title'),
            'meta_description' => $this->input('meta_description'),
        ];

        $this->article->update((int)$id, $data);
        $this->redirect('/admin/articles');
    }

    public function deleteArticle(string $id): void {
        $this->requireAdmin();
        $this->article->delete((int)$id);
        $this->json(['success' => true]);
    }

    // ── Categories ─────────────────────────────────────────────────────────

    public function categories(): void {
        $this->requireAdmin();
        $this->view('admin/categories', [
            'pageTitle'  => 'Manage Categories',
            'categories' => $this->category->all(),
        ], 'admin');
    }

    public function storeCategory(): void {
        $this->requireAdmin();
        $name = $this->input('name');
        $slug = $this->category->generateSlug($name);
        $this->category->create([
            'name'        => $name,
            'slug'        => $slug,
            'description' => $this->input('description'),
            'color'       => $this->input('color', '#e63946'),
        ]);
        $this->json(['success' => true]);
    }

    public function updateCategory(string $id): void {
        $this->requireAdmin();
        $name = $this->input('name');
        $slug = $this->input('slug') ?: $this->category->generateSlug($name);
        $this->category->update((int)$id, [
            'name'        => $name,
            'slug'        => $slug,
            'description' => $this->input('description'),
            'color'       => $this->input('color', '#e63946'),
        ]);
        $this->json(['success' => true]);
    }

    public function deleteCategory(string $id): void {
        $this->requireAdmin();
        $this->category->delete((int)$id);
        $this->json(['success' => true]);
    }

    // ── Users ──────────────────────────────────────────────────────────────

    public function users(): void {
        $this->requireAdmin();
        $page   = max(1, (int)($_GET['page'] ?? 1));
        $result = $this->user->getAllAdmin($page);
        $this->view('admin/users', [
            'pageTitle'   => 'Manage Users',
            'users'       => $result['data'],
            'totalPages'  => $result['pages'],
            'currentPage' => $page,
            'roles'       => $this->user->getRoles(),
        ], 'admin');
    }

    public function updateUserRole(string $id): void {
        $this->requireAdmin();
        $roleId = (int)($_POST['role_id'] ?? 2);
        $this->user->updateRole((int)$id, $roleId);
        $this->json(['success' => true]);
    }

    // ── Comments ───────────────────────────────────────────────────────────

    public function comments(): void {
        $this->requireAdmin();
        $page   = max(1, (int)($_GET['page'] ?? 1));
        $result = $this->comment->getAllAdmin($page);
        $this->view('admin/comments', [
            'pageTitle'   => 'Manage Comments',
            'comments'    => $result['data'],
            'totalPages'  => $result['pages'],
            'currentPage' => $page,
        ], 'admin');
    }

    public function approveComment(string $id): void {
        $this->requireAdmin();
        $this->comment->approve((int)$id);
        $this->json(['success' => true]);
    }

    public function deleteComment(string $id): void {
        $this->requireAdmin();
        $this->comment->delete((int)$id);
        $this->json(['success' => true]);
    }

    // ── File upload helper ─────────────────────────────────────────────────

    private function handleUpload(): ?string {
        if (empty($_FILES['thumbnail']['tmp_name'])) return null;

        $file    = $_FILES['thumbnail'];
        $allowed = ['image/jpeg', 'image/png', 'image/webp', 'image/gif'];
        $mime    = mime_content_type($file['tmp_name']);

        if (!in_array($mime, $allowed)) return null;
        if ($file['size'] > 5 * 1024 * 1024) return null; // 5MB max

        $ext      = pathinfo($file['name'], PATHINFO_EXTENSION);
        $filename = uniqid('img_') . '.' . $ext;
        $dest     = UPLOAD_PATH . $filename;

        if (!is_dir(UPLOAD_PATH)) mkdir(UPLOAD_PATH, 0755, true);
        if (move_uploaded_file($file['tmp_name'], $dest)) {
            return UPLOAD_URL . $filename;
        }
        return null;
    }
}
