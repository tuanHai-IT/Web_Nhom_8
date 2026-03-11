<?php
// app/controllers/ArticleController.php

require_once BASE_PATH . '/app/models/Article.php';
require_once BASE_PATH . '/app/models/Comment.php';
require_once BASE_PATH . '/app/models/Category.php';
require_once BASE_PATH . '/app/models/Tag.php';

class ArticleController extends Controller {

    private Article  $article;
    private Comment  $comment;
    private Category $category;
    private Tag      $tag;

    public function __construct() {
        $this->article  = new Article();
        $this->comment  = new Comment();
        $this->category = new Category();
        $this->tag      = new Tag();
    }

    // GET /article/:slug
    public function show(string $slug): void {
        $article = $this->article->getBySlug($slug);
        if (!$article) { $this->abort(404, 'Article not found'); }

        // Increment view count
        $this->article->incrementView((int)$article['article_id']);

        $userId   = $_SESSION['user_id'] ?? 0;
        $avgRating = $this->article->getAvgRating($article['article_id']);
        $userRating = $userId ? $this->article->getUserRating($article['article_id'], $userId) : 0;
        $bookmarked = $userId ? $this->article->isBookmarked($article['article_id'], $userId) : false;

        $data = [
            'pageTitle'  => $article['title'] . ' – GameNexus',
            'article'    => $article,
            'tags'       => $this->article->getTags($article['article_id']),
            'related'    => $this->article->getRelated($article['category_id'], $article['article_id']),
            'comments'   => $this->comment->getApproved($article['article_id']),
            'categories' => $this->category->all(),
            'avgRating'  => $avgRating,
            'userRating' => $userRating,
            'bookmarked' => $bookmarked,
            'popularTags'=> $this->tag->getPopular(10),
        ];
        $this->view('pages/article', $data);
    }

    // ── AJAX endpoints ────────────────────────────────────────────────────

    // POST /article/comment  → submit comment (AJAX)
    public function submitComment(): void {
        $this->requireAuth();
        $articleId = (int)($_POST['article_id'] ?? 0);
        $content   = trim($_POST['content'] ?? '');

        if (!$articleId || strlen($content) < 3) {
            $this->json(['success' => false, 'message' => 'Invalid input'], 422);
        }

        $id = $this->comment->create($articleId, (int)$_SESSION['user_id'], $content);
        $this->json([
            'success'  => true,
            'message'  => 'Comment submitted for moderation.',
            'id'       => $id,
            'username' => $_SESSION['username'] ?? 'You',
            'content'  => htmlspecialchars($content),
            'date'     => date('M d, Y'),
        ]);
    }

    // POST /article/rate  → rate article (AJAX)
    public function rate(): void {
        $this->requireAuth();
        $articleId = (int)($_POST['article_id'] ?? 0);
        $rating    = max(1, min(5, (int)($_POST['rating'] ?? 0)));

        if (!$articleId) { $this->json(['success' => false], 422); }

        $this->article->rateArticle($articleId, (int)$_SESSION['user_id'], $rating);
        $avg = $this->article->getAvgRating($articleId);
        $this->json(['success' => true, 'avg' => $avg, 'your_rating' => $rating]);
    }

    // POST /article/bookmark  → toggle bookmark (AJAX)
    public function bookmark(): void {
        $this->requireAuth();
        $articleId = (int)($_POST['article_id'] ?? 0);
        if (!$articleId) { $this->json(['success' => false], 422); }

        $bookmarked = $this->article->toggleBookmark($articleId, (int)$_SESSION['user_id']);
        $this->json(['success' => true, 'bookmarked' => $bookmarked]);
    }

    // GET /article/load-more?page=N&category_id=N (AJAX)
    public function loadMore(): void {
        $page       = max(1, (int)($_GET['page'] ?? 1));
        $categoryId = (int)($_GET['category_id'] ?? 0);
        $result = $categoryId
            ? $this->article->getByCategory($categoryId, $page)
            : ['data' => $this->article->getLatest(6), 'total' => 0, 'pages' => 1];
        $this->json(['success' => true, 'data' => $result['data'], 'pages' => $result['pages']]);
    }
}
