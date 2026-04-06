<?php
// core/Logger.php
// Activity logging — writes to the activity_logs table that already exists in the schema

class Logger {

    /**
     * Log an action to the activity_logs table.
     *
     * @param string   $action  Short action name (e.g. 'login', 'article.create')
     * @param string   $details Human-readable details
     * @param int|null $userId  Actor (null = system or from session)
     */
    public static function log(string $action, string $details = '', ?int $userId = null): void {
        try {
            $uid = $userId ?? ($_SESSION['user_id'] ?? null);
            $ip  = $_SERVER['REMOTE_ADDR'] ?? '0.0.0.0';
            Database::getInstance()->execute(
                "INSERT INTO activity_logs (user_id, action, details, ip_address) VALUES (?,?,?,?)",
                [$uid, $action, $details, $ip]
            );
        } catch (\Throwable $e) {
            // Never let logging errors crash the application
            error_log('Logger::log failed: ' . $e->getMessage());
        }
    }
}
