<?php
// core/Router.php
// Front-controller router: maps URL paths → Controller@method
// Supports GET, POST, named parameters (:slug, :id), and middleware groups

class Router {
    private array $routes = [];
    private array $currentMiddleware = [];

    // ── Route registration ────────────────────────────────────────────────

    public function get(string $path, string $handler): void {
        $this->addRoute('GET', $path, $handler);
    }

    public function post(string $path, string $handler): void {
        $this->addRoute('POST', $path, $handler);
    }

    /**
     * Group routes with shared middleware.
     * Usage: $router->group(['middleware' => ['admin', 'csrf']], function($r) { ... });
     */
    public function group(array $config, callable $callback): void {
        $prevMiddleware = $this->currentMiddleware;
        $this->currentMiddleware = array_merge(
            $this->currentMiddleware,
            $config['middleware'] ?? []
        );
        $callback($this);
        $this->currentMiddleware = $prevMiddleware;
    }

    private function addRoute(string $method, string $path, string $handler): void {
        // Convert :param segments to named regex groups
        $pattern = preg_replace('/\\/:([a-zA-Z_]+)/', '/(?P<$1>[^/]+)', $path);
        $pattern = '#^' . $pattern . '$#';
        $middleware = $this->currentMiddleware;
        $this->routes[] = compact('method', 'pattern', 'handler', 'middleware');
    }

    // ── Dispatch ──────────────────────────────────────────────────────────

    public function dispatch(): void {
        $method = $_SERVER['REQUEST_METHOD'];

        // Strip base path and query string from URI
        $uri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
        $base = parse_url(BASE_URL, PHP_URL_PATH);
        $uri = '/' . ltrim(substr($uri, strlen($base)), '/');
        $uri = $uri ?: '/';

        foreach ($this->routes as $route) {
            if ($route['method'] !== $method) continue;
            if (preg_match($route['pattern'], $uri, $matches)) {
                // Run middleware stack
                $this->runMiddleware($route['middleware'] ?? []);

                // Extract only named capture groups as params
                $params = array_filter($matches, 'is_string', ARRAY_FILTER_USE_KEY);
                $this->callHandler($route['handler'], $params);
                return;
            }
        }

        // No route matched → 404
        http_response_code(404);
        $content = '';
        require BASE_PATH . '/app/views/errors/404.php';
        require BASE_PATH . '/app/views/layouts/main.php';
    }

    // ── Middleware runner ──────────────────────────────────────────────────

    private function runMiddleware(array $middlewareNames): void {
        $map = [
            'csrf'  => CsrfMiddleware::class,
            'auth'  => AuthMiddleware::class,
            'admin' => AdminMiddleware::class,
        ];

        foreach ($middlewareNames as $name) {
            $class = $map[$name] ?? null;
            if ($class && class_exists($class)) {
                (new $class())->handle();
            }
        }
    }

    // ── Handler invocation ────────────────────────────────────────────────

    private function callHandler(string $handler, array $params): void {
        [$controllerName, $action] = explode('@', $handler);

        // Autoloader handles class loading — no manual require_once needed
        if (!class_exists($controllerName)) {
            error_log("Controller not found: {$controllerName}");
            http_response_code(500);
            die('An internal error occurred.');
        }

        $controller = new $controllerName();
        if (!method_exists($controller, $action)) {
            error_log("Method {$action} not found in {$controllerName}");
            http_response_code(500);
            die('An internal error occurred.');
        }

        call_user_func_array([$controller, $action], $params);
    }
}
