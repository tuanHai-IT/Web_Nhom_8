<?php
// app/models/User.php

class User extends Model
{
    protected string $table      = 'users';
    protected string $primaryKey = 'user_id';

    public function findByEmail(string $email): array|false
    {
        // SP: sp_find_user_by_email
        $rows = $this->db->callProc('sp_find_user_by_email', [$email]);
        return $rows[0] ?? false;
    }

    public function findByUsername(string $username): array|false
    {
        // SP: sp_find_user_by_username
        $rows = $this->db->callProc('sp_find_user_by_username', [$username]);
        return $rows[0] ?? false;
    }

    public function create(array $data): int
    {
        $hash = password_hash($data['password'], PASSWORD_BCRYPT);
        // role_id=3 = member (theo online_news_db: 1=admin,2=editor,3=member)
        // SP: sp_create_user
        $rows = $this->db->callProc('sp_create_user', [$data['username'], $data['email'], $hash]);
        return (int)($rows[0]['new_id'] ?? 0);
    }

    /**
     * Tạo user đăng ký qua social login (Google/Facebook)
     */
    public function createSocialUser(array $data): int
    {
        // role_id=3 = member (giống register thường)
        // SP: sp_create_social_user
        $rows = $this->db->callProc('sp_create_social_user', [
            $data['username'],
            $data['email'],
            $data['provider'],
        ]);
        return (int)($rows[0]['new_id'] ?? 0);
    }

    public function verify(string $email, string $password): array|false
    {
        $user = $this->findByEmail($email);
        if ($user && password_verify($password, $user['password'])) {
            return $user;
        }
        return false;
    }

    public function getAllAdmin(int $page = 1, int $perPage = 20): array
    {
        $offset = ($page - 1) * $perPage;

        // SP: sp_get_all_users_admin_data
        $data = $this->db->callProc('sp_get_all_users_admin_data', [$perPage, $offset]);

        // SP: sp_get_all_users_admin_count
        $countRows = $this->db->callProc('sp_get_all_users_admin_count', []);
        $total = (int)($countRows[0]['total'] ?? 0);

        return [
            'data'  => $data,
            'total' => $total,
            'pages' => (int)ceil($total / max(1, $perPage)),
        ];
    }

    public function updateRole(int $userId, int $roleId): int
    {
        // SP: sp_update_user_role
        $this->db->callProc('sp_update_user_role', [$userId, $roleId]);
        return 1;
    }

    public function getRoles(): array
    {
        // SP: sp_get_roles
        return $this->db->callProc('sp_get_roles', []);
    }

    public function emailExists(string $email): bool
    {
        // SP: sp_email_exists
        $rows = $this->db->callProc('sp_email_exists', [$email]);
        return !empty($rows);
    }

    public function usernameExists(string $username): bool
    {
        // SP: sp_username_exists
        $rows = $this->db->callProc('sp_username_exists', [$username]);
        return !empty($rows);
    }

    // ── Password Reset Token Methods ──

    public function createResetToken(int $userId, string $token, string $expiresAt): int
    {
        // Delete old tokens for this user
        // SP: sp_delete_user_reset_tokens
        $this->db->callProc('sp_delete_user_reset_tokens', [$userId]);

        // Create new token
        // SP: sp_create_reset_token
        $rows = $this->db->callProc('sp_create_reset_token', [$userId, $token, $expiresAt]);
        return (int)($rows[0]['new_id'] ?? 0);
    }

    public function getResetToken(string $token): array|false
    {
        // SP: sp_get_reset_token
        $rows = $this->db->callProc('sp_get_reset_token', [$token]);
        return $rows[0] ?? false;
    }

    public function deleteResetToken(string $token): int
    {
        // SP: sp_delete_reset_token
        $this->db->callProc('sp_delete_reset_token', [$token]);
        return 1;
    }

    public function updatePassword(int $userId, string $hashedPassword): int
    {
        // SP: sp_update_user_password
        $this->db->callProc('sp_update_user_password', [$userId, $hashedPassword]);
        return 1;
    }

    /**
     * Cập nhật thông tin cá nhân user
     * Dynamic SET — kept as inline SQL (columns vary per call)
     */
    public function updateProfile(int $userId, array $data): int
    {
        $fields = [];
        $params = [];

        if (!empty($data['full_name'])) {
            $fields[] = 'full_name = ?';
            $params[] = $data['full_name'];
        }

        if (!empty($data['avatar'])) {
            $fields[] = 'avatar = ?';
            $params[] = $data['avatar'];
        }

        if (!empty($data['password'])) {
            $fields[] = 'password = ?';
            $params[] = password_hash($data['password'], PASSWORD_BCRYPT);
        }

        if (empty($fields)) return 0;

        $fields[]  = 'updated_at = NOW()';
        $params[]  = $userId;

        return $this->db->execute(
            "UPDATE users SET " . implode(', ', $fields) . " WHERE user_id = ?",
            $params
        );
    }

    /**
     * Lấy thông tin user theo ID
     */
    public function findById(int $userId): array|false
    {
        // SP: sp_find_user_by_id
        $rows = $this->db->callProc('sp_find_user_by_id', [$userId]);
        return $rows[0] ?? false;
    }
}
