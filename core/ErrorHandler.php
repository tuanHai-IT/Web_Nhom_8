<?php
// core/ErrorHandler.php
// Global error handling for debugging

class ErrorHandler
{

    private static string $logFile = '';

    public static function init(): void
    {
        self::$logFile = BASE_PATH . '/logs/errors.log';
        self::ensureLogDir();

        set_error_handler([self::class, 'handleError']);
        set_exception_handler([self::class, 'handleException']);
    }

    private static function ensureLogDir(): void
    {
        $dir = dirname(self::$logFile);
        if (!is_dir($dir)) {
            mkdir($dir, 0755, true);
        }
    }

    public static function handleError(int $errno, string $errstr, string $errfile, int $errline): bool
    {
        $message = "[ERROR] {$errstr} in {$errfile}:{$errline}";
        error_log($message, 3, self::$logFile);

        // Return false to continue with PHP internal error handling
        return false;
    }

    public static function handleException(Throwable $e): void
    {
        $message = "[EXCEPTION] " . get_class($e) . ": " . $e->getMessage() .
            " in " . $e->getFile() . ":" . $e->getLine();
        error_log($message, 3, self::$logFile);
        error_log($e->getTraceAsString(), 3, self::$logFile);

        // Return 500 error
        http_response_code(500);
        header('Content-Type: application/json; charset=utf-8');
        echo json_encode([
            'success' => false,
            'message' => 'Server error. Please try again later.'
        ]);
        exit;
    }
}
