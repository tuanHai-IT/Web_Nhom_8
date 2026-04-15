<?php
// app/models/UpcomingGame.php
// Model for upcoming game releases


// Autoloaded via core/Autoloader.php (registered in index.php)

/**
 * UpcomingGame model
 *
 * @extends \Model
 */
class UpcomingGame extends \Model
{
    protected string $table      = 'upcoming_games';
    protected string $primaryKey = 'id';

    /**
     * Get upcoming games ordered by release date
     * Limit to featured games for sidebar widget
     *
     * @param int $limit Number of games to fetch
     * @param string $status Filter by status (upcoming|delayed|cancelled)
     * @return array List of upcoming games
     */
    public function getUpcoming(int $limit = 5, string $status = 'upcoming'): array
    {
        // SP: sp_get_upcoming_games
        return $this->db->callProc('sp_get_upcoming_games', [$status, $limit]);
    }

    /**
     * Get featured upcoming games only
     *
     * @param int $limit Number of games to fetch
     * @return array List of featured upcoming games
     */
    public function getFeatured(int $limit = 5): array
    {
        // SP: sp_get_featured_upcoming_games
        return $this->db->callProc('sp_get_featured_upcoming_games', [$limit]);
    }

    /**
     * Get games releasing soon (within next 30 days)
     *
     * @return array List of games releasing soon
     */
    public function getReleasingSoon(): array
    {
        // SP: sp_get_releasing_soon_games
        return $this->db->callProc('sp_get_releasing_soon_games', []);
    }

    /**
     * Get a single game by slug
     *
     * @param string $slug Game slug
     * @return array|false Game details or false if not found
     */
    public function getBySlug(string $slug): array|false
    {
        // SP: sp_get_upcoming_game_by_slug
        $rows = $this->db->callProc('sp_get_upcoming_game_by_slug', [$slug]);
        return $rows[0] ?? false;
    }

    /**
     * Generate slug from game title
     */
    public function generateSlug(string $title): string
    {
        $slug = strtolower(trim($title));
        $slug = preg_replace('/[^a-z0-9]+/', '-', $slug);
        $slug = trim($slug, '-');
        return $slug;
    }

    /**
     * Admin listing with pagination
     */
    public function getAllAdmin(int $page = 1, int $perPage = 10): array
    {
        $offset = ($page - 1) * $perPage;

        // SP: sp_get_all_upcoming_games_admin_data
        $data = $this->db->callProc('sp_get_all_upcoming_games_admin_data', [$perPage, $offset]);

        // SP: sp_get_all_upcoming_games_admin_count
        $countRows = $this->db->callProc('sp_get_all_upcoming_games_admin_count', []);
        $total = (int)($countRows[0]['total'] ?? 0);

        return [
            'data'  => $data,
            'total' => $total,
            'pages' => (int)ceil($total / max(1, $perPage)),
        ];
    }

    /**
     * Create new upcoming game (admin)
     * @param array $data
     * @return int Inserted ID
     */
    public function create(array $data): int
    {
        if (empty($data['slug']) && !empty($data['title'])) {
            $data['slug'] = $this->generateSlug($data['title']);
        }
        return $this->insertRecord($data);
    }

    /**
     * Update upcoming game by id
     * @param int $id
     * @param array $data
     * @return int Rows affected
     */
    public function update(int $id, array $data): int
    {
        return $this->updateRecord($id, $data);
    }

    /**
     * Delete upcoming game by id
     * @param int $id
     * @return int Rows affected
     */
    public function delete(int $id): int
    {
        return parent::delete($id);
    }

    /**
     * Check if a game has been released (past release date)
     *
     * @param int $id Game ID
     * @return bool True if release date has passed
     */
    public function hasReleased(int $id): bool
    {
        // SP: sp_get_upcoming_game_release_date
        $rows = $this->db->callProc('sp_get_upcoming_game_release_date', [$id]);

        if (empty($rows)) return false;

        return strtotime($rows[0]['release_date']) < time();
    }
}
