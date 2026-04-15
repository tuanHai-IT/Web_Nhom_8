<?php
// core/Database.php
// Singleton PDO wrapper — safe error handling (no detail leaks)

class Database
{
    private static ?Database $instance = null;
    private PDO $pdo;

    private function __construct()
    {
        $dsn = "mysql:host=" . DB_HOST . ";dbname=" . DB_NAME . ";charset=" . DB_CHARSET;
        $options = [
            PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_EMULATE_PREPARES   => false,
        ];
        try {
            $this->pdo = new PDO($dsn, DB_USER, DB_PASS, $options);
        } catch (PDOException $e) {
            // Log the real error, show generic message to user
            error_log('Database connection failed: ' . $e->getMessage());
            http_response_code(500);
            die('Service temporarily unavailable. Please try again later.');
        }
    }

    public static function getInstance(): Database
    {
        if (self::$instance === null) {
            self::$instance = new self();
        }
        return self::$instance;
    }

    public function query(string $sql, array $params = []): PDOStatement
    {
        $stmt = $this->pdo->prepare($sql);
        $stmt->execute($params);
        return $stmt;
    }

    public function fetchOne(string $sql, array $params = []): array|false
    {
        return $this->query($sql, $params)->fetch();
    }

    public function fetchAll(string $sql, array $params = []): array
    {
        return $this->query($sql, $params)->fetchAll();
    }

    public function insert(string $sql, array $params = []): int
    {
        $this->query($sql, $params);
        return (int)$this->pdo->lastInsertId();
    }

    public function execute(string $sql, array $params = []): int
    {
        return $this->query($sql, $params)->rowCount();
    }

    public function beginTransaction(): void
    {
        $this->pdo->beginTransaction();
    }
    public function commit(): void
    {
        $this->pdo->commit();
    }
    public function rollback(): void
    {
        $this->pdo->rollBack();
    }

    /**
     * Call a stored procedure and return all rows from the first result set.
     *
     * Builds: CALL procName(?,?,?) with one placeholder per param.
     * Uses PDO::ATTR_EMULATE_PREPARES=false, so stored procedures that
     * return a single SELECT work directly via fetchAll().
     * For procedures that emit multiple result sets, use fetchAllFromStmt().
     *
     * @param string $name   Stored procedure name (e.g. 'sp_get_latest_articles')
     * @param array  $params Ordered IN-parameter values
     * @return array         Rows returned by the procedure's SELECT
     */
    public function callProc(string $name, array $params = []): array
    {
        $placeholders = implode(', ', array_fill(0, count($params), '?'));
        $sql  = "CALL {$name}(" . $placeholders . ")";
        $stmt = $this->pdo->prepare($sql);
        $stmt->execute($params);
        $rows = $stmt->fetchAll();
        // Consume any additional result sets so the connection stays clean
        while ($stmt->nextRowset()) { /* discard */
        }
        return $rows;
    }

    /**
     * Fetch all rows from a PDOStatement, advancing through rowsets as needed.
     *
     * Use this when you need the PDOStatement object itself (e.g. to call
     * nextRowset() manually), or when a procedure returns multiple SELECT sets
     * and you need rows from a specific rowset.
     *
     * @param PDOStatement $stmt Already-executed statement
     * @return array             Rows from the current (first) rowset
     */
    public function fetchAllFromStmt(PDOStatement $stmt): array
    {
        $rows = $stmt->fetchAll();
        while ($stmt->nextRowset()) { /* discard remaining rowsets */
        }
        return $rows;
    }
}
