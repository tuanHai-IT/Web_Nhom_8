<?php
// app/controllers/UserController.php

class UserController extends Controller
{

    private User     $user;
    private Article  $article;
    private Category $category;

    public function __construct()
    {
        $this->user     = new User();
        $this->article  = new Article();
        $this->category = new Category();
    }

    // GET /auth/login
    public function loginForm(): void
    {
        if (!empty($_SESSION['user_id'])) {
            $this->redirect('/');
        }
        $this->view('auth/login', ['pageTitle' => 'Login – GameNexus'], 'auth');
    }

    // POST /auth/login — CSRF validated by middleware
    public function login(): void
    {
        // Check if AJAX request
        $isAjax = isset($_SERVER['HTTP_X_REQUESTED_WITH']) &&
            $_SERVER['HTTP_X_REQUESTED_WITH'] === 'XMLHttpRequest';

        try {
            // Rate limit: max 5 login attempts per minute
            if (!RateLimiter::check('login', 5, 60)) {
                if ($isAjax) {
                    $this->json(['success' => false, 'message' => 'Too many login attempts. Please wait a minute.'], 429);
                }
                $this->view('auth/login', [
                    'pageTitle' => 'Login – GameNexus',
                    'error'     => 'Too many login attempts. Please wait a minute.',
                ], 'auth');
                return;
            }

            $email    = trim($_POST['email'] ?? '');
            $password = $_POST['password'] ?? '';

            $v = new Validator();
            $v->required('email', $email, 'Email')
                ->email('email', $email)
                ->required('password', $password, 'Password');

            if ($v->fails()) {
                $errorMsg = array_values($v->errors())[0];
                if ($isAjax) {
                    $this->json(['success' => false, 'message' => $errorMsg], 422);
                }
                $this->view('auth/login', [
                    'pageTitle' => 'Login – GameNexus',
                    'error'     => $errorMsg,
                ], 'auth');
                return;
            }

            $user = $this->user->verify($email, $password);
            if (!$user) {
                Logger::log('login.failed', "Failed login for: {$email}");
                if ($isAjax) {
                    $this->json(['success' => false, 'message' => 'Invalid email or password.'], 401);
                }
                $this->view('auth/login', [
                    'pageTitle' => 'Login – GameNexus',
                    'error'     => 'Invalid email or password.',
                ], 'auth');
                return;
            }

            // Regenerate session ID to prevent fixation
            session_regenerate_id(true);
            $_SESSION['user_id']  = $user['user_id'];
            $_SESSION['username'] = $user['username'];
            $_SESSION['email']    = $user['email'];
            $_SESSION['role']     = $user['role_name'] ?? 'user';

            Logger::log('login.success', "User {$user['username']} logged in");

            if ($isAjax) {
                $this->json(['success' => true, 'message' => 'Login successful!']);
            }

            $redirect = ($user['role_name'] === 'admin') ? '/admin' : '/';
            $this->redirect($redirect);
        } catch (Exception $e) {
            Logger::log('login.error', "Login error: " . $e->getMessage());

            if ($isAjax) {
                $this->json(['success' => false, 'message' => 'Login failed. Please try again later.'], 500);
            }

            $this->view('auth/login', [
                'pageTitle' => 'Login – GameNexus',
                'error'     => 'Login failed. Please try again later.',
            ], 'auth');
        }
    }
    // POST /auth/social-callback — AJAX JSON
    public function socialCallback(): void
    {
        header('Content-Type: application/json');

        $raw         = file_get_contents('php://input');
        $data        = json_decode($raw, true);
        $provider    = $data['provider']     ?? '';
        $credential  = $data['credential']   ?? '';   // Google JWT
        $accessToken = $data['access_token'] ?? '';   // Facebook token
        $name        = '';
        $email       = '';

        // ── Xác minh Google token qua Google tokeninfo API (Webservice) ────
        if ($provider === 'google' && $credential) {
            $url      = 'https://oauth2.googleapis.com/tokeninfo?id_token=' . urlencode($credential);
            $response = @file_get_contents($url);

            if (!$response) {
                echo json_encode(['success' => false, 'message' => 'Không thể xác minh token Google.']);
                return;
            }

            $payload = json_decode($response, true);
            if (empty($payload['email'])) {
                echo json_encode(['success' => false, 'message' => 'Token Google không hợp lệ.']);
                return;
            }

            $email = $payload['email'];
            $name  = $payload['name'] ?? explode('@', $email)[0];
        }

        // ── Xác minh Facebook token qua Graph API (Webservice) ─────────────
        elseif ($provider === 'facebook' && $accessToken) {
            $url      = 'https://graph.facebook.com/me?fields=name,email&access_token=' . urlencode($accessToken);
            $response = @file_get_contents($url);

            if (!$response) {
                echo json_encode(['success' => false, 'message' => 'Không thể xác minh token Facebook.']);
                return;
            }

            $fbUser = json_decode($response, true);
            if (empty($fbUser['email'])) {
                echo json_encode(['success' => false, 'message' => 'Tài khoản Facebook chưa cấp quyền email.']);
                return;
            }

            $email = $fbUser['email'];
            $name  = $fbUser['name'] ?? explode('@', $email)[0];
        } else {
            echo json_encode(['success' => false, 'message' => 'Provider không hợp lệ.']);
            return;
        }

        // ── Kiểm tra user đã tồn tại chưa, nếu chưa thì tạo mới ───────────
        $user = $this->user->findByEmail($email);

        if (!$user) {
            $this->user->createSocialUser([
                'username' => $name,
                'email'    => $email,
                'provider' => $provider,
            ]);
            $user = $this->user->findByEmail($email);
        }

        if (!$user) {
            echo json_encode(['success' => false, 'message' => 'Không thể tạo tài khoản.']);
            return;
        }

        // ── Tạo session đăng nhập (dùng lại logic giống method login()) ────
        session_regenerate_id(true);
        $_SESSION['user_id']  = $user['user_id'];
        $_SESSION['username'] = $user['username'];
        $_SESSION['email']    = $user['email'];
        $_SESSION['role']     = $user['role_name'] ?? 'user';

        Logger::log('login.social', "User {$user['username']} logged in via {$provider}");

        echo json_encode(['success' => true, 'redirect' => BASE_URL . '/']);
    }

