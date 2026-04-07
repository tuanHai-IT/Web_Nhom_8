<?php
// app/middleware/CsrfMiddleware.php
// Validates CSRF token on every POST request

class CsrfMiddleware {

    public function handle(): void {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            Csrf::check();
        }
    }
}
