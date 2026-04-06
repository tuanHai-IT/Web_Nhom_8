<?php
// config/database.php
// Update these values to match your XAMPP / MySQL environment

define('DB_HOST', 'localhost');
define('DB_NAME', 'online_news_db');
define('DB_USER', 'root');
define('DB_PASS', '');
define('DB_CHARSET', 'utf8mb4');

define('BASE_URL', 'http://localhost/gamenews');

// Safety check — BASE_PATH is defined in index.php
if (!defined('BASE_PATH')) {
    define('BASE_PATH', dirname(__DIR__));
}

define('UPLOAD_PATH', BASE_PATH . '/public/images/uploads/');
define('UPLOAD_URL', BASE_URL . '/public/images/uploads/');