    // GET /auth/register
    public function registerForm(): void
    {
        if (!empty($_SESSION['user_id'])) {
            $this->redirect('/');
        }
        $this->view('auth/register', ['pageTitle' => 'Register – GameNexus'], 'auth');
    }

    // POST /auth/register — CSRF validated by middleware
    public function register(): void
    {
        // Check if AJAX request
        $isAjax = isset($_SERVER['HTTP_X_REQUESTED_WITH']) &&
            $_SERVER['HTTP_X_REQUESTED_WITH'] === 'XMLHttpRequest';

        try {
            // Rate limit: max 3 registrations per 5 minutes
            if (!RateLimiter::check('register', 3, 300)) {
                if ($isAjax) {
                    $this->json(['success' => false, 'message' => 'Too many registration attempts. Please wait.'], 429);
                }
                $this->view('auth/register', [
                    'pageTitle' => 'Register – GameNexus',
                    'errors'    => ['Too many registration attempts. Please wait.'],
                    'old'       => [],
                ], 'auth');
                return;
            }

            $username = trim($_POST['username'] ?? '');
            $email    = trim($_POST['email'] ?? '');
            $password = $_POST['password'] ?? '';
            $confirm  = $_POST['confirm_password'] ?? '';

            $v = new Validator();
            $v->required('username', $username, 'Username')
                ->minLength('username', $username, 3, 'Username')
                ->required('email', $email, 'Email')
                ->email('email', $email)
                ->required('password', $password, 'Password')
                ->minLength('password', $password, 8, 'Password')
                ->match('confirm_password', $password, $confirm, 'Password confirmation');

            // Check uniqueness
            if (!$v->fails()) {
                if ($this->user->emailExists($email))    $v->required('email_unique', '', 'Email already registered');
                if ($this->user->usernameExists($username)) $v->required('username_unique', '', 'Username already taken');
            }

            if ($v->fails()) {
                $errorMsg = array_values($v->errors())[0];
                if ($isAjax) {
                    $this->json(['success' => false, 'message' => $errorMsg], 422);
                }
                $this->view('auth/register', [
                    'pageTitle' => 'Register – GameNexus',
                    'errors'    => array_values($v->errors()),
                    'old'       => compact('username', 'email'),
                ], 'auth');
                return;
            }

            // Create user account
            $this->user->create(compact('username', 'email', 'password'));
            Logger::log('register', "New user registered: {$username}");

            if ($isAjax) {
                $this->json(['success' => true, 'message' => 'Account created successfully!']);
            }

            $this->redirect('/auth/login?registered=1');
        } catch (Exception $e) {
            Logger::log('register.error', "Registration failed: " . $e->getMessage());

            if ($isAjax) {
                $this->json(['success' => false, 'message' => 'Registration failed. Please try again later.'], 500);
            }

            $this->view('auth/register', [
                'pageTitle' => 'Register – GameNexus',
                'errors'    => ['Registration failed. Please try again later.'],
                'old'       => compact('username', 'email'),
            ], 'auth');
        }
    }

    // POST /auth/logout — CSRF validated by middleware (changed from GET to POST)
    public function logout(): void
    {
        Logger::log('logout', 'User logged out');
        session_destroy();
        header('Location: ' . BASE_URL . '/');
        exit;
    }

