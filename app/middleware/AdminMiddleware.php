<?php
// app/middleware/AdminMiddleware.php
// Ensures the user is logged in AND has admin role

class AdminMiddleware {

    public function handle(): void {
        if (empty($_SESSION['user_id']) || ($_SESSION['role'] ?? '') !== 'admin') {
            header('Location: ' . BASE_URL . '/auth/login');
            exit;
        }
    }
}
