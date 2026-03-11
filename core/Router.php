<?php
// core/Router.php
// Front-controller router: maps URL paths → Controller@method
// Supports GET, POST, and named parameters (:slug, :id)

class Router {
    private array $routes = [];
    private array $notFound = [];

    // Register a GET route
    public function get(string $path, string $handler): void {
        $this->addRoute('GET', $path, $handler);
    }

    // Register a POST route
    public function post(string $path, string $handler): void {
        $this->addRoute('POST', $path, $handler);
    }

    private function addRoute(string $method, string $path, string $handler): void {
        // Convert :param segments to named regex groups
        $pattern = preg_replace('/\/:([a-zA-Z_]+)/', '/(?P<$1>[^/]+)', $path);
        $pattern = '#^' . $pattern . '$#';
        $this->routes[] = compact('method', 'pattern', 'handler');
    }

    // Dispatch the current request
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

    private function callHandler(string $handler, array $params): void {
        [$controllerName, $action] = explode('@', $handler);
        $controllerFile = BASE_PATH . "/app/controllers/{$controllerName}.php";
        if (!file_exists($controllerFile)) {
            die("Controller not found: {$controllerName}");
        }
        require_once $controllerFile;
        $controller = new $controllerName();
        if (!method_exists($controller, $action)) {
            die("Method {$action} not found in {$controllerName}");
        }
        call_user_func_array([$controller, $action], $params);
    }
}
