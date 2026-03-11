<?php
// core/Database.php
// Singleton PDO wrapper for all database interactions
// Uses prepared statements exclusively to prevent SQL injection

class Database {
    private static ?Database $instance = null;
    private PDO $pdo;

    private function __construct() {
        // config/database.php is already loaded via index.php bootstrap
        $dsn = "mysql:host=" . DB_HOST . ";dbname=" . DB_NAME . ";charset=" . DB_CHARSET;
        $options = [
            PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_EMULATE_PREPARES   => false,
        ];
        try {
            $this->pdo = new PDO($dsn, DB_USER, DB_PASS, $options);
        } catch (PDOException $e) {
            http_response_code(500);
            die(json_encode(['error' => 'Database connection failed: ' . $e->getMessage()]));
        }
    }

    // Returns the single shared instance
    public static function getInstance(): Database {
        if (self::$instance === null) {
            self::$instance = new self();
        }
        return self::$instance;
    }

    // Execute a prepared statement and return the PDOStatement
    public function query(string $sql, array $params = []): PDOStatement {
        $stmt = $this->pdo->prepare($sql);
        $stmt->execute($params);
        return $stmt;
    }

    // Fetch a single row
    public function fetchOne(string $sql, array $params = []): array|false {
        return $this->query($sql, $params)->fetch();
    }

    // Fetch all rows
    public function fetchAll(string $sql, array $params = []): array {
        return $this->query($sql, $params)->fetchAll();
    }

    // Insert and return last insert ID
    public function insert(string $sql, array $params = []): int {
        $this->query($sql, $params);
        return (int)$this->pdo->lastInsertId();
    }

    // Update/Delete — returns affected row count
    public function execute(string $sql, array $params = []): int {
        return $this->query($sql, $params)->rowCount();
    }

    // Call a stored procedure
    public function callProcedure(string $name, array $params = []): array {
        $placeholders = implode(',', array_fill(0, count($params), '?'));
        $sql = "CALL {$name}({$placeholders})";
        return $this->fetchAll($sql, $params);
    }

    // Begin transaction
    public function beginTransaction(): void { $this->pdo->beginTransaction(); }
    public function commit(): void          { $this->pdo->commit(); }
    public function rollback(): void        { $this->pdo->rollBack(); }
}
