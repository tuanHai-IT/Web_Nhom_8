<?php
// app/controllers/CategoryController.php

require_once BASE_PATH . '/app/models/Article.php';
require_once BASE_PATH . '/app/models/Category.php';
require_once BASE_PATH . '/app/models/Tag.php';

class CategoryController extends Controller {

    private Article  $article;
    private Category $category;
    private Tag      $tag;

    public function __construct() {
        $this->article  = new Article();
        $this->category = new Category();
        $this->tag      = new Tag();
    }

    // GET /category/:slug
    public function show(string $slug): void {
        $category = $this->category->getBySlug($slug);
        if (!$category) { $this->abort(404, 'Category not found'); }

        $page   = max(1, (int)($_GET['page'] ?? 1));
        $result = $this->article->getByCategory($category['category_id'], $page);

        $this->view('pages/category', [
            'pageTitle'  => ($category['name'] ?? $category['category_name']) . ' – GameNexus',
            'category'   => $category,
            'articles'   => $result['data'],
            'totalPages' => $result['pages'],
            'total'      => $result['total'],
            'currentPage'=> $page,
            'categories' => $this->category->all(),
            'popularTags'=> $this->tag->getPopular(10),
        ]);
    }
}
