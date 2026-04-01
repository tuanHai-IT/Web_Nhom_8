<?php
// app/models/Article.php
// FIX: 
//   - categories: category_name (không phải name)
//   - tags: tag_name (không phải name)
//   - ratings: score (không phải rating)

class Article extends Model
{
    protected string $table      = 'articles';
    protected string $primaryKey = 'article_id';

    // Đoạn SELECT dùng chung — alias để view không cần đổi
    private function selectCols(string $extra = ''): string
    {
        return "SELECT a.*, 
                c.category_name AS category_name, c.slug AS category_slug,
                COALESCE(u.full_name, u.username) AS author_name
                {$extra}
                FROM articles a
                JOIN categories c ON a.category_id = c.category_id
                JOIN users u ON a.author_id = u.user_id";
    }

    public function getLatest(int $limit = 10): array
    {
        return $this->db->fetchAll(
            $this->selectCols() . "
            WHERE a.status = 'published'
            ORDER BY a.published_at DESC LIMIT ?",
            [$limit]
        );
    }

    public function getFeatured(int $limit = 5): array
    {
        return $this->db->fetchAll(
            $this->selectCols() . "
            WHERE a.status = 'published' AND a.is_featured = 1
            ORDER BY a.published_at DESC LIMIT ?",
            [$limit]
        );
    }

    public function getBreaking(int $limit = 5): array
    {
        return $this->db->fetchAll(
            "SELECT a.*, c.category_name AS category_name
             FROM articles a
             JOIN categories c ON a.category_id = c.category_id
             WHERE a.status = 'published' AND a.is_breaking = 1
             ORDER BY a.published_at DESC LIMIT ?",
            [$limit]
        );
    }

    public function getMostViewed(int $limit = 5): array
    {
        return $this->db->fetchAll(
            $this->selectCols() . "
            WHERE a.status = 'published'
            ORDER BY a.view_count DESC LIMIT ?",
            [$limit]
        );
    }

    public function getBySlug(string $slug): array|false
    {
        return $this->db->fetchOne(
            "SELECT a.*, 
                    c.category_name AS category_name, c.slug AS category_slug,
                    COALESCE(u.full_name, u.username) AS author_name,
                    u.user_id AS author_user_id
             FROM articles a
             JOIN categories c ON a.category_id = c.category_id
             JOIN users u ON a.author_id = u.user_id
             WHERE a.slug = ? AND a.status = 'published'",
            [$slug]
        );
    }

    public function incrementView(int $id): void
    {
        $this->db->execute(
            "UPDATE articles SET view_count = view_count + 1 WHERE article_id = ?",
            [$id]
        );
    }

    public function getRelated(int $categoryId, int $excludeId, int $limit = 4): array
    {
        return $this->db->fetchAll(
            "SELECT a.*, c.category_name AS category_name, c.slug AS category_slug
             FROM articles a
             JOIN categories c ON a.category_id = c.category_id
             WHERE a.category_id = ? AND a.article_id != ? AND a.status = 'published'
             ORDER BY a.published_at DESC LIMIT ?",
            [$categoryId, $excludeId, $limit]
        );
    }

    public function getByCategory(int $categoryId, int $page = 1, int $perPage = 9): array
    {
        $sql = $this->selectCols() . "
               WHERE a.category_id = ? AND a.status = 'published'
               ORDER BY a.published_at DESC";
        return $this->paginate($sql, [$categoryId], $page, $perPage);
    }

    public function getByTag(int $tagId, int $page = 1, int $perPage = 9): array
    {
        $sql = "SELECT a.*, c.category_name AS category_name, c.slug AS category_slug,
                       COALESCE(u.full_name, u.username) AS author_name
                FROM articles a
                JOIN categories c ON a.category_id = c.category_id
                JOIN users u ON a.author_id = u.user_id
                JOIN article_tags at ON a.article_id = at.article_id
                WHERE at.tag_id = ? AND a.status = 'published'
                ORDER BY a.published_at DESC";
        return $this->paginate($sql, [$tagId], $page, $perPage);
    }

    public function search(string $query, int $page = 1, int $perPage = 10): array
    {
        $like = "%{$query}%";
        $sql  = $this->selectCols() . "
                WHERE a.status = 'published'
                  AND (a.title LIKE ? OR a.summary LIKE ? OR a.content LIKE ?)
                ORDER BY a.published_at DESC";
        return $this->paginate($sql, [$like, $like, $like], $page, $perPage);
    }

    public function getTags(int $articleId): array
    {
        return $this->db->fetchAll(
            "SELECT t.*, t.tag_name AS name FROM tags t
             JOIN article_tags at ON t.tag_id = at.tag_id
             WHERE at.article_id = ?",
            [$articleId]
        );
    }

    public function getAllAdmin(int $page = 1, int $perPage = 15): array
    {
        $sql = "SELECT a.*, c.category_name AS category_name,
                       COALESCE(u.full_name, u.username) AS author_name
                FROM articles a
                JOIN categories c ON a.category_id = c.category_id
                JOIN users u ON a.author_id = u.user_id
                ORDER BY a.created_at DESC";
        return $this->paginate($sql, [], $page, $perPage);
    }

