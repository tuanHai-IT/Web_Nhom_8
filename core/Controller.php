<?php
// core/Controller.php
// Base controller: view rendering, JSON responses, redirects, auth guards, CSRF helpers

abstract class Controller {

    /**
     * Render a view file inside a layout, passing data as extracted variables.
     * Uses EXTR_SKIP to prevent overwriting local variables ($content, $viewFile, etc.).
     */
    protected function view(string $view, array $data = [], string $layout = 'main'): void {
        // Always make CSRF token available to views
        $data['csrfToken'] = Csrf::token();
        $data['csrfField'] = Csrf::field();

        extract($data, EXTR_SKIP);               // safe: won't overwrite existing vars
        $viewFile   = BASE_PATH . "/app/views/{$view}.php";
        $layoutFile = BASE_PATH . "/app/views/layouts/{$layout}.php";

        if (!file_exists($viewFile)) {
            $this->abort(404, "View not found: {$view}");
            return;
        }

        // Buffer the inner view content
        ob_start();
        require $viewFile;
        $content = ob_get_clean();                // $content available inside layout

        if ($layout && file_exists($layoutFile)) {
            require $layoutFile;
        } else {
            echo $content;
        }
    }

    /**
     * Send a JSON response (used for all AJAX endpoints).
     */
    protected function json(array $data, int $status = 200): void {
        http_response_code($status);
        header('Content-Type: application/json; charset=utf-8');
        echo json_encode($data, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
        exit;
    }

    /**
     * Redirect to a path relative to BASE_URL.
     */
    protected function redirect(string $url): void {
        header("Location: " . BASE_URL . $url);
        exit;
    }

    /**
     * Abort with an error view.
     */
    protected function abort(int $code, string $message = ''): void {
        http_response_code($code);
        $content = "<h2>Error {$code}</h2><p>" . htmlspecialchars($message) . "</p>";
        require BASE_PATH . "/app/views/layouts/main.php";
        exit;
    }

    /**
     * Require that a user is logged in (fallback for non-middleware routes).
     */
    protected function requireAuth(): void {
        if (empty($_SESSION['user_id'])) {
            $this->redirect('/auth/login');
        }
    }

    /**
     * Require admin role (fallback for non-middleware routes).
     */
    protected function requireAdmin(): void {
        if (empty($_SESSION['user_id']) || ($_SESSION['role'] ?? '') !== 'admin') {
            $this->redirect('/auth/login');
        }
    }

    /**
     * Validate and sanitize a single POST input.
     */
    protected function input(string $key, string $default = ''): string {
        return htmlspecialchars(trim($_POST[$key] ?? $default), ENT_QUOTES, 'UTF-8');
    }

    /**
     * Check if current request is AJAX / expects JSON.
     */
    protected function isAjax(): bool {
        return isset($_SERVER['HTTP_X_REQUESTED_WITH']) &&
               strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) === 'xmlhttprequest';
    }
}
