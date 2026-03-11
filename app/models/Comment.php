<?php
// app/models/Comment.php

class Comment extends Model {
    protected string $table      = 'comments';
    protected string $primaryKey = 'comment_id';

    public function getApproved(int $articleId): array {
        return $this->db->fetchAll(
            "SELECT c.*, u.username, u.avatar
             FROM comments c
             JOIN users u ON c.user_id = u.user_id
             WHERE c.article_id = ? AND c.is_approved = 1
             ORDER BY c.created_at ASC",
            [$articleId]
        );
    }

    public function create(int $articleId, int $userId, string $content): int {
        return $this->db->insert(
            "INSERT INTO comments (article_id, user_id, content, is_approved)
             VALUES (?,?,?,0)",
            [$articleId, $userId, $content]
        );
    }

    public function getAllAdmin(int $page = 1, int $perPage = 20): array {
        $sql = "SELECT c.*, u.username, a.title AS article_title, a.slug AS article_slug
                FROM comments c
                JOIN users u ON c.user_id = u.user_id
                JOIN articles a ON c.article_id = a.article_id
                ORDER BY c.created_at DESC";
        return $this->paginate($sql, [], $page, $perPage);
    }

    public function approve(int $id): int {
        return $this->db->execute(
            "UPDATE comments SET is_approved = 1 WHERE comment_id = ?", [$id]
        );
    }

    public function getPendingCount(): int {
        $row = $this->db->fetchOne(
            "SELECT COUNT(*) as cnt FROM comments WHERE is_approved = 0"
        );
        return (int)($row['cnt'] ?? 0);
    }
}