    public function create(array $data): int
    {
        return $this->db->insert(
            "INSERT INTO articles
                (title, slug, summary, content, thumbnail, category_id, author_id,
                 status, is_featured, is_breaking, meta_title, meta_description, published_at)
             VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)",
            [
                $data['title'],
                $data['slug'],
                $data['summary'] ?? '',
                $data['content'],
                $data['thumbnail'] ?? null,
                $data['category_id'],
                $data['author_id'],
                $data['status'] ?? 'draft',
                (int)($data['is_featured'] ?? 0),
                (int)($data['is_breaking'] ?? 0),
                $data['meta_title'] ?? $data['title'],
                $data['meta_description'] ?? ($data['summary'] ?? ''),
                ($data['status'] ?? '') === 'published' ? date('Y-m-d H:i:s') : null
            ]
        );
    }

    public function update(int $id, array $data): int
    {
        return $this->db->execute(
            "UPDATE articles SET title=?, slug=?, summary=?, content=?, thumbnail=?,
             category_id=?, status=?, is_featured=?, is_breaking=?,
             meta_title=?, meta_description=?, updated_at=NOW()
             WHERE article_id=?",
            [
                $data['title'],
                $data['slug'],
                $data['summary'] ?? '',
                $data['content'],
                $data['thumbnail'] ?? null,
                $data['category_id'],
                $data['status'] ?? 'draft',
                (int)($data['is_featured'] ?? 0),
                (int)($data['is_breaking'] ?? 0),
                $data['meta_title'] ?? $data['title'],
                $data['meta_description'] ?? ($data['summary'] ?? ''),
                $id
            ]
        );
    }

    // FIX: ratings dùng cột `score`, không phải `rating`
    public function getAvgRating(int $articleId): float
    {
        $row = $this->db->fetchOne(
            "SELECT AVG(score) as avg_rating FROM ratings WHERE article_id = ?",
            [$articleId]
        );
        return round((float)($row['avg_rating'] ?? 0), 1);
    }

    public function getUserRating(int $articleId, int $userId): int
    {
        $row = $this->db->fetchOne(
            "SELECT score FROM ratings WHERE article_id = ? AND user_id = ?",
            [$articleId, $userId]
        );
        return (int)($row['score'] ?? 0);
    }

    public function rateArticle(int $articleId, int $userId, int $rating): void
    {
        $this->db->execute(
            "INSERT INTO ratings (article_id, user_id, score)
             VALUES (?,?,?)
             ON DUPLICATE KEY UPDATE score = VALUES(score)",
            [$articleId, $userId, $rating]
        );
    }

    public function isBookmarked(int $articleId, int $userId): bool
    {
        return (bool)$this->db->fetchOne(
            "SELECT 1 FROM bookmarks WHERE article_id = ? AND user_id = ?",
            [$articleId, $userId]
        );
    }

    public function toggleBookmark(int $articleId, int $userId): bool
    {
        if ($this->isBookmarked($articleId, $userId)) {
            $this->db->execute(
                "DELETE FROM bookmarks WHERE article_id = ? AND user_id = ?",
                [$articleId, $userId]
            );
            return false;
        }
        $this->db->execute(
            "INSERT INTO bookmarks (article_id, user_id) VALUES (?,?)",
            [$articleId, $userId]
        );
        return true;
    }

    public function getUserBookmarks(int $userId): array
    {
        return $this->db->fetchAll(
            "SELECT a.*, c.category_name AS category_name, c.slug AS category_slug
             FROM articles a
             JOIN categories c ON a.category_id = c.category_id
             JOIN bookmarks b ON a.article_id = b.article_id
             WHERE b.user_id = ? AND a.status = 'published'
             ORDER BY b.created_at DESC",
            [$userId]
        );
    }

    public function generateSlug(string $title): string
    {
        $slug = strtolower(trim(preg_replace('/[^A-Za-z0-9-]+/', '-', $title), '-'));
        $original = $slug;
        $i = 1;
        while ($this->db->fetchOne("SELECT 1 FROM articles WHERE slug = ?", [$slug])) {
            $slug = $original . '-' . $i++;
        }
        return $slug;
    }
    /**
     * Lưu lịch sử đọc bài viết
     * Dùng INSERT ... ON DUPLICATE KEY để update read_at nếu đọc lại
     */
    public function addReadHistory(int $articleId, int $userId): void
    {
        $this->db->execute(
            "INSERT INTO read_history (user_id, article_id, read_at)
         VALUES (?, ?, NOW())
         ON DUPLICATE KEY UPDATE read_at = NOW()",
            [$userId, $articleId]
        );
    }

    /**
     * Lấy lịch sử đọc của user, mới nhất trước
     */
    public function getReadHistory(int $userId, int $limit = 20): array
    {
        return $this->db->fetchAll(
            "SELECT a.*, c.category_name AS category_name, c.slug AS category_slug,
                rh.read_at
         FROM read_history rh
         JOIN articles a ON rh.article_id = a.article_id
         JOIN categories c ON a.category_id = c.category_id
         WHERE rh.user_id = ? AND a.status = 'published'
         ORDER BY rh.read_at DESC
         LIMIT ?",
            [$userId, $limit]
        );
    }
}
