<?php
// app/controllers/HomeController.php

// Autoloaded via core/Autoloader.php (registered in index.php)

/**
 * HomeController
 *
 * @property \Article $article
 * @property \Category $category
 * @property \Tag $tag
 * @property \UpcomingGame $upcomingGame
 */
class HomeController extends \Controller
{

    private \Article      $article;
    private \Category     $category;
    private \Tag          $tag;
    private \UpcomingGame $upcomingGame;

    public function __construct()
    {
        $this->article       = new \Article();
        $this->category      = new \Category();
        $this->tag           = new \Tag();
        $this->upcomingGame  = new \UpcomingGame();
    }

    // GET /
    public function index(): void
    {
        $data = [
            'pageTitle'       => 'GameNexus – Your Ultimate Gaming News Hub',
            'metaDescription' => 'GameNexus — the latest gaming news, reviews, previews, guides, and esports coverage.',
            'latest'          => $this->article->getLatest(12),
            'featured'        => $this->article->getFeatured(5),
            'breaking'        => $this->article->getBreaking(5),
            'mostViewed'      => $this->article->getMostViewed(5),
            'categories'      => $this->category->all(),
            'popularTags'     => $this->tag->getPopular(15),
            'trendingGames'   => $this->tag->getTrending(5),
            'upcomingGames'   => $this->upcomingGame->getUpcoming(5),
        ];
        $this->view('pages/home', $data);
    }

    // GET /search  (AJAX: returns JSON)
    public function search(): void
    {
        // Rate limit: max 30 searches per minute
        \RateLimiter::enforce('search', 30, 60);

        $q    = trim($_GET['q'] ?? '');
        $page = max(1, (int)($_GET['page'] ?? 1));

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
}
