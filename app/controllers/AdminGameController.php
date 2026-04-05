<?php
// app/controllers/AdminGameController.php
// Admin management for Upcoming Games and Trending Games
// Includes image upload and CRUD operations

// Autoloaded via core/Autoloader.php (registered in index.php)

/**
 * AdminGameController
 *
 * @property \UpcomingGame $upcomingGame
 * @property \TrendingGame $trendingGame
 */
class AdminGameController extends \Controller
{

    private \UpcomingGame $upcomingGame;
    private \TrendingGame $trendingGame;

    public function __construct()
    {
        $this->upcomingGame = new \UpcomingGame();
        $this->trendingGame = new \TrendingGame();
    }

    // ── UPCOMING GAMES ──────────────────────────────────────────────────────

    /**
     * List all upcoming games with pagination
     */
    public function upcomingGames(): void
    {
        $page   = max(1, (int)($_GET['page'] ?? 1));
        $result = $this->upcomingGame->getAllAdmin($page);

        $this->view('admin/games/upcoming-games', [
            'pageTitle'   => 'Manage Upcoming Games',
            'games'       => $result['data'],
            'totalPages'  => $result['pages'],
            'currentPage' => $page,
        ], 'admin');
    }

    /**
     * Show create upcoming game form
     */
    public function createUpcomingGameForm(): void
    {
        $this->view('admin/games/upcoming-game-form', [
            'pageTitle' => 'Add Upcoming Game',
            'game'      => null,
        ], 'admin');
    }

    /**
     * Store new upcoming game
     */
    public function storeUpcomingGame(): void
    {
        $title  = $this->input('title');
        $slug   = $this->input('slug') ?: $this->upcomingGame->generateSlug($title);

        $image = $this->handleUpload('games');

        $data = [
            'title'       => $title,
            'slug'        => $slug,
            'release_date' => $_POST['release_date'] ?? null,
            'platform'    => $this->input('platform'),
            'description' => $this->input('description'),
            'image'       => $image,
            'status'      => $this->input('status', 'upcoming'),
            'is_featured' => isset($_POST['is_featured']) ? 1 : 0,
        ];

        $this->upcomingGame->create($data);
        \Logger::log('game.upcoming.create', "Created upcoming game: {$title}");
        $this->redirect('/admin/upcoming-games');
    }

    /**
     * Show edit upcoming game form
     */
    public function editUpcomingGameForm(string $id): void
    {
        $game = $this->upcomingGame->find((int)$id);
        if (!$game) {
            $this->abort(404, 'Game not found');
            return;
        }

        $this->view('admin/games/upcoming-game-form', [
            'pageTitle' => 'Edit Upcoming Game',
            'game'      => $game,
        ], 'admin');
    }

    /**
     * Update upcoming game
     */
    public function updateUpcomingGame(string $id): void
    {
        $game = $this->upcomingGame->find((int)$id);
        if (!$game) {
            $this->abort(404);
            return;
        }

        $title = $this->input('title');
        $image = $this->handleUpload('games') ?? $game['image'] ?? null;
        $slug = $this->input('slug') ?: $game['slug'];

        $data = [
            'title'       => $title,
            'slug'        => $slug,
            'release_date' => $_POST['release_date'] ?? $game['release_date'],
            'platform'    => $this->input('platform'),
            'description' => $this->input('description'),
            'image'       => $image,
            'status'      => $this->input('status', 'upcoming'),
            'is_featured' => isset($_POST['is_featured']) ? 1 : 0,
        ];

        $this->upcomingGame->update((int)$id, $data);
        \Logger::log('game.upcoming.update', "Updated upcoming game #{$id}: {$title}");
        $this->redirect('/admin/upcoming-games');
    }

    /**
     * Delete upcoming game
     */
    public function deleteUpcomingGame(string $id): void
    {
        $game = $this->upcomingGame->find((int)$id);
        if (!$game) {
            $this->json(['success' => false, 'message' => 'Game not found'], 404);
            return;
        }

        $this->upcomingGame->delete((int)$id);
        \Logger::log('game.upcoming.delete', "Deleted upcoming game #{$id}");
        $this->json(['success' => true]);
        return;
    }

    // ── TRENDING GAMES ─────────────────────────────────────────────────────

    /**
     * List all trending games with pagination
     */
    public function trendingGames(): void
    {
        $page   = max(1, (int)($_GET['page'] ?? 1));
        $result = $this->trendingGame->getAllAdmin($page);

        $this->view('admin/games/trending-games', [
            'pageTitle'   => 'Manage Trending Games',
            'games'       => $result['data'],
            'totalPages'  => $result['pages'],
            'currentPage' => $page,
        ], 'admin');
    }

    /**
     * Show create trending game form
     */
    public function createTrendingGameForm(): void
    {
        $this->view('admin/games/trending-game-form', [
            'pageTitle' => 'Add Trending Game',
            'game'      => null,
        ], 'admin');
    }

