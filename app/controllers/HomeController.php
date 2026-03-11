<?php
// app/controllers/HomeController.php

require_once BASE_PATH . '/app/models/Article.php';
require_once BASE_PATH . '/app/models/Category.php';
require_once BASE_PATH . '/app/models/Tag.php';

class HomeController extends Controller {

    private Article  $article;
    private Category $category;
    private Tag      $tag;

    public function __construct() {
        $this->article  = new Article();
        $this->category = new Category();
        $this->tag      = new Tag();
    }

    // GET /
    public function index(): void {
        $data = [
            'pageTitle'   => 'GameNexus – Your Ultimate Gaming News Hub',
            'latest'      => $this->article->getLatest(12),
            'featured'    => $this->article->getFeatured(5),
            'breaking'    => $this->article->getBreaking(5),
            'mostViewed'  => $this->article->getMostViewed(5),
            'categories'  => $this->category->all(),
            'popularTags' => $this->tag->getPopular(15),
        ];
        $this->view('pages/home', $data);
    }

    // GET /search  (AJAX: returns JSON)
    public function search(): void {
        $q    = trim($_GET['q'] ?? '');
        $page = max(1, (int)($_GET['page'] ?? 1));

        if (strlen($q) < 2) {
            $this->json(['error' => 'Query too short', 'data' => []]);
            return; // json() calls exit(), but explicit return for clarity
        }

        $result = $this->article->search($q, $page);
        $this->json([
            'data'  => $result['data'],
            'total' => $result['total'],
            'pages' => $result['pages'],
            'page'  => $page,
            'q'     => $q,
        ]);
    }
}
