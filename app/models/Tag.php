<?php
// app/models/Tag.php
// FIX: DB dùng tag_name thay vì name


// Autoloaded via core/Autoloader.php (registered in index.php)

/**
 * Tag model
 *
 * @extends \Model
 */
class Tag extends \Model
{
    protected string $table      = 'tags';
    protected string $primaryKey = 'tag_id';

    public function getBySlug(string $slug): array|false
    {
        // SP: sp_get_tag_by_slug
        $rows = $this->db->callProc('sp_get_tag_by_slug', [$slug]);
        return $rows[0] ?? false;
    }

    public function getPopular(int $limit = 20): array
    {
        // SP: sp_get_popular_tags
        return $this->db->callProc('sp_get_popular_tags', [$limit]);
    }

    // Get trending games (top 5 based on article count)
    // Used for sidebar widget to show games with most articles
    public function getTrending(int $limit = 5): array
    {
        // SP: sp_get_trending_tags
        return $this->db->callProc('sp_get_trending_tags', [$limit]);
    }
}
