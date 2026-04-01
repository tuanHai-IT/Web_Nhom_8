<?php
// app/controllers/TagController.php

class TagController extends Controller {

    private Article  $article;
    private Tag      $tag;
    private Category $category;

    public function __construct() {
        $this->article  = new Article();
        $this->tag      = new Tag();
        $this->category = new Category();
    }

    public function show(string $slug): void {
        $tag = $this->tag->getBySlug($slug);
        if (!$tag) { $this->abort(404, 'Tag not found'); return; }

        $page   = max(1, (int)($_GET['page'] ?? 1));
        $result = $this->article->getByTag($tag['tag_id'], $page);

        $this->view('pages/tag', [
            'pageTitle'       => '#' . ($tag['name'] ?? $tag['tag_name']) . ' – GameNexus',
            'metaDescription' => 'Articles tagged with ' . htmlspecialchars($tag['name'] ?? $tag['tag_name']),
            'tag'         => $tag,
            'articles'    => $result['data'],
            'totalPages'  => $result['pages'],
            'total'       => $result['total'],
            'currentPage' => $page,
            'categories'  => $this->category->all(),
            'popularTags' => $this->tag->getPopular(15),
            'breaking'    => $this->article->getBreaking(5),
        ]);
    }
}
