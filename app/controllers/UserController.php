<?php
// app/controllers/UserController.php

require_once BASE_PATH . '/app/models/User.php';
require_once BASE_PATH . '/app/models/Article.php';
require_once BASE_PATH . '/app/models/Category.php';

class UserController extends Controller {

    private User     $user;
    private Article  $article;
    private Category $category;

    public function __construct() {
        $this->user     = new User();
        $this->article  = new Article();
        $this->category = new Category();
    }

    // GET /auth/login
    public function loginForm(): void {
        if (!empty($_SESSION['user_id'])) { $this->redirect('/'); }
        $this->view('auth/login', ['pageTitle' => 'Login – GameNexus']);
    }

    // POST /auth/login
    public function login(): void {
        $email    = trim($_POST['email'] ?? '');
        $password = $_POST['password'] ?? '';

        $user = $this->user->verify($email, $password);
        if (!$user) {
            $this->view('auth/login', [
                'pageTitle' => 'Login – GameNexus',
                'error'     => 'Invalid email or password.',
            ]);
            return;
        }

        // Regenerate session ID to prevent fixation
        session_regenerate_id(true);
        $_SESSION['user_id']  = $user['user_id'];
        $_SESSION['username'] = $user['username'];
        $_SESSION['email']    = $user['email'];
        $_SESSION['role']     = $user['role_name'] ?? 'user';

        $redirect = ($user['role_name'] === 'admin') ? '/admin' : '/';
        $this->redirect($redirect);
    }

    // GET /auth/register
    public function registerForm(): void {
        if (!empty($_SESSION['user_id'])) { $this->redirect('/'); }
        $this->view('auth/register', ['pageTitle' => 'Register – GameNexus']);
    }

    // POST /auth/register
    public function register(): void {
        $username = trim($_POST['username'] ?? '');
        $email    = trim($_POST['email'] ?? '');
        $password = $_POST['password'] ?? '';
        $confirm  = $_POST['confirm_password'] ?? '';
        $errors   = [];

        if (strlen($username) < 3)  $errors[] = 'Username must be at least 3 characters.';
        if (!filter_var($email, FILTER_VALIDATE_EMAIL)) $errors[] = 'Invalid email address.';
        if (strlen($password) < 6)  $errors[] = 'Password must be at least 6 characters.';
        if ($password !== $confirm)  $errors[] = 'Passwords do not match.';
        if ($this->user->emailExists($email))    $errors[] = 'Email already registered.';
        if ($this->user->usernameExists($username)) $errors[] = 'Username already taken.';

        if ($errors) {
            $this->view('auth/register', [
                'pageTitle' => 'Register – GameNexus',
                'errors'    => $errors,
                'old'       => compact('username', 'email'),
            ]);
            return;
        }

        $this->user->create(compact('username', 'email', 'password'));
        $this->redirect('/auth/login?registered=1');
    }

    // GET /auth/logout
    public function logout(): void {
        session_destroy();
        $this->redirect('/');
    }

    // GET /profile/bookmarks
    public function bookmarks(): void {
        $this->requireAuth();
        $bookmarks = $this->article->getUserBookmarks((int)$_SESSION['user_id']);
        $this->view('pages/bookmarks', [
            'pageTitle'  => 'My Bookmarks – GameNexus',
            'bookmarks'  => $bookmarks,
            'categories' => $this->category->all(),
        ]);
    }
}
