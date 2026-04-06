<?php // app/views/auth/reset-password.php 
?>
<div class="auth-page">
    <div class="auth-card">
        <!-- Header -->
        <h2 class="auth-title">
            <i class="bi bi-shield-lock"></i>
            Reset Password
        </h2>

        <!-- Error messages -->
        <?php if (isset($tokenError)): ?>
            <div class="auth-message error" style="margin-bottom: 24px;">
                <i class="bi bi-exclamation-circle-fill"></i>
                <span><?= htmlspecialchars($tokenError) ?></span>
            </div>
            <div class="auth-footer">
                <div class="auth-footer-text">
                    <a href="<?= BASE_URL ?>/auth/forgot-password" class="auth-footer-link">
                        <i class="bi bi-arrow-left"></i>
                        <span>Request a new link</span>
                    </a>
                </div>
            </div>
        <?php else: ?>

            <div id="formErrors" style="display: none;"></div>

            <!-- Reset Password Form -->
            <form id="resetPasswordForm" method="POST" action="<?= BASE_URL ?>/auth/reset-password" novalidate>
                <?= $csrfField ?>
                <input type="hidden" name="token" value="<?= htmlspecialchars($token ?? '') ?>">

                <!-- New Password Input -->
                <div class="auth-form-group">
                    <label for="password">New Password</label>
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

                <!-- Submit Button -->
                <button
                    type="submit"
                    class="auth-submit"
                    id="submitBtn">
                    <i class="bi bi-check-circle"></i>
                    <span>Reset Password</span>
                </button>
            </form>

            <!-- Footer Links -->
            <div class="auth-footer">
                <div class="auth-footer-text">
                    Remember your password?
                    <a href="<?= BASE_URL ?>/auth/login" class="auth-footer-link">
                        <span>Sign in</span>
                        <i class="bi bi-arrow-right-short"></i>
                    </a>
                </div>
            </div>

        <?php endif; ?>
    </div>
</div>

<?php if (!isset($tokenError)): ?>
    <!-- JavaScript for password toggle, strength meter, and AJAX -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const resetPasswordForm = document.getElementById('resetPasswordForm');
            const passwordToggle = document.getElementById('passwordToggle');
            const confirmPasswordToggle = document.getElementById('confirmPasswordToggle');
            const passwordInput = document.getElementById('password');
            const confirmPasswordInput = document.getElementById('confirm_password');
            const submitBtn = document.getElementById('submitBtn');

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

            // AJAX password reset
            resetPasswordForm.addEventListener('submit', function(e) {
                e.preventDefault();
                resetPasswordForm.classList.remove('was-validated');

                // Clear previous errors
                document.getElementById('formErrors').style.display = 'none';
                document.getElementById('formErrors').innerHTML = '';

                const formData = new FormData(resetPasswordForm);

                submitBtn.disabled = true;
                submitBtn.classList.add('loading');
                submitBtn.innerHTML = '<i class="bi bi-hourglass-split"></i><span> Resetting...</span>';

                fetch('<?= BASE_URL ?>/auth/reset-password', {
                        method: 'POST',
                        body: formData,
                        credentials: 'same-origin',
                        headers: {
                            'X-Requested-With': 'XMLHttpRequest',
                        }
                    })
                    .then(res => {
                        if (!res.ok) {
                            throw new Error(`HTTP ${res.status}: ${res.statusText}`);
                        }
                        return res.json();
                    })
                    .then(data => {
                        if (data.success) {
                            // Show success message and redirect
                            const card = document.querySelector('.auth-card');
                            card.innerHTML = `
                    <div class="auth-title">
                        <i class="bi bi-check-circle-fill"></i>
                        Password Reset
                    </div>
                    <div class="auth-message success" style="margin-bottom: 32px;">
                        <i class="bi bi-check-circle-fill"></i>
                        <span>Your password has been reset successfully!</span>
                    </div>
                    <p style="text-align: center; color: var(--text-muted); font-size: 14px; line-height: 1.6; margin-bottom: 28px;">
                        You will be redirected to the login page in a moment.
                    </p>
                    <div class="auth-footer">
                        <div class="auth-footer-text">
                            <a href="${BASE_URL}/auth/login?password_reset=1" class="auth-footer-link">
                                <i class="bi bi-box-arrow-in-right"></i>
                                <span>Sign in now</span>
                            </a>
                        </div>
                    </div>
                `;

                            // Redirect after 2 seconds
                            setTimeout(() => {
                                window.location.href = '<?= BASE_URL ?>/auth/login?password_reset=1';
                            }, 2000);
                        } else {
                            // Display error message
                            const errorMsg = document.getElementById('formErrors');
                            errorMsg.className = 'auth-message error';
                            errorMsg.innerHTML = '<i class="bi bi-exclamation-circle-fill"></i><span>' +
                                (data.message || 'An error occurred. Please try again.') + '</span>';
                            errorMsg.style.display = 'flex';

                            submitBtn.disabled = false;
                            submitBtn.classList.remove('loading');
                            submitBtn.innerHTML = '<i class="bi bi-check-circle"></i><span>Reset Password</span>';
                        }
                    })
                    .catch(err => {
                        console.error('Reset password error:', err);
                        const errorMsg = document.getElementById('formErrors');
                        errorMsg.className = 'auth-message error';
                        const detailedMsg = err.message || 'Connection error. Please try again.';
                        errorMsg.innerHTML = '<i class="bi bi-exclamation-circle-fill"></i><span>' + detailedMsg + '</span>';
                        errorMsg.style.display = 'flex';

                        submitBtn.disabled = false;
                        submitBtn.classList.remove('loading');
                        submitBtn.innerHTML = '<i class="bi bi-check-circle"></i><span>Reset Password</span>';
                    });
            });
        });
    </script>
<?php endif; ?>