<?php
// index.php — Application entry point
// Every HTTP request is routed through here via .htaccess

declare(strict_types=1);

// ── Path constants ────────────────────────────────────────────────────────
define('BASE_PATH', __DIR__);

// ── Load config ───────────────────────────────────────────────────────────
require_once BASE_PATH . '/config/database.php';

// ── Autoloader (replaces all manual require_once calls) ───────────────────
require_once BASE_PATH . '/core/Autoloader.php';
Autoloader::register();

// ── Initialize error handler ──────────────────────────────────────────────
ErrorHandler::init();

// ── Session with security hardening ───────────────────────────────────────
if (session_status() === PHP_SESSION_NONE) {
    ini_set('session.cookie_httponly', '1');   // Prevent JS access to session cookie
    ini_set('session.use_strict_mode', '1');   // Reject uninitialized session IDs
    ini_set('session.cookie_samesite', 'Lax'); // Mitigate CSRF via cross-origin
    // ini_set('session.cookie_secure', '1');  // Uncomment when serving over HTTPS
    session_start();
}

// ── Instantiate router and load route definitions ─────────────────────────
$router = new Router();
require_once BASE_PATH . '/routes/web.php';

// ── Dispatch the incoming request ─────────────────────────────────────────
$router->dispatch();
