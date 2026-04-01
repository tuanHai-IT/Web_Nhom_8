<?php
// app/controllers/ArticleController.php
// No manual require_once — autoloader handles class loading.

class ArticleController extends Controller
{

    private Article  $article;
    private Comment  $comment;
    private Category $category;
    private Tag      $tag;

    public function __construct()
    {
        $this->article  = new Article();
        $this->comment  = new Comment();
        $this->category = new Category();
        $this->tag      = new Tag();
    }

    // GET /article/:slug
    public function show(string $slug): void
    {
        $article = $this->article->getBySlug($slug);
        if (!$article) {
            $this->abort(404, 'Article not found');
            return;
        }

        // Throttle view count — one increment per session per article
        $viewKey = "viewed_article_{$article['article_id']}";
        if (empty($_SESSION[$viewKey])) {
            $this->article->incrementView((int)$article['article_id']);
            $_SESSION[$viewKey] = true;
        }

        // Ghi lịch sử đọc nếu đã đăng nhập
        if (!empty($_SESSION['user_id'])) {
            try {
                $this->article->addReadHistory(
                    (int)$article['article_id'],
                    (int)$_SESSION['user_id']
                );
            } catch (\Throwable $e) {
                // Bảng chưa tạo hoặc lỗi DB — không crash trang
                Logger::log('history.error', $e->getMessage());
            }
        }
        $userId     = (int)($_SESSION['user_id'] ?? 0);
        $avgRating  = $this->article->getAvgRating($article['article_id']);
        $userRating = $userId ? $this->article->getUserRating($article['article_id'], $userId) : 0;
        $bookmarked = $userId ? $this->article->isBookmarked($article['article_id'], $userId) : false;
        // Tính thời gian đọc (~200 từ/phút)
        $wordCount = str_word_count(strip_tags($article['content'] ?? ''));
        $readTime  = max(1, (int)ceil($wordCount / 200));
        $this->view('pages/article', [
            'pageTitle'       => $article['title'] . ' – GameNexus',
            'metaDescription' => htmlspecialchars($article['meta_description'] ?? $article['summary'] ?? ''),
            'article'     => $article,
            'tags'        => $this->article->getTags($article['article_id']),
            'related'     => $this->article->getRelated($article['category_id'], $article['article_id']),
            'comments'    => $this->comment->getApproved($article['article_id']),
            'categories'  => $this->category->all(),
            'popularTags' => $this->tag->getPopular(10),
            'breaking'    => $this->article->getBreaking(5),
            'avgRating'   => $avgRating,
            'userRating'  => $userRating,
            'bookmarked'  => $bookmarked,
        ]);
    }

    // POST /article/comment (AJAX) — CSRF validated by middleware
    public function submitComment(): void
    {
        if (empty($_SESSION['user_id'])) {
            $this->json(['success' => false, 'message' => 'Please log in to comment.'], 401);
            return;
        }

        // Rate limit: max 10 comments per minute
        if (!RateLimiter::check('comment', 10, 60)) {
            $this->json(['success' => false, 'message' => 'Too many comments. Please slow down.'], 429);
            return;
        }

        $articleId = (int)($_POST['article_id'] ?? 0);
        $content   = trim($_POST['content'] ?? '');

        $v = new Validator();
        $v->required('article_id', $articleId, 'Article')
            ->minLength('content', $content, 3, 'Comment');

        if ($v->fails()) {
            $this->json(['success' => false, 'message' => $v->firstError()], 422);
            return;
        }

        $id = $this->comment->create($articleId, (int)$_SESSION['user_id'], $content);
        Logger::log('comment.create', "Comment #{$id} on article #{$articleId}");

        $this->json([
            'success'  => true,
            'message'  => 'Comment posted!',
            'id'       => $id,
            'username' => $_SESSION['username'] ?? 'You',
            'content'  => htmlspecialchars($content),
            'date'     => date('M d, Y'),
        ]);
        return;
    }

    // POST /article/rate (AJAX) — CSRF validated by middleware
    public function rate(): void
    {
        if (empty($_SESSION['user_id'])) {
            $this->json(['success' => false, 'message' => 'Please log in to rate.'], 401);
            return;
        }

        // Rate limit: max 20 ratings per minute
        if (!RateLimiter::check('rating', 20, 60)) {
            $this->json(['success' => false, 'message' => 'Too many ratings.'], 429);
            return;
        }

        $articleId = (int)($_POST['article_id'] ?? 0);
        $rating    = max(1, min(5, (int)($_POST['rating'] ?? 0)));

        if (!$articleId) {
            $this->json(['success' => false], 422);
            return;
        }

        $this->article->rateArticle($articleId, (int)$_SESSION['user_id'], $rating);
        $avg = $this->article->getAvgRating($articleId);
        $this->json(['success' => true, 'avg' => $avg, 'your_rating' => $rating]);
        return;
    }

    // POST /article/bookmark (AJAX) — CSRF validated by middleware
    public function bookmark(): void
    {
        if (empty($_SESSION['user_id'])) {
            $this->json(['success' => false, 'message' => 'Please log in.'], 401);
            return;
        }

        $articleId = (int)($_POST['article_id'] ?? 0);
        if (!$articleId) {
            $this->json(['success' => false], 422);
            return;
        }

        $bookmarked = $this->article->toggleBookmark($articleId, (int)$_SESSION['user_id']);
        $this->json(['success' => true, 'bookmarked' => $bookmarked]);
        return;
    }

    // GET /article/load-more (AJAX)
    public function loadMore(): void
    {
        $page       = max(1, (int)($_GET['page'] ?? 1));
        $categoryId = (int)($_GET['category_id'] ?? 0);
        $result = $categoryId
            ? $this->article->getByCategory($categoryId, $page)
            : ['data' => $this->article->getLatest(6), 'total' => 0, 'pages' => 1];
        $this->json(['success' => true, 'data' => $result['data'], 'pages' => $result['pages']]);
        return;
    }
}
