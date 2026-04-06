<?php
// core/Model.php
// Base model every model class extends.
// Provides shared DB access and common CRUD helpers.

require_once __DIR__ . '/Database.php';

/**
 * Base Model
 *
 * @package Core
 */
abstract class Model
{
    /** @var \Database */
    protected $db;
    protected string $table = '';      // Override in child
    protected string $primaryKey = 'id';

    public function __construct()
    {
        $this->db = \Database::getInstance();
    }

    // Find single record by primary key
    public function find(int $id): array|false
    {
        return $this->db->fetchOne(
            "SELECT * FROM {$this->table} WHERE {$this->primaryKey} = ?",
            [$id]
        );
    }

    // Return all rows
    public function all(string $orderBy = ''): array
    {
        $sql = "SELECT * FROM {$this->table}";
        if ($orderBy) $sql .= " ORDER BY {$orderBy}";
        return $this->db->fetchAll($sql);
    }

    // Delete by primary key
    public function delete(int $id): int
    {
        return $this->db->execute(
            "DELETE FROM {$this->table} WHERE {$this->primaryKey} = ?",
            [$id]
        );
    }

    /**
     * Generic paginate helper — returns ['data'=>[], 'total'=>n, 'pages'=>n]
     * Accepts optional $countSql for more efficient counting.
     */
    protected function paginate(
        string $sql,
        array $params,
        int $page,
        int $perPage,
        ?string $countSql = null,
        ?array $countParams = null
    ): array {
        $cSql    = $countSql ?? "SELECT COUNT(*) as total FROM ({$sql}) as sub";
        $cParams = $countParams ?? $params;

        $total  = (int)($this->db->fetchOne($cSql, $cParams)['total'] ?? 0);
        $offset = ($page - 1) * $perPage;
        $rows   = $this->db->fetchAll($sql . " LIMIT {$perPage} OFFSET {$offset}", $params);

        return [
            'data'  => $rows,
            'total' => $total,
            'pages' => (int)ceil($total / max(1, $perPage)),
        ];
    }

    // Count all rows efficiently
    public function countAll(): int
    {
        $row = $this->db->fetchOne("SELECT COUNT(*) as cnt FROM {$this->table}");
        return (int)($row['cnt'] ?? 0);
    }

    /**
     * Insert a new record and return inserted ID
     * @param array $data
     * @return int
     */
    /**
     * Insert a new record and return inserted ID (helper)
     * @param array $data
     * @return int
     */
    protected function insertRecord(array $data): int
    {
        $cols = array_keys($data);
        $placeholders = implode(', ', array_fill(0, count($cols), '?'));
        $colsSql = implode(', ', array_map(fn($c) => "`{$c}`", $cols));
        $sql = "INSERT INTO {$this->table} ({$colsSql}) VALUES ({$placeholders})";
        $params = array_values($data);
        return $this->db->insert($sql, $params);
    }

    /**
     * Update a record by primary key and return affected rows (helper)
     * @param int $id
     * @param array $data
     * @return int
     */
    protected function updateRecord(int $id, array $data): int
    {
        if (empty($data)) return 0;
        $cols = array_keys($data);
        $setSql = implode(', ', array_map(fn($c) => "`{$c}` = ?", $cols));
        $sql = "UPDATE {$this->table} SET {$setSql} WHERE {$this->primaryKey} = ?";
        $params = array_values($data);
        $params[] = $id;
        return $this->db->execute($sql, $params);
    }

    // Sanitize a string for output
    protected function sanitize(string $value): string
    {
        return htmlspecialchars(strip_tags($value), ENT_QUOTES, 'UTF-8');
    }
}
