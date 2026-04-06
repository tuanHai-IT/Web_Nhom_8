<?php // app/views/auth/register.php 
?>
<div class="auth-page">
    <div class="auth-card">
        <!-- Header -->
        <h2 class="auth-title">
            <i class="bi bi-rocket-takeoff"></i>
            Join GameNexus
        </h2>

        <!-- Error messages -->
        <div id="formErrors" style="display: none;"></div>

        <!-- Registration Form -->
        <form id="registerForm" method="POST" action="<?= BASE_URL ?>/auth/register" novalidate>
            <?= $csrfField ?>

            <!-- Username Input -->
            <div class="auth-form-group">
                <label for="username">Username</label>
                <div class="auth-input-wrapper">
                    <i class="bi bi-person auth-input-icon"></i>
                    <input
                        type="text"
                        id="username"
                        name="username"
                        class="form-control"
                        placeholder="Choose a username"
                        required
                        minlength="3"
                        maxlength="80"
                        value="<?= htmlspecialchars($old['username'] ?? '') ?>">
                </div>
                <div id="usernameError" class="input-feedback"></div>
            </div>

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
                        value="<?= htmlspecialchars($old['email'] ?? '') ?>">
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
                        placeholder="Create a strong password"
                        required
                        minlength="8">
                    <button
                        type="button"
                        class="password-toggle"
                        id="passwordToggle"
                        title="Show/hide password"
                        aria-label="Toggle password visibility">
                        <i class="bi bi-eye"></i>
                    </button>
                </div>
                <!-- Password strength meter -->
                <div class="password-strength">
                    <div class="password-strength-meter" id="passwordMeter"></div>
                </div>
                <div class="password-strength-text" id="passwordStrength"></div>
                <div id="passwordError" class="input-feedback"></div>
            </div>

            <!-- Confirm Password Input -->
            <div class="auth-form-group">
                <label for="confirm_password">Confirm Password</label>
                <div class="auth-input-wrapper">
                    <i class="bi bi-lock-check auth-input-icon"></i>
                    <input
                        type="password"
                        id="confirm_password"
                        name="confirm_password"
                        class="form-control"
                        placeholder="Confirm your password"
                        required>
                    <button
                        type="button"
                        class="password-toggle"
                        id="confirmPasswordToggle"
                        title="Show/hide password"
                        aria-label="Toggle password visibility">
                        <i class="bi bi-eye"></i>
                    </button>
                </div>
                <div id="confirmPasswordError" class="input-feedback"></div>
            </div>

            <!-- Terms -->
            <div class="auth-remember" style="margin-bottom: 24px;">
                <input
                    type="checkbox"
                    id="terms"
                    name="terms"
                    value="1"
                    required>
                <label for="terms" style="margin-bottom: 0; cursor: pointer; font-size: 12px;">
                    I agree to the <a href="#" style="color: var(--accent); text-decoration: none;">Terms of Service</a>
                </label>
            </div>

            <!-- Submit Button -->
            <button
                type="submit"
                class="auth-submit"
                id="registerBtn">
                <i class="bi bi-person-check"></i>
                <span>Create Account</span>
            </button>
        </form>

        <!-- Footer Links -->
        <div class="auth-footer">
            <div class="auth-footer-text">
                Already have an account?
                <a href="<?= BASE_URL ?>/auth/login" class="auth-footer-link">
                    <span>Sign in here</span>
                    <i class="bi bi-arrow-right-short"></i>
                </a>
            </div>
        </div>
    </div>
</div>

