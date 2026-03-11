<?php
// app/models/User.php

class User extends Model {
    protected string $table      = 'users';
    protected string $primaryKey = 'user_id';

    public function findByEmail(string $email): array|false {
        return $this->db->fetchOne(
            "SELECT u.*, r.role_name AS role_name
             FROM users u
             LEFT JOIN roles r ON u.role_id = r.role_id
             WHERE u.email = ?",
            [$email]
        );
    }

    public function findByUsername(string $username): array|false {
        return $this->db->fetchOne(
            "SELECT * FROM users WHERE username = ?", [$username]
        );
    }

    public function create(array $data): int {
        // Securely hash password using bcrypt
        $hash = password_hash($data['password'], PASSWORD_BCRYPT);
        return $this->db->insert(
            "INSERT INTO users (username, email, password, role_id) VALUES (?,?,?,?)",
            [$data['username'], $data['email'], $hash, 2] // role_id 2 = regular user
        );
    }

    public function verify(string $email, string $password): array|false {
        $user = $this->findByEmail($email);
        if ($user && password_verify($password, $user['password'])) {
            return $user;
        }
        return false;
    }

    public function getAllAdmin(int $page = 1, int $perPage = 20): array {
        $sql = "SELECT u.*, r.role_name AS role_name
                FROM users u
                LEFT JOIN roles r ON u.role_id = r.role_id
                ORDER BY u.created_at DESC";
        return $this->paginate($sql, [], $page, $perPage);
    }

    public function updateRole(int $userId, int $roleId): int {
        return $this->db->execute(
            "UPDATE users SET role_id = ? WHERE user_id = ?",
            [$roleId, $userId]
        );
    }

    public function getRoles(): array {
        return $this->db->fetchAll("SELECT * FROM roles ORDER BY role_id");
    }

    public function emailExists(string $email): bool {
        return (bool)$this->db->fetchOne(
            "SELECT 1 FROM users WHERE email = ?", [$email]
        );
    }

    public function usernameExists(string $username): bool {
        return (bool)$this->db->fetchOne(
            "SELECT 1 FROM users WHERE username = ?", [$username]
        );
    }
}