    /**
     * Store new trending game
     */
    public function storeTrendingGame(): void
    {
        $name  = $this->input('name');
        $slug  = $this->input('slug') ?: $this->trendingGame->generateSlug($name);

        $thumbnail = $this->handleUpload('games');

        $data = [
            'name'           => $name,
            'slug'           => $slug,
            'thumbnail'      => $thumbnail,
            'article_count'  => (int)($_POST['article_count'] ?? 0),
            'featured_rank'  => (int)($_POST['featured_rank'] ?? 999),
            'is_Active'      => isset($_POST['is_Active']) ? 1 : 0,
        ];

        $this->trendingGame->create($data);
        \Logger::log('game.trending.create', "Created trending game: {$name}");
        $this->redirect('/admin/trending-games');
    }

    /**
     * Show edit trending game form
     */
    public function editTrendingGameForm(string $id): void
    {
        $game = $this->trendingGame->find((int)$id);
        if (!$game) {
            $this->abort(404, 'Game not found');
            return;
        }

        $this->view('admin/games/trending-game-form', [
            'pageTitle' => 'Edit Trending Game',
            'game'      => $game,
        ], 'admin');
    }

    /**
     * Update trending game
     */
    public function updateTrendingGame(string $id): void
    {
        $game = $this->trendingGame->find((int)$id);
        if (!$game) {
            $this->abort(404);
            return;
        }

        $name = $this->input('name');
        $thumbnail = $this->handleUpload('games') ?? $game['thumbnail'];
        $slug = $this->input('slug') ?: $game['slug'];

        $data = [
            'name'           => $name,
            'slug'           => $slug,
            'thumbnail'      => $thumbnail,
            'article_count'  => (int)($_POST['article_count'] ?? $game['article_count']),
            'featured_rank'  => (int)($_POST['featured_rank'] ?? $game['featured_rank']),
            'is_Active'      => isset($_POST['is_Active']) ? 1 : 0,
        ];

        $this->trendingGame->update((int)$id, $data);
        \Logger::log('game.trending.update', "Updated trending game #{$id}: {$name}");
        $this->redirect('/admin/trending-games');
    }

    /**
     * Delete trending game
     */
    public function deleteTrendingGame(string $id): void
    {
        $game = $this->trendingGame->find((int)$id);
        if (!$game) {
            $this->json(['success' => false, 'message' => 'Game not found'], 404);
            return;
        }

        $this->trendingGame->delete((int)$id);
        \Logger::log('game.trending.delete', "Deleted trending game #{$id}");
        $this->json(['success' => true]);
        return;
    }

    // ── HELPERS ────────────────────────────────────────────────────────────

    /**
     * Handle game image file upload
     * Saves images to /public/images/uploads/games/
     * 
     * @param string $subdir Subdirectory (e.g., 'games')
     * @return string|null Relative URL to uploaded image or null
     */
    private function handleUpload(string $subdir = 'games'): ?string
    {
        // Check if file was uploaded
        if (empty($_FILES['image']['tmp_name']) || $_FILES['image']['error'] !== UPLOAD_ERR_OK) {
            return null;
        }

        $file    = $_FILES['image'];
        $allowed = ['image/jpeg', 'image/png', 'image/webp', 'image/gif'];
        $mime    = mime_content_type($file['tmp_name']);

        // Validate MIME type
        if (!in_array($mime, $allowed)) {
            \Logger::log('game.upload.error', "Invalid MIME type: {$mime}");
            return null;
        }

        // Validate file size (2MB max per spec)
        $maxSize = 2 * 1024 * 1024;
        if ($file['size'] > $maxSize) {
            \Logger::log('game.upload.error', "File too large: {$file['size']} bytes");
            return null;
        }

        // Create upload directory if needed
        $uploadDir = BASE_PATH . DIRECTORY_SEPARATOR . 'public'
            . DIRECTORY_SEPARATOR . 'images'
            . DIRECTORY_SEPARATOR . 'uploads' . DIRECTORY_SEPARATOR
            . $subdir . DIRECTORY_SEPARATOR;

        if (!is_dir($uploadDir)) {
            mkdir($uploadDir, 0755, true);
        }

        if (!is_writable($uploadDir)) {
            \Logger::log('game.upload.error', "Upload directory not writable: {$uploadDir}");
            return null;
        }

        // Validate file extension
        $allowed_ext = ['jpg', 'jpeg', 'png', 'webp', 'gif'];
        $ext = strtolower(pathinfo($file['name'], PATHINFO_EXTENSION));
        if (!in_array($ext, $allowed_ext)) {
            \Logger::log('game.upload.error', "Invalid file extension: {$ext}");
            return null;
        }

        // Generate unique filename to prevent overwrites
        $filename = 'game_' . uniqid() . '_' . time() . '.' . $ext;
        $dest     = $uploadDir . $filename;

        if (move_uploaded_file($file['tmp_name'], $dest)) {
            $relativePath = 'public/images/uploads/' . $subdir . '/' . $filename;
            \Logger::log('game.upload.success', "Uploaded: {$relativePath}");
            return $relativePath;
        }

        \Logger::log('game.upload.error', "Failed to move uploaded file to: {$dest}");
        return null;
    }
}
