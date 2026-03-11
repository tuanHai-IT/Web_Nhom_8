<?php
// core/Model.php
// Base model every model class extends.
// Provides shared DB access and common CRUD helpers.

abstract class Model {
    protected Database $db;
    protected string $table = '';      // Override in child
    protected string $primaryKey = 'id';

    public function __construct() {
        $this->db = Database::getInstance();
    }

    // Find single record by primary key
    public function find(int $id): array|false {
        return $this->db->fetchOne(
            "SELECT * FROM {$this->table} WHERE {$this->primaryKey} = ?",
            [$id]
        );
    }

    // Return all rows
    public function all(string $orderBy = ''): array {
        $sql = "SELECT * FROM {$this->table}";
        if ($orderBy) $sql .= " ORDER BY {$orderBy}";
        return $this->db->fetchAll($sql);
    }

    // Delete by primary key
    public function delete(int $id): int {
        return $this->db->execute(
            "DELETE FROM {$this->table} WHERE {$this->primaryKey} = ?",
            [$id]
        );
    }

    // Generic paginate helper — returns ['data'=>[], 'total'=>n]
    protected function paginate(string $sql, array $params, int $page, int $perPage): array {
        $countSql = "SELECT COUNT(*) as total FROM ({$sql}) as sub";
        $total = (int)($this->db->fetchOne($countSql, $params)['total'] ?? 0);
        $offset = ($page - 1) * $perPage;
        $rows = $this->db->fetchAll($sql . " LIMIT {$perPage} OFFSET {$offset}", $params);
        return ['data' => $rows, 'total' => $total, 'pages' => ceil($total / $perPage)];
    }

    // Sanitize a string for output
    protected function sanitize(string $value): string {
        return htmlspecialchars(strip_tags($value), ENT_QUOTES, 'UTF-8');
    }
}
