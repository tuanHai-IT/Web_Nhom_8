<?php
// core/Csrf.php
// CSRF token generation and validation for all POST requests

class Csrf {

    /**
     * Generate or retrieve the current CSRF token.
     */
    public static function token(): string {
        if (empty($_SESSION['_csrf_token'])) {
            $_SESSION['_csrf_token'] = bin2hex(random_bytes(32));
        }
        return $_SESSION['_csrf_token'];
    }

    /**
     * Return a hidden input field with the CSRF token.
     */
    public static function field(): string {
        return '<input type="hidden" name="_token" value="' . self::token() . '">';
    }

    /**
     * Validate the submitted CSRF token against the session token.
     * Checks both POST body and X-CSRF-TOKEN header (for AJAX).
     */
    public static function verify(): bool {
        $submitted = $_POST['_token']
                  ?? $_SERVER['HTTP_X_CSRF_TOKEN']
                  ?? '';
        $stored = $_SESSION['_csrf_token'] ?? '';

        if (empty($stored) || empty($submitted)) {
            return false;
        }

        return hash_equals($stored, $submitted);
    }

    /**
     * Validate and abort with 403 if token is invalid.
     */
    public static function check(): void {
        if (!self::verify()) {
            http_response_code(403);
            die('403 Forbidden — Invalid or missing CSRF token.');
        }
    }
}
