<?php
// core/RateLimiter.php
// Session-based rate limiting for login, comments, ratings, and search endpoints

class RateLimiter {

    /**
     * Check if the action is within the rate limit.
     *
     * @param string $key            Unique key for the action (e.g. 'login', 'comment')
     * @param int    $maxAttempts    Maximum allowed attempts in the window
     * @param int    $windowSeconds  Time window in seconds
     * @return bool  True if within limit, false if rate-limited
     */
    public static function check(string $key, int $maxAttempts = 5, int $windowSeconds = 60): bool {
        $sessionKey = "_rate_limit_{$key}";
        $bucket = $_SESSION[$sessionKey] ?? ['count' => 0, 'expires' => 0];

        // Reset window if expired
        if (time() > $bucket['expires']) {
            $bucket = ['count' => 0, 'expires' => time() + $windowSeconds];
        }

        $bucket['count']++;
        $_SESSION[$sessionKey] = $bucket;

        return $bucket['count'] <= $maxAttempts;
    }

    /**
     * Abort with 429 if rate-limited.
     */
    public static function enforce(string $key, int $maxAttempts = 5, int $windowSeconds = 60): void {
        if (!self::check($key, $maxAttempts, $windowSeconds)) {
            http_response_code(429);
            die('429 Too Many Requests — Please slow down.');
        }
    }
}
