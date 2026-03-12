<?php
// app/controllers/TagController.php

require_once BASE_PATH . '/app/models/Article.php';
require_once BASE_PATH . '/app/models/Tag.php';
require_once BASE_PATH . '/app/models/Category.php';

class TagController extends Controller {

    private Article  $article;
    private Tag      $tag;
    private Category $category;

    public function __construct() {
        $this->article  = new Article();
        $this->tag      = new Tag();
        $this->category = new Category();
    }

    // GET /tag/:slug
    public function show(string $slug): void {
        $tag = $this->tag->getBySlug($slug);
        if (!$tag) { $this->abort(404, 'Tag not found'); }

        $page   = max(1, (int)($_GET['page'] ?? 1));
        $result = $this->article->getByTag($tag['tag_id'], $page);

        $this->view('pages/tag', [
            'pageTitle'  => '#' . ($tag['name'] ?? $tag['tag_name']) . ' – GameNexus',
            'tag'        => $tag,
            'articles'   => $result['data'],
            'totalPages' => $result['pages'],
            'total'      => $result['total'],
            'currentPage'=> $page,
            'categories' => $this->category->all(),
            'popularTags'=> $this->tag->getPopular(15),
        ]);
    }
}
