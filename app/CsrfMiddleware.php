<?php
// app/middleware/AuthMiddleware.php
// Ensures the user is logged in — redirects to login page otherwise

class AuthMiddleware {

    public function handle(): void {
        if (empty($_SESSION['user_id'])) {
            header('Location: ' . BASE_URL . '/auth/login');
            exit;
        }
    }
}
