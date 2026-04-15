<?php
// app/models/Comment.php

class Comment extends Model
{
    protected string $table      = 'comments';
    protected string $primaryKey = 'comment_id';

    // FIX: DB dùng is_approved=1, không phải status='approved'
    public function getApproved(int $articleId): array
    {
        // SP: sp_get_approved_comments
        return $this->db->callProc('sp_get_approved_comments', [$articleId]);
    }

    public function create(int $articleId, int $userId, string $content): int
    {
        // FIX: insert is_approved=1 thay vì status='pending'
        // Để comment hiện ngay (auto-approve). Nếu muốn moderation, đổi thành 0
        // SP: sp_create_comment
        $rows = $this->db->callProc('sp_create_comment', [$articleId, $userId, $content]);
        return (int)($rows[0]['new_id'] ?? 0);
    }

    public function getAllAdmin(int $page = 1, int $perPage = 20): array
    {
        $offset = ($page - 1) * $perPage;

        // SP: sp_get_all_comments_admin_data
        $data = $this->db->callProc('sp_get_all_comments_admin_data', [$perPage, $offset]);

        // SP: sp_get_all_comments_admin_count
        $countRows = $this->db->callProc('sp_get_all_comments_admin_count', []);
        $total = (int)($countRows[0]['total'] ?? 0);

        return [
            'data'  => $data,
            'total' => $total,
            'pages' => (int)ceil($total / max(1, $perPage)),
        ];
    }

    public function approve(int $id): int
    {
        // SP: sp_approve_comment
        $this->db->callProc('sp_approve_comment', [$id]);
        return 1;
    }

    public function delete(int $id): int
    {
        // SP: sp_delete_comment
        $this->db->callProc('sp_delete_comment', [$id]);
        return 1;
    }

    public function getPendingCount(): int
    {
        // SP: sp_get_pending_comment_count
        $rows = $this->db->callProc('sp_get_pending_comment_count', []);
        return (int)($rows[0]['cnt'] ?? 0);
    }
}
