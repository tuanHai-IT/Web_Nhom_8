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
        return $this->db->fetchOne(
            "SELECT *, tag_name AS name FROM tags WHERE slug = ?",
            [$slug]
        );
    }

    public function getPopular(int $limit = 20): array
    {
        return $this->db->fetchAll(
            "SELECT t.*, t.tag_name AS name, COUNT(at.article_id) AS article_count
             FROM tags t
             JOIN article_tags at ON t.tag_id = at.tag_id
             JOIN articles a ON at.article_id = a.article_id
             WHERE a.status = 'published'
             GROUP BY t.tag_id
             ORDER BY article_count DESC
             LIMIT ?",
            [$limit]
        );
    }

    // Get trending games (top 5 based on article count)
    // Used for sidebar widget to show games with most articles
    public function getTrending(int $limit = 5): array
    {
        return $this->db->fetchAll(
            "SELECT t.*, t.tag_name AS name, COUNT(at.article_id) AS article_count
             FROM tags t
             JOIN article_tags at ON t.tag_id = at.tag_id
             JOIN articles a ON at.article_id = a.article_id
             WHERE a.status = 'published'
             GROUP BY t.tag_id
             ORDER BY article_count DESC, a.published_at DESC
             LIMIT ?",
            [$limit]
        );
    }
}
