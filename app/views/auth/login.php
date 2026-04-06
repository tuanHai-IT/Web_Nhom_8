<?php // app/views/auth/login.php 
?>
<div class="auth-page">
    <div class="auth-card">
        <!-- Header -->
        <h2 class="auth-title">
            <i class="bi bi-controller"></i>
            Welcome Back
        </h2>

        <!-- Messages -->
        <?php if (isset($_GET['registered'])): ?>
            <div class="auth-message success" role="alert">
                <i class="bi bi-check-circle-fill"></i>
                <span>Account created! Please log in.</span>
            </div>
        <?php endif; ?>

        <?php if (isset($_GET['password_reset'])): ?>
            <div class="auth-message success" role="alert">
                <i class="bi bi-check-circle-fill"></i>
                <span>Password reset successfully. Please log in.</span>
            </div>
        <?php endif; ?>

        <?php if (isset($_GET['reset_sent'])): ?>
            <div class="auth-message success" role="alert">
                <i class="bi bi-check-circle-fill"></i>
                <span>Check your email for the password reset link.</span>
            </div>
        <?php endif; ?>

        <!-- Error messages from validation -->
        <div id="formErrors" style="display: none;"></div>

        <!-- Login Form -->
        <form id="loginForm" method="POST" action="<?= BASE_URL ?>/auth/login" novalidate>
            <?= $csrfField ?>
            <!-- Social Login -->
            <div class="social-login-wrapper">
                <button type="button" class="social-btn social-btn-google" id="googleLoginBtn">
                    <svg width="18" height="18" viewBox="0 0 48 48" style="margin-right:8px">
                        <path fill="#EA4335" d="M24 9.5c3.14 0 5.95 1.08 8.17 2.85l6.1-6.1C34.46 3.07 29.53 1 24 1 14.82 1 7.07 6.48 3.64 14.22l7.1 5.52C12.4 13.67 17.74 9.5 24 9.5z" />
                        <path fill="#4285F4" d="M46.52 24.5c0-1.64-.15-3.22-.42-4.74H24v8.98h12.7c-.55 2.94-2.2 5.43-4.67 7.1l7.18 5.58C43.46 37.3 46.52 31.36 46.52 24.5z" />
                        <path fill="#FBBC05" d="M10.74 28.26A14.53 14.53 0 0 1 9.5 24c0-1.48.25-2.91.7-4.26l-7.1-5.52A23.93 23.93 0 0 0 .5 24c0 3.87.92 7.53 2.55 10.78l7.69-6.52z" />
                        <path fill="#34A853" d="M24 47c5.53 0 10.17-1.83 13.56-4.97l-7.18-5.58c-1.83 1.23-4.17 1.95-6.38 1.95-6.26 0-11.6-4.17-13.26-9.74l-7.69 6.52C7.07 41.52 14.82 47 24 47z" />
                    </svg>
                    Đăng nhập với Google
                </button>
                <button type="button" class="social-btn social-btn-facebook" id="facebookLoginBtn">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="#fff" style="margin-right:8px">
                        <path d="M24 12.073C24 5.405 18.627 0 12 0S0 5.405 0 12.073C0 18.1 4.388 23.094 10.125 24v-8.437H7.078v-3.49h3.047V9.41c0-3.025 1.792-4.697 4.533-4.697 1.312 0 2.686.236 2.686.236v2.97h-1.513c-1.491 0-1.956.93-1.956 1.884v2.25h3.328l-.532 3.49h-2.796V24C19.612 23.094 24 18.1 24 12.073z" />
                    </svg>
                    Đăng nhập với Facebook
                </button>
            </div>
            <div class="social-divider"><span>hoặc đăng nhập bằng email</span></div>
            <!-- Email Input -->
            <div class="auth-form-group">
                <label for="email">Email Address</label>
                <div class="auth-input-wrapper">
                    <i class="bi bi-envelope auth-input-icon"></i>
                    <input
                        type="email"
                        id="email"
                        name="email"
                        class="form-control"
                        placeholder="Enter your email"
                        required
                        value="<?= htmlspecialchars($_POST['email'] ?? '') ?>">
                </div>
                <div id="emailError" class="input-feedback"></div>
            </div>

            <!-- Password Input -->
            <div class="auth-form-group">
                <label for="password">Password</label>
                <div class="auth-input-wrapper">
                    <i class="bi bi-lock auth-input-icon"></i>
                    <input
                        type="password"
                        id="password"
                        name="password"
                        class="form-control"
                        placeholder="Enter your password"
                        required>
                    <button
                        type="button"
                        class="password-toggle"
                        id="passwordToggle"
                        title="Show/hide password"
                        aria-label="Toggle password visibility">
                        <i class="bi bi-eye"></i>
                    </button>
                </div>
                <div id="passwordError" class="input-feedback"></div>
            </div>

            <!-- Remember Me -->
            <div class="auth-remember">
                <input
                    type="checkbox"
                    id="remember"
                    name="remember"
                    value="1">
                <label for="remember" style="margin-bottom: 0; cursor: pointer;">
                    Remember me on this device
                </label>
            </div>

            <!-- Submit Button -->
            <button
                type="submit"
                class="auth-submit"
                id="loginBtn">
                <i class="bi bi-box-arrow-in-right"></i>
                <span>Sign In</span>
            </button>
        </form>

        <!-- Footer Links -->
        <div class="auth-footer">
            <div class="auth-footer-text">
                Don't have an account?
                <a href="<?= BASE_URL ?>/auth/register" class="auth-footer-link">
                    <span>Register now</span>
                    <i class="bi bi-arrow-right-short"></i>
                </a>
            </div>
            <div class="auth-footer-text">
                <a href="<?= BASE_URL ?>/auth/forgot-password" class="auth-footer-link">
                    <i class="bi bi-question-circle"></i>
                    <span>Forgot password?</span>
                </a>
            </div>
        </div>
    </div>