    // GET /profile/bookmarks — Auth validated by middleware
    public function bookmarks(): void
    {
        $bookmarks = $this->article->getUserBookmarks((int)$_SESSION['user_id']);
        $this->view('pages/bookmarks', [
            'pageTitle'  => 'My Bookmarks – GameNexus',
            'bookmarks'  => $bookmarks,
            'categories' => $this->category->all(),
        ]);
    }

    // GET /auth/forgot-password
    public function forgotPasswordForm(): void
    {
        if (!empty($_SESSION['user_id'])) {
            $this->redirect('/');
        }
        $this->view('auth/forgot-password', ['pageTitle' => 'Forgot Password – GameNexus'], 'auth');
    }

    // POST /auth/forgot-password — CSRF validated by middleware
    public function forgotPassword(): void
    {
        $isAjax = isset($_SERVER['HTTP_X_REQUESTED_WITH']) &&
            $_SERVER['HTTP_X_REQUESTED_WITH'] === 'XMLHttpRequest';

        // Rate limit: max 3 requests per 10 minutes
        if (!RateLimiter::check('forgot_password', 3, 600)) {
            if ($isAjax) {
                $this->json(['success' => false, 'message' => 'Too many requests. Please try again later.'], 429);
            }
            $this->view('auth/forgot-password', [
                'pageTitle' => 'Forgot Password – GameNexus',
                'error'     => 'Too many requests. Please try again later.',
            ], 'auth');
            return;
        }

        $email = trim($_POST['email'] ?? '');

        $v = new Validator();
        $v->required('email', $email, 'Email')
            ->email('email', $email);

        if ($v->fails()) {
            $errorMsg = array_values($v->errors())[0];
            if ($isAjax) {
                $this->json(['success' => false, 'message' => $errorMsg], 422);
            }
            $this->view('auth/forgot-password', [
                'pageTitle' => 'Forgot Password – GameNexus',
                'error'     => $errorMsg,
                'old'       => compact('email'),
            ], 'auth');
            return;
        }

        $user = $this->user->findByEmail($email);
        if (!$user) {
            // Don't reveal if account exists (security best practice)
            Logger::log('forgot_password.not_found', "Forgot password attempt for non-existent email: {$email}");
            if ($isAjax) {
                $this->json(['success' => true, 'message' => 'If an account exists with this email, you will receive a password reset link.']);
            }
            $this->redirect('/auth/login?reset_sent=1');
            return;
        }

        // Generate reset token
        $token = bin2hex(random_bytes(32));
        $expiresAt = date('Y-m-d H:i:s', time() + 3600); // 1 hour expiry

        // Store reset token in database
        $this->user->createResetToken($user['user_id'], $token, $expiresAt);

        // TODO: Send email with reset link
        // For now, log the token (in production, send via email)
        $resetLink = BASE_URL . '/auth/reset-password/' . urlencode($token);
        Logger::log('forgot_password.link_generated', "Reset link for {$email}: {$resetLink}");

        // In a real app, send email:
        // Mail::send($email, 'Password Reset', "Click here to reset: " . $resetLink);

        Logger::log('forgot_password.success', "Password reset link sent to: {$email}");

        if ($isAjax) {
            $this->json(['success' => true, 'message' => 'Check your email for the password reset link.']);
        }

        $this->redirect('/auth/login?reset_sent=1');
    }

    // GET /auth/reset-password/{token}
    public function resetPasswordForm(string $token = ''): void
    {
        if (empty($token)) {
            $this->view('auth/reset-password', [
                'pageTitle'  => 'Reset Password – GameNexus',
                'tokenError' => 'Invalid reset link.',
            ], 'auth');
            return;
        }

        $resetRecord = $this->user->getResetToken($token);
        if (!$resetRecord) {
            $this->view('auth/reset-password', [
                'pageTitle'  => 'Reset Password – GameNexus',
                'tokenError' => 'This reset link is invalid or has expired.',
            ], 'auth');
            return;
        }

        // Check if token has expired
        if (strtotime($resetRecord['expires_at']) < time()) {
            $this->user->deleteResetToken($token);
            $this->view('auth/reset-password', [
                'pageTitle'  => 'Reset Password – GameNexus',
                'tokenError' => 'This reset link has expired. Please request a new one.',
            ], 'auth');
            return;
        }

        $this->view('auth/reset-password', [
            'pageTitle' => 'Reset Password – GameNexus',
            'token'     => $token,
        ], 'auth');
    }

