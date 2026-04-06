<?php
// app/models/User.php

class User extends Model
{
    protected string $table      = 'users';
    protected string $primaryKey = 'user_id';

    // FIX: DB dùng r.role_name, không phải r.name
    private string $roleJoin = "
        SELECT u.*, r.role_name AS role_name
        FROM users u
        LEFT JOIN roles r ON u.role_id = r.role_id";

    public function findByEmail(string $email): array|false
    {
        return $this->db->fetchOne(
            "SELECT u.*, r.role_name AS role_name
             FROM users u
             LEFT JOIN roles r ON u.role_id = r.role_id
             WHERE u.email = ?",
            [$email]
        );
    }

    public function findByUsername(string $username): array|false
    {
        return $this->db->fetchOne(
            "SELECT * FROM users WHERE username = ?",
            [$username]
        );
    }

    public function create(array $data): int
    {
        $hash = password_hash($data['password'], PASSWORD_BCRYPT);
        // role_id=3 = member (theo online_news_db: 1=admin,2=editor,3=member)
        return $this->db->insert(
            "INSERT INTO users (username, email, password, role_id) VALUES (?,?,?,3)",
            [$data['username'], $data['email'], $hash]
        );
    }
    /**
     * Tạo user đăng ký qua social login (Google/Facebook)
     */
    public function createSocialUser(array $data): int
    {
        // role_id=3 = member (giống register thường)
        return $this->db->insert(
            "INSERT INTO users (username, email, password, provider, role_id, created_at)
         VALUES (?,?,?,?,3,NOW())",
            [$data['username'], $data['email'], '', $data['provider']]
        );
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
        $sql = "SELECT u.*, r.role_name AS role_name
                FROM users u
                LEFT JOIN roles r ON u.role_id = r.role_id
                ORDER BY u.created_at DESC";
        return $this->paginate($sql, [], $page, $perPage);
    }

    public function updateRole(int $userId, int $roleId): int
    {
        return $this->db->execute(
            "UPDATE users SET role_id = ? WHERE user_id = ?",
            [$roleId, $userId]
        );
    }

    public function getRoles(): array
    {
        return $this->db->fetchAll("SELECT * FROM roles ORDER BY role_id");
    }

    public function emailExists(string $email): bool
    {
        return (bool)$this->db->fetchOne(
            "SELECT 1 FROM users WHERE email = ?",
            [$email]
        );
    }

    public function usernameExists(string $username): bool
    {
        return (bool)$this->db->fetchOne(
            "SELECT 1 FROM users WHERE username = ?",
            [$username]
        );
    }

    // ── Password Reset Token Methods ──

    public function createResetToken(int $userId, string $token, string $expiresAt): int
    {
        // Delete old tokens for this user
        $this->db->execute("DELETE FROM reset_tokens WHERE user_id = ?", [$userId]);

        // Create new token
        return $this->db->insert(
            "INSERT INTO reset_tokens (user_id, token, expires_at, created_at) VALUES (?,?,?,NOW())",
            [$userId, $token, $expiresAt]
        );
    }

    public function getResetToken(string $token): array|false
    {
        return $this->db->fetchOne(
            "SELECT * FROM reset_tokens WHERE token = ?",
            [$token]
        );
    }

    public function deleteResetToken(string $token): int
    {
        return $this->db->execute(
            "DELETE FROM reset_tokens WHERE token = ?",
            [$token]
        );
    }

    public function updatePassword(int $userId, string $hashedPassword): int
    {
        return $this->db->execute(
            "UPDATE users SET password = ?, updated_at = NOW() WHERE user_id = ?",
            [$hashedPassword, $userId]
        );
    }
    /**
     * Cập nhật thông tin cá nhân user
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
        return $this->db->fetchOne(
            "SELECT u.*, r.role_name
         FROM users u
         LEFT JOIN roles r ON u.role_id = r.role_id
         WHERE u.user_id = ?",
            [$userId]
        );
    }
}
