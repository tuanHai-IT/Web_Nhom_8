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

    public function getLatest(int $limit = 10): array
    {
        // SP: sp_get_latest_articles
        return $this->db->callProc('sp_get_latest_articles', [$limit]);
    }

    public function getFeatured(int $limit = 5): array
    {
        // SP: sp_get_featured_articles
        return $this->db->callProc('sp_get_featured_articles', [$limit]);
    }

    public function getBreaking(int $limit = 5): array
    {
        // SP: sp_get_breaking_articles
        return $this->db->callProc('sp_get_breaking_articles', [$limit]);
    }

    public function getMostViewed(int $limit = 5): array
    {
        // SP: sp_get_most_viewed_articles
        return $this->db->callProc('sp_get_most_viewed_articles', [$limit]);
    }

    public function getBySlug(string $slug): array|false
    {
        // SP: sp_get_article_by_slug
        $rows = $this->db->callProc('sp_get_article_by_slug', [$slug]);
        return $rows[0] ?? false;
    }

    public function incrementView(int $id): void
    {
        // SP: sp_increment_article_view
        $this->db->callProc('sp_increment_article_view', [$id]);
    }

    public function getRelated(int $categoryId, int $excludeId, int $limit = 4): array
    {
        // SP: sp_get_related_articles
        return $this->db->callProc('sp_get_related_articles', [$categoryId, $excludeId, $limit]);
    }

    public function getByCategory(int $categoryId, int $page = 1, int $perPage = 9): array
    {
        $offset = ($page - 1) * $perPage;

        // SP: sp_get_articles_by_category_data
        $data  = $this->db->callProc('sp_get_articles_by_category_data', [$categoryId, $perPage, $offset]);

        // SP: sp_get_articles_by_category_count
        $countRows = $this->db->callProc('sp_get_articles_by_category_count', [$categoryId]);
        $total = (int)($countRows[0]['total'] ?? 0);

        return [
            'data'  => $data,
            'total' => $total,
            'pages' => (int)ceil($total / max(1, $perPage)),
        ];
    }

    public function getByTag(int $tagId, int $page = 1, int $perPage = 9): array
    {
        $offset = ($page - 1) * $perPage;

        // SP: sp_get_articles_by_tag_data
        $data = $this->db->callProc('sp_get_articles_by_tag_data', [$tagId, $perPage, $offset]);

        // SP: sp_get_articles_by_tag_count
        $countRows = $this->db->callProc('sp_get_articles_by_tag_count', [$tagId]);
        $total = (int)($countRows[0]['total'] ?? 0);

        return [
            'data'  => $data,
            'total' => $total,
            'pages' => (int)ceil($total / max(1, $perPage)),
        ];
    }

    public function search(string $query, int $page = 1, int $perPage = 10): array
    {
        $like   = "%{$query}%";
        $offset = ($page - 1) * $perPage;

        // SP: sp_search_articles_data
        $data = $this->db->callProc('sp_search_articles_data', [$like, $perPage, $offset]);

        // SP: sp_search_articles_count
        $countRows = $this->db->callProc('sp_search_articles_count', [$like]);
        $total = (int)($countRows[0]['total'] ?? 0);

        return [
            'data'  => $data,
            'total' => $total,
            'pages' => (int)ceil($total / max(1, $perPage)),
        ];
    }

    public function getTags(int $articleId): array
    {
        // SP: sp_get_article_tags
        return $this->db->callProc('sp_get_article_tags', [$articleId]);
    }

    public function getAllAdmin(int $page = 1, int $perPage = 15): array
    {
        $offset = ($page - 1) * $perPage;

        // SP: sp_get_all_articles_admin_data
        $data = $this->db->callProc('sp_get_all_articles_admin_data', [$perPage, $offset]);

        // SP: sp_get_all_articles_admin_count
        $countRows = $this->db->callProc('sp_get_all_articles_admin_count', []);
        $total = (int)($countRows[0]['total'] ?? 0);

        return [
            'data'  => $data,
            'total' => $total,
            'pages' => (int)ceil($total / max(1, $perPage)),
        ];
    }

    public function create(array $data): int
    {
        $publishedAt = ($data['status'] ?? '') === 'published' ? date('Y-m-d H:i:s') : null;

        // SP: sp_create_article
        $rows = $this->db->callProc('sp_create_article', [
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
            $publishedAt,
        ]);
        return (int)($rows[0]['new_id'] ?? 0);
    }

    public function update(int $id, array $data): int
    {
        // SP: sp_update_article
        $this->db->callProc('sp_update_article', [
            $id,
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
        ]);
        return 1;
    }

    // FIX: ratings dùng cột `score`, không phải `rating`
    public function getAvgRating(int $articleId): float
    {
        // SP: sp_get_avg_rating
        $rows = $this->db->callProc('sp_get_avg_rating', [$articleId]);
        return round((float)($rows[0]['avg_rating'] ?? 0), 1);
    }

    public function getUserRating(int $articleId, int $userId): int
    {
        // SP: sp_get_user_rating
        $rows = $this->db->callProc('sp_get_user_rating', [$articleId, $userId]);
        return (int)($rows[0]['score'] ?? 0);
    }

    public function rateArticle(int $articleId, int $userId, int $rating): void
    {
        // SP: sp_rate_article
        $this->db->callProc('sp_rate_article', [$articleId, $userId, $rating]);
    }

    public function isBookmarked(int $articleId, int $userId): bool
    {
        // SP: sp_is_bookmarked
        $rows = $this->db->callProc('sp_is_bookmarked', [$articleId, $userId]);
        return !empty($rows);
    }

    public function toggleBookmark(int $articleId, int $userId): bool
    {
        if ($this->isBookmarked($articleId, $userId)) {
            // SP: sp_delete_bookmark
            $this->db->callProc('sp_delete_bookmark', [$articleId, $userId]);
            return false;
        }
        // SP: sp_add_bookmark
        $this->db->callProc('sp_add_bookmark', [$articleId, $userId]);
        return true;
    }

    public function getUserBookmarks(int $userId): array
    {
        // SP: sp_get_user_bookmarks
        return $this->db->callProc('sp_get_user_bookmarks', [$userId]);
    }

    public function generateSlug(string $title): string
    {
        $slug     = strtolower(trim(preg_replace('/[^A-Za-z0-9-]+/', '-', $title), '-'));
        $original = $slug;
        $i = 1;
        // SP: sp_check_article_slug
        while (!empty($this->db->callProc('sp_check_article_slug', [$slug]))) {
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
        // SP: sp_add_read_history
        $this->db->callProc('sp_add_read_history', [$userId, $articleId]);
    }

    /**
     * Lấy lịch sử đọc của user, mới nhất trước
     */
    public function getReadHistory(int $userId, int $limit = 20): array
    {
        // SP: sp_get_read_history
        return $this->db->callProc('sp_get_read_history', [$userId, $limit]);
    }
}
