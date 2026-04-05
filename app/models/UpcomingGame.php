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
        return $this->db->fetchAll(
            "SELECT * FROM upcoming_games 
             WHERE status = ? 
             ORDER BY is_featured DESC, release_date ASC
             LIMIT ?",
            [$status, $limit]
        );
    }

    /**
     * Get featured upcoming games only
     *
     * @param int $limit Number of games to fetch
     * @return array List of featured upcoming games
     */
    public function getFeatured(int $limit = 5): array
    {
        return $this->db->fetchAll(
            "SELECT * FROM upcoming_games 
             WHERE is_featured = 1 AND status = 'upcoming'
             ORDER BY release_date ASC
             LIMIT ?",
            [$limit]
        );
    }

    /**
     * Get games releasing soon (within next 30 days)
     *
     * @return array List of games releasing soon
     */
    public function getReleasingSoon(): array
    {
        return $this->db->fetchAll(
            "SELECT * FROM upcoming_games 
             WHERE status = 'upcoming' 
             AND release_date BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 30 DAY)
             ORDER BY release_date ASC"
        );
    }

    /**
     * Get a single game by slug
     *
     * @param string $slug Game slug
     * @return array|false Game details or false if not found
     */
    public function getBySlug(string $slug): array|false
    {
        return $this->db->fetchOne(
            "SELECT * FROM upcoming_games WHERE slug = ?",
            [$slug]
        );
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
        $sql = "SELECT * FROM upcoming_games ORDER BY release_date DESC";
        return $this->paginate($sql, [], $page, $perPage);
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
        $game = $this->db->fetchOne(
            "SELECT release_date FROM upcoming_games WHERE id = ?",
            [$id]
        );

        if (!$game) return false;

        return strtotime($game['release_date']) < time();
    }
}
