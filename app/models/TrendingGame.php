<?php
// app/models/TrendingGame.php
// Model for manually managed trending games with upload support


// Autoloaded via core/Autoloader.php (registered in index.php)

/**
 * TrendingGame model
 *
 * @extends \Model
 */
class TrendingGame extends \Model
{
    protected string $table      = 'trending_games';
    protected string $primaryKey = 'id';

    /**
     * Get all trending games ordered by featured rank
     *
     * @param int $limit Number of games to fetch
     * @return array List of trending games
     */
    public function getAllActive(int $limit = 10): array
    {
        // SP: sp_get_all_active_trending_games
        return $this->db->callProc('sp_get_all_active_trending_games', [$limit]);
    }

    /**
     * Get trending games for admin listing with pagination
     *
     * @param int $page Page number
     * @param int $perPage Items per page
     * @return array Paginated games data
     */
    public function getAllAdmin(int $page = 1, int $perPage = 10): array
    {
        $offset = ($page - 1) * $perPage;

        // SP: sp_get_all_trending_games_admin_data
        $data = $this->db->callProc('sp_get_all_trending_games_admin_data', [$perPage, $offset]);

        // SP: sp_get_all_trending_games_admin_count
        $countRows = $this->db->callProc('sp_get_all_trending_games_admin_count', []);
        $total = (int)($countRows[0]['total'] ?? 0);
        $pages = ceil($total / $perPage);

        return [
            'data'  => $data,
            'total' => $total,
            'pages' => $pages,
            'page'  => $page,
        ];
    }

    /**
     * Get a single game by slug
     *
     * @param string $slug Game slug
     * @return array|false Game details or false
     */
    public function getBySlug(string $slug): array|false
    {
        // SP: sp_get_trending_game_by_slug
        $rows = $this->db->callProc('sp_get_trending_game_by_slug', [$slug]);
        return $rows[0] ?? false;
    }

    /**
     * Generate slug from game name
     *
     * @param string $name Game name
     * @return string URL-safe slug
     */
    public function generateSlug(string $name): string
    {
        $slug = strtolower(trim($name));
        $slug = preg_replace('/[^a-z0-9]+/', '-', $slug);
        $slug = trim($slug, '-');
        return $slug;
    }

    /**
     * Count all games
     *
     * @return int Total count
     */
    public function countAll(): int
    {
        return parent::countAll();
    }

    /**
     * Create new trending game
     *
     * @param array $data Game data
     * @return int Game ID
     */
    public function create(array $data): int
    {
        if (empty($data['slug']) && !empty($data['name'])) {
            $data['slug'] = $this->generateSlug($data['name']);
        }
        return $this->insertRecord($data);
    }

    /**
     * Update trending game
     *
     * @param int $id Game ID
     * @param array $data Game data
     * @return int Rows affected
     */
    public function update(int $id, array $data): int
    {
        return $this->updateRecord($id, $data);
    }

    /**
     * Delete trending game
     *
     * @param int $id Game ID
     * @return int Rows affected
     */
    public function delete(int $id): int
    {
        return parent::delete($id);
    }
}