</div>
<style>
    .social-login-wrapper {
        display: flex;
        flex-direction: column;
        gap: 10px;
        margin-bottom: 16px;
    }

    .social-btn {
        display: flex;
        align-items: center;
        justify-content: center;
        width: 100%;
        padding: 10px 16px;
        border: none;
        border-radius: 8px;
        font-size: 14px;
        font-weight: 500;
        cursor: pointer;
        transition: opacity .2s, transform .1s;
    }

    .social-btn:hover {
        opacity: .88;
        transform: translateY(-1px);
    }

    .social-btn:active {
        transform: translateY(0);
    }

    .social-btn-google {
        background: #fff;
        color: #3c4043;
        border: 1px solid #dadce0;
    }

    .social-btn-facebook {
        background: #1877F2;
        color: #fff;
    }

    .social-divider {
        display: flex;
        align-items: center;
        gap: 12px;
        margin: 4px 0 20px;
        color: var(--text-muted);
        font-size: 12px;
    }

    .social-divider::before,
    .social-divider::after {
        content: '';
        flex: 1;
        height: 1px;
        background: rgba(255, 255, 255, 0.1);
    }
</style>
<!-- JavaScript for password toggle and AJAX -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const loginForm = document.getElementById('loginForm');
        const passwordToggle = document.getElementById('passwordToggle');
        const passwordInput = document.getElementById('password');
        const loginBtn = document.getElementById('loginBtn');
        // ── GOOGLE LOGIN ──────────────────────────────────────────────────────
        const GOOGLE_CLIENT_ID = 'YOUR_GOOGLE_CLIENT_ID'; // thay bằng Client ID thật

        window.handleGoogleLogin = function(response) {
            const btn = document.getElementById('googleLoginBtn');
            btn.disabled = true;
            btn.textContent = 'Đang xử lý...';

            fetch('<?= BASE_URL ?>/auth/social-callback', {
                    method: 'POST',
                    credentials: 'same-origin',
                    headers: {
                        'Content-Type': 'application/json',
                        'X-Requested-With': 'XMLHttpRequest',
                        'X-CSRF-TOKEN': CSRF_TOKEN
                    },
                    body: JSON.stringify({
                        provider: 'google',
                        credential: response.credential
                    })
                })
                .then(r => r.json())
                .then(data => {
                    if (data.success) {
                        window.location.href = data.redirect || '<?= BASE_URL ?>/';
                    } else {
                        showSocialError(data.message || 'Đăng nhập Google thất bại.');
                        btn.disabled = false;
                        btn.textContent = 'Đăng nhập với Google';
                    }
                })
                .catch(() => {
                    showSocialError('Lỗi kết nối. Vui lòng thử lại.');
                    btn.disabled = false;
                });
        };

        document.getElementById('googleLoginBtn').addEventListener('click', function() {
            if (typeof google !== 'undefined') {
                google.accounts.id.prompt();
            } else {
                showSocialError('Google SDK chưa tải. Vui lòng tải lại trang.');
            }
        });

        // ── FACEBOOK LOGIN ────────────────────────────────────────────────────
        const FB_APP_ID = 'YOUR_FACEBOOK_APP_ID'; // thay bằng App ID thật

        window.fbAsyncInit = function() {
            FB.init({
                appId: FB_APP_ID,
                cookie: true,
                xfbml: true,
                version: 'v19.0'
            });
        };

        document.getElementById('facebookLoginBtn').addEventListener('click', function() {
            const btn = this;
            if (typeof FB === 'undefined') {
                showSocialError('Facebook SDK chưa tải. Vui lòng tải lại trang.');
                return;
            }
            FB.login(function(response) {
                if (response.authResponse) {
                    btn.disabled = true;
                    btn.textContent = 'Đang xử lý...';

                    fetch('<?= BASE_URL ?>/auth/social-callback', {
                            method: 'POST',
                            credentials: 'same-origin',
                            headers: {
                                'Content-Type': 'application/json',
                                'X-Requested-With': 'XMLHttpRequest',
                                'X-CSRF-TOKEN': CSRF_TOKEN
                            },
                            body: JSON.stringify({
                                provider: 'facebook',
                                access_token: response.authResponse.accessToken
                            })
                        })
                        .then(r => r.json())
                        .then(data => {
                            if (data.success) {
                                window.location.href = data.redirect || '<?= BASE_URL ?>/';
                            } else {
                                showSocialError(data.message || 'Đăng nhập Facebook thất bại.');
                                btn.disabled = false;
                                btn.textContent = 'Đăng nhập với Facebook';
                            }
                        })
                        .catch(() => {
                            showSocialError('Lỗi kết nối. Vui lòng thử lại.');
                            btn.disabled = false;
                        });
                }
            }, {
                scope: 'public_profile,email'
            });
        });

        // Helper hiển thị lỗi social
        function showSocialError(msg) {
            const el = document.getElementById('formErrors');
            el.className = 'auth-message error';
            el.innerHTML = '<i class="bi bi-exclamation-circle-fill"></i><span>' + msg + '</span>';
            el.style.display = 'flex';
        }
        // Password visibility toggle
        if (passwordToggle && passwordInput) {
            passwordToggle.addEventListener('click', function() {
                const isPassword = passwordInput.type === 'password';
                passwordInput.type = isPassword ? 'text' : 'password';
                this.innerHTML = isPassword ?
                    '<i class="bi bi-eye-slash"></i>' :
                    '<i class="bi bi-eye"></i>';
                this.attr = isPassword ? 'Hide password' : 'Show password';
            });
        }

        // AJAX login
        loginForm.addEventListener('submit', function(e) {
            e.preventDefault();
            loginForm.classList.remove('was-validated');

            // Clear previous errors
            document.getElementById('formErrors').style.display = 'none';
            document.getElementById('formErrors').innerHTML = '';

            const formData = new FormData(loginForm);

            loginBtn.disabled = true;
            loginBtn.classList.add('loading');
            loginBtn.innerHTML = '<i class="bi bi-hourglass-split"></i><span> Signing in...</span>';

            fetch('<?= BASE_URL ?>/auth/login', {
                    method: 'POST',
                    body: formData,
                    credentials: 'same-origin',
                    headers: {
                        'X-Requested-With': 'XMLHttpRequest',
                    }
                })
                .then(res => {
                    // Check HTTP status
                    if (!res.ok) {
                        throw new Error(`HTTP ${res.status}: ${res.statusText}`);
                    }
                    return res.json();
                })
                .then(data => {
                    if (data.success) {
                        // Show success message briefly
                        const msgEl = document.createElement('div');
                        msgEl.className = 'auth-message success';
                        msgEl.innerHTML = '<i class="bi bi-check-circle-fill"></i><span>' + data.message + '</span>';
                        loginForm.parentElement.insertBefore(msgEl, loginForm);

                        // Redirect after 1 second
                        setTimeout(() => {
                            window.location.href = '<?= BASE_URL ?>/';
                        }, 1000);
                    } else {
                        // Display error message
                        const errorMsg = document.getElementById('formErrors');
                        errorMsg.className = 'auth-message error';
                        errorMsg.innerHTML = '<i class="bi bi-exclamation-circle-fill"></i><span>' +
                            (data.message || 'An error occurred. Please try again.') + '</span>';
                        errorMsg.style.display = 'flex';

                        loginBtn.disabled = false;
                        loginBtn.classList.remove('loading');
                        loginBtn.innerHTML = '<i class="bi bi-box-arrow-in-right"></i><span>Sign In</span>';
                    }
                })
                .catch(err => {
                    console.error('Login error:', err);
                    const errorMsg = document.getElementById('formErrors');
                    errorMsg.className = 'auth-message error';
                    // Show detailed error for debugging
                    const detailedMsg = err.message || 'Connection error. Please try again.';
                    errorMsg.innerHTML = '<i class="bi bi-exclamation-circle-fill"></i><span>' + detailedMsg + '</span>';
                    errorMsg.style.display = 'flex';

                    loginBtn.disabled = false;
                    loginBtn.classList.remove('loading');
                    loginBtn.innerHTML = '<i class="bi bi-box-arrow-in-right"></i><span>Sign In</span>';
                });
        });
    });
</script>
<!-- Google Identity Services -->
<script src="https://accounts.google.com/gsi/client" async defer></script>
<div id="g_id_onload"
    data-client_id="YOUR_GOOGLE_CLIENT_ID"
    data-callback="handleGoogleLogin"
    data-auto_prompt="false">
</div>

<!-- Facebook SDK -->
<script async defer src="https://connect.facebook.net/vi_VN/sdk.js"></script>