    // POST /auth/reset-password — CSRF validated by middleware
    public function resetPassword(): void
    {
        $isAjax = isset($_SERVER['HTTP_X_REQUESTED_WITH']) &&
            $_SERVER['HTTP_X_REQUESTED_WITH'] === 'XMLHttpRequest';

        $token    = trim($_POST['token'] ?? '');
        $password = $_POST['password'] ?? '';
        $confirm  = $_POST['confirm_password'] ?? '';

        // Validate token
        $resetRecord = $this->user->getResetToken($token);
        if (!$resetRecord || strtotime($resetRecord['expires_at']) < time()) {
            if ($isAjax) {
                $this->json(['success' => false, 'message' => 'This reset link is invalid or has expired.'], 401);
            }
            $this->view('auth/reset-password', [
                'pageTitle'  => 'Reset Password – GameNexus',
                'tokenError' => 'This reset link is invalid or has expired.',
            ], 'auth');
            return;
        }

        $v = new Validator();
        $v->required('password', $password, 'Password')
            ->minLength('password', $password, 8, 'Password')
            ->match('confirm_password', $password, $confirm, 'Password confirmation');

        if ($v->fails()) {
            $errorMsg = array_values($v->errors())[0];
            if ($isAjax) {
                $this->json(['success' => false, 'message' => $errorMsg], 422);
            }
            $this->view('auth/reset-password', [
                'pageTitle' => 'Reset Password – GameNexus',
                'token'     => $token,
                'error'     => $errorMsg,
            ], 'auth');
            return;
        }

        // Update password
        $userId = $resetRecord['user_id'];
        $hashedPassword = password_hash($password, PASSWORD_BCRYPT);
        $this->user->updatePassword($userId, $hashedPassword);

        // Delete reset token
        $this->user->deleteResetToken($token);

        Logger::log('password_reset.success', "Password reset for user ID: {$userId}");

        if ($isAjax) {
            $this->json(['success' => true, 'message' => 'Password has been reset successfully!']);
        }

        $this->redirect('/auth/login?password_reset=1');
    }
    // GET /profile — Trang cá nhân
    public function profileForm(): void
    {
        $this->requireAuth();
        $user = $this->user->findById((int)$_SESSION['user_id']);
        $this->view('pages/profile', [
            'pageTitle'  => 'Trang cá nhân – GameNexus',
            'user'       => $user,
            'categories' => $this->category->all(),
        ]);
    }

    // POST /profile/update — Cập nhật thông tin
    public function updateProfile(): void
    {
        $this->requireAuth();
        $isAjax = $this->isAjax();

        $userId   = (int)$_SESSION['user_id'];
        $fullName = trim($_POST['full_name'] ?? '');
        $password = $_POST['password'] ?? '';
        $confirm  = $_POST['confirm_password'] ?? '';

        // Validate
        if (!empty($password)) {
            $v = new Validator();
            $v->minLength('password', $password, 8, 'Mật khẩu')
                ->match('confirm_password', $password, $confirm, 'Xác nhận mật khẩu');

            if ($v->fails()) {
                if ($isAjax) {
                    $this->json(['success' => false, 'message' => $v->firstError()], 422);
                }
                return;
            }
        }

        // Xử lý upload avatar
        $avatar = null;
        if (!empty($_FILES['avatar']['tmp_name']) && $_FILES['avatar']['error'] === UPLOAD_ERR_OK) {
            $file    = $_FILES['avatar'];
            $allowed = ['image/jpeg', 'image/png', 'image/webp', 'image/gif'];
            $mime    = mime_content_type($file['tmp_name']);

            if (in_array($mime, $allowed) && $file['size'] <= 2 * 1024 * 1024) {
                $uploadDir = BASE_PATH . '/public/images/uploads/avatars/';
                if (!is_dir($uploadDir)) mkdir($uploadDir, 0755, true);

                $ext      = strtolower(pathinfo($file['name'], PATHINFO_EXTENSION));
                $filename = 'avatar_' . $userId . '_' . time() . '.' . $ext;

                if (move_uploaded_file($file['tmp_name'], $uploadDir . $filename)) {
                    $avatar = BASE_URL . '/public/images/uploads/avatars/' . $filename;
                }
            }
        }

        $data = ['full_name' => $fullName];
        if ($avatar)            $data['avatar']   = $avatar;
        if (!empty($password))  $data['password'] = $password;

        $this->user->updateProfile($userId, $data);

        // Cập nhật username trong session nếu có full_name
        if ($fullName) $_SESSION['full_name'] = $fullName;

        Logger::log('profile.update', "User #{$userId} updated profile");

        if ($isAjax) {
            $this->json(['success' => true, 'message' => 'Cập nhật thành công!']);
            return;
        }

        $this->redirect('/profile');
    }

    // GET /profile/history — Lịch sử đọc
    public function readHistory(): void
    {
        $this->requireAuth();
        $history = $this->article->getReadHistory((int)$_SESSION['user_id'], 30);
        $this->view('pages/history', [
            'pageTitle'  => 'Lịch sử đọc – GameNexus',
            'history'    => $history,
            'categories' => $this->category->all(),
        ]);
    }
}
