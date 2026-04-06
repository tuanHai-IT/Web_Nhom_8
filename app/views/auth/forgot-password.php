<?php // app/views/auth/forgot-password.php 
?>
<div class="auth-page">
    <div class="auth-card">
        <!-- Header -->
        <h2 class="auth-title">
            <i class="bi bi-question-circle"></i>
            Forgot Password?
        </h2>

        <!-- Info message -->
        <div class="auth-message info">
            <i class="bi bi-info-circle-fill"></i>
            <span>Enter your email address and we'll send you a password reset link.</span>
        </div>

        <!-- Error messages -->
        <div id="formErrors" style="display: none;"></div>

        <!-- Forgot Password Form -->
        <form id="forgotPasswordForm" method="POST" action="<?= BASE_URL ?>/auth/forgot-password" novalidate>
            <?= $csrfField ?>

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
                        placeholder="Enter your registered email"
                        required
                        value="<?= htmlspecialchars($old['email'] ?? '') ?>">
                </div>
                <div id="emailError" class="input-feedback"></div>
            </div>

            <!-- Submit Button -->
            <button
                type="submit"
                class="auth-submit"
                id="submitBtn">
                <i class="bi bi-send"></i>
                <span>Send Reset Link</span>
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
            <div class="auth-footer-text">
                Don't have an account?
                <a href="<?= BASE_URL ?>/auth/register" class="auth-footer-link">
                    <span>Register now</span>
                    <i class="bi bi-arrow-right-short"></i>
                </a>
            </div>
        </div>
    </div>
</div>

<!-- JavaScript for AJAX -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const forgotPasswordForm = document.getElementById('forgotPasswordForm');
        const submitBtn = document.getElementById('submitBtn');

        forgotPasswordForm.addEventListener('submit', function(e) {
            e.preventDefault();
            forgotPasswordForm.classList.remove('was-validated');

            // Clear previous errors
            document.getElementById('formErrors').style.display = 'none';
            document.getElementById('formErrors').innerHTML = '';

            const formData = new FormData(forgotPasswordForm);

            submitBtn.disabled = true;
            submitBtn.classList.add('loading');
            submitBtn.innerHTML = '<i class="bi bi-hourglass-split"></i><span> Sending...</span>';

            fetch('<?= BASE_URL ?>/auth/forgot-password', {
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
                        // Show success message
                        const card = document.querySelector('.auth-card');
                        card.innerHTML = `
                    <div class="auth-title">
                        <i class="bi bi-check-circle-fill"></i>
                        Check Your Email
                    </div>
                    <div class="auth-message success" style="margin-bottom: 32px;">
                        <i class="bi bi-check-circle-fill"></i>
                        <span>We've sent you a password reset link. Check your inbox!</span>
                    </div>
                    <p style="text-align: center; color: var(--text-muted); font-size: 14px; line-height: 1.6; margin-bottom: 28px;">
                        The reset link will expire in 1 hour. If you don't see the email, check your spam folder.
                    </p>
                    <div class="auth-footer">
                        <div class="auth-footer-text">
                            <a href="${BASE_URL}/auth/login" class="auth-footer-link">
                                <i class="bi bi-arrow-left"></i>
                                <span>Back to login</span>
                            </a>
                        </div>
                    </div>
                `;
                    } else {
                        // Display error message
                        const errorMsg = document.getElementById('formErrors');
                        errorMsg.className = 'auth-message error';
                        errorMsg.innerHTML = '<i class="bi bi-exclamation-circle-fill"></i><span>' +
                            (data.message || 'An error occurred. Please try again.') + '</span>';
                        errorMsg.style.display = 'flex';

                        submitBtn.disabled = false;
                        submitBtn.classList.remove('loading');
                        submitBtn.innerHTML = '<i class="bi bi-send"></i><span>Send Reset Link</span>';
                    }
                })
                .catch(err => {
                    console.error('Error:', err);
                    const errorMsg = document.getElementById('formErrors');
                    errorMsg.className = 'auth-message error';
                    const detailedMsg = err.message || 'Connection error. Please try again.';
                    errorMsg.innerHTML = '<i class="bi bi-exclamation-circle-fill"></i><span>' + detailedMsg + '</span>';
                    errorMsg.style.display = 'flex';

                    submitBtn.disabled = false;
                    submitBtn.classList.remove('loading');
                    submitBtn.innerHTML = '<i class="bi bi-send"></i><span>Send Reset Link</span>';
                });
        });
    });
</script>