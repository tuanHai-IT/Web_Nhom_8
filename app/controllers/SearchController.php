<?php
// app/controllers/SearchController.php

class SearchController extends Controller {

    private Article  $article;
    private Category $category;
    private Tag      $tag;

    public function __construct() {
        $this->article  = new Article();
        $this->category = new Category();
        $this->tag      = new Tag();
    }

    // GET /search
    public function index(): void {
        $q    = trim($_GET['q'] ?? '');
        $page = max(1, (int)($_GET['page'] ?? 1));

        // AJAX autocomplete requests — return JSON (keep existing behaviour)
        if ($this->isAjax()) {
            RateLimiter::enforce('search', 30, 60);

            if (strlen($q) < 2) {
                $this->json(['error' => 'Query too short', 'data' => []]);
                return;
            }

            $result = $this->article->search($q, $page);
            $this->json([
                'data'  => $result['data'],
                'total' => $result['total'],
                'pages' => $result['pages'],
                'page'  => $page,
                'q'     => $q,
            ]);
            return;
        }

        // Full-page search results
        $result   = [];
        $total    = 0;
        $pages    = 1;
        $articles = [];

        if (strlen($q) >= 2) {
            $result   = $this->article->search($q, $page);
            $articles = $result['data'];
            $total    = $result['total'];
            $pages    = $result['pages'];
        }

        $this->view('pages/search', [
            'pageTitle'       => 'Tìm kiếm: ' . htmlspecialchars($q) . ' – GameNexus',
            'metaDescription' => 'Kết quả tìm kiếm cho "' . htmlspecialchars($q) . '" trên GameNexus.',
            'q'           => $q,
            'articles'    => $articles,
            'total'       => $total,
            'totalPages'  => $pages,
            'currentPage' => $page,
            'categories'  => $this->category->all(),
            'popularTags' => $this->tag->getPopular(10),
            'breaking'    => $this->article->getBreaking(5),
        ]);
    }
}