<!-- JavaScript for password toggle, strength meter, and AJAX -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const registerForm = document.getElementById('registerForm');
        const passwordToggle = document.getElementById('passwordToggle');
        const confirmPasswordToggle = document.getElementById('confirmPasswordToggle');
        const passwordInput = document.getElementById('password');
        const confirmPasswordInput = document.getElementById('confirm_password');
        const registerBtn = document.getElementById('registerBtn');

        // Password visibility toggle
        function setupPasswordToggle(toggle, input) {
            if (toggle && input) {
                toggle.addEventListener('click', function() {
                    const isPassword = input.type === 'password';
                    input.type = isPassword ? 'text' : 'password';
                    this.innerHTML = isPassword ?
                        '<i class="bi bi-eye-slash"></i>' :
                        '<i class="bi bi-eye"></i>';
                    this.title = isPassword ? 'Hide password' : 'Show password';
                });
            }
        }

        setupPasswordToggle(passwordToggle, passwordInput);
        setupPasswordToggle(confirmPasswordToggle, confirmPasswordInput);

        // Password strength meter
        function checkPasswordStrength(password) {
            let strength = 0;

            if (password.length >= 8) strength++;
            if (password.length >= 12) strength++;
            if (/[a-z]/.test(password) && /[A-Z]/.test(password)) strength++;
            if (/\d/.test(password)) strength++;
            if (/[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/.test(password)) strength++;

            return Math.min(3, Math.ceil(strength / 2));
        }

        if (passwordInput) {
            passwordInput.addEventListener('input', function() {
                const strength = checkPasswordStrength(this.value);
                const meter = document.getElementById('passwordMeter');
                const text = document.getElementById('passwordStrength');

                const strengths = ['', 'weak', 'fair', 'strong'];
                const labels = ['', 'Weak password', 'Fair password', 'Strong password'];

                meter.className = 'password-strength-meter ' + strengths[strength];
                text.textContent = labels[strength];
                text.className = 'password-strength-text ' + strengths[strength];
            });
        }

        // AJAX registration
        registerForm.addEventListener('submit', function(e) {
            e.preventDefault();
            registerForm.classList.remove('was-validated');

            // Clear previous errors
            document.getElementById('formErrors').style.display = 'none';
            document.getElementById('formErrors').innerHTML = '';

            const formData = new FormData(registerForm);

            registerBtn.disabled = true;
            registerBtn.classList.add('loading');
            registerBtn.innerHTML = '<i class="bi bi-hourglass-split"></i><span> Creating account...</span>';

            fetch('<?= BASE_URL ?>/auth/register', {
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
                        // Show success message
                        const msgEl = document.createElement('div');
                        msgEl.className = 'auth-message success';
                        msgEl.innerHTML = '<i class="bi bi-check-circle-fill"></i><span>' + data.message + '</span>';
                        registerForm.parentElement.insertBefore(msgEl, registerForm);

                        // Redirect to login after 2 seconds
                        setTimeout(() => {
                            window.location.href = '<?= BASE_URL ?>/auth/login?registered=1';
                        }, 2000);
                    } else {
                        // Display error message
                        const errorMsg = document.getElementById('formErrors');
                        errorMsg.className = 'auth-message error';
                        errorMsg.innerHTML = '<i class="bi bi-exclamation-circle-fill"></i><span>' +
                            (data.message || 'Registration failed. Please try again.') + '</span>';
                        errorMsg.style.display = 'flex';

                        registerBtn.disabled = false;
                        registerBtn.classList.remove('loading');
                        registerBtn.innerHTML = '<i class="bi bi-person-check"></i><span>Create Account</span>';
                    }
                })
                .catch(err => {
                    console.error('Registration error:', err);
                    const errorMsg = document.getElementById('formErrors');
                    errorMsg.className = 'auth-message error';
                    // Show detailed error for debugging
                    const detailedMsg = err.message || 'Connection error. Please try again.';
                    errorMsg.innerHTML = '<i class="bi bi-exclamation-circle-fill"></i><span>' + detailedMsg + '</span>';
                    errorMsg.style.display = 'flex';

                    registerBtn.disabled = false;
                    registerBtn.classList.remove('loading');
                    registerBtn.innerHTML = '<i class="bi bi-person-check"></i><span>Create Account</span>';
                });
        });
    });
</script>