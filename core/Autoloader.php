<?php
// core/Autoloader.php
// PSR-4-style class autoloader — eliminates manual require_once calls

class Autoloader {
    private static array $directories = [];

    /**
     * Register the autoloader and define search directories.
     */
    public static function register(): void {
        self::$directories = [
            BASE_PATH . '/core/',
            BASE_PATH . '/app/controllers/',
            BASE_PATH . '/app/models/',
            BASE_PATH . '/app/middleware/',
            BASE_PATH . '/app/services/',
        ];
        spl_autoload_register([self::class, 'load']);
    }

    /**
     * Attempt to load a class file from registered directories.
     */
    private static function load(string $class): void {
        // Strip namespace prefix if present (future-proofing)
        $className = basename(str_replace('\\', '/', $class));
        foreach (self::$directories as $dir) {
            $file = $dir . $className . '.php';
            if (file_exists($file)) {
                require_once $file;
                return;
            }
        }
    }
}
