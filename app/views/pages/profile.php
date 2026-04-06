<?php // app/views/pages/profile.php 
?>
<div class="container py-4">
    <div class="row g-4 justify-content-center">
        <div class="col-lg-7">

            <div class="gn-sidebar-widget">
                <div class="widget-title mb-4">
                    <i class="bi bi-person-circle me-2"></i>Trang cá nhân
                </div>

                <!-- Avatar hiện tại -->
                <div class="text-center mb-4">
                    <img src="<?= !empty($user['avatar']) ? htmlspecialchars($user['avatar']) : BASE_URL . '/public/images/default-avatar.png' ?>"
                        alt="Avatar" id="avatarPreview"
                        style="width:100px;height:100px;border-radius:50%;object-fit:cover;border:3px solid var(--accent)">
                    <div class="mt-2 small text-muted">@<?= htmlspecialchars($user['username']) ?></div>
                    <span class="badge bg-danger mt-1"><?= htmlspecialchars($user['role_name'] ?? 'member') ?></span>
                </div>

                <!-- Alert thông báo -->
                <div id="profileAlert" style="display:none;" class="mb-3"></div>

                <!-- Form -->
                <form id="profileForm" enctype="multipart/form-data">
                    <?= $csrfField ?>

                    <div class="mb-3">
                        <label class="form-label">Username</label>
                        <input type="text" class="form-control"
                            value="<?= htmlspecialchars($user['username']) ?>" disabled>
                        <div class="form-text">Username không thể thay đổi.</div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <input type="email" class="form-control"
                            value="<?= htmlspecialchars($user['email']) ?>" disabled>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Họ và tên</label>
                        <input type="text" name="full_name" class="form-control"
                            placeholder="Nhập họ và tên"
                            value="<?= htmlspecialchars($user['full_name'] ?? '') ?>">
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Ảnh đại diện</label>
                        <input type="file" name="avatar" id="avatarInput"
                            class="form-control" accept="image/jpeg,image/png,image/webp">
                        <div class="form-text">JPG, PNG, WebP. Tối đa 2MB.</div>
                    </div>

                    <hr class="border-secondary">
                    <p class="small text-muted mb-3">Để trống nếu không muốn đổi mật khẩu</p>

                    <div class="mb-3">
                        <label class="form-label">Mật khẩu mới</label>
                        <div class="input-group">
                            <input type="password" name="password" id="newPassword"
                                class="form-control" placeholder="Nhập mật khẩu mới" minlength="8">
                            <button type="button" class="btn btn-outline-secondary" id="pwToggle">
                                <i class="bi bi-eye"></i>
                            </button>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label class="form-label">Xác nhận mật khẩu mới</label>
                        <div class="input-group">
                            <input type="password" name="confirm_password" id="confirmPassword"
                                class="form-control" placeholder="Nhập lại mật khẩu mới">
                            <button type="button" class="btn btn-outline-secondary" id="confirmPwToggle">
                                <i class="bi bi-eye"></i>
                            </button>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-accent w-100" id="saveBtn">
                        <i class="bi bi-check-circle me-1"></i>Lưu thay đổi
                    </button>
                </form>

                <!-- Quick links -->
                <div class="d-flex gap-3 mt-4 pt-3 border-top border-secondary">
                    <a href="<?= BASE_URL ?>/profile/bookmarks" class="text-muted small text-decoration-none">
                        <i class="bi bi-bookmark-heart me-1"></i>Bookmarks
                    </a>
                    <a href="<?= BASE_URL ?>/profile/history" class="text-muted small text-decoration-none">
                        <i class="bi bi-clock-history me-1"></i>Lịch sử đọc
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {

        // Preview avatar trước khi upload
        document.getElementById('avatarInput').addEventListener('change', function() {
            const file = this.files[0];
            if (!file) return;
            if (file.size > 2 * 1024 * 1024) {
                alert('Ảnh quá lớn! Tối đa 2MB.');
                this.value = '';
                return;
            }
            const reader = new FileReader();
            reader.onload = e => {
                document.getElementById('avatarPreview').src = e.target.result;
            };
            reader.readAsDataURL(file);
        });

        // Toggle hiện/ẩn mật khẩu
        document.getElementById('pwToggle').addEventListener('click', function() {
            const input = document.getElementById('newPassword');
            const isPass = input.type === 'password';
            input.type = isPass ? 'text' : 'password';
            this.innerHTML = isPass ? '<i class="bi bi-eye-slash"></i>' : '<i class="bi bi-eye"></i>';
        });

        // Toggle hiện/ẩn xác nhận mật khẩu
        document.getElementById('confirmPwToggle').addEventListener('click', function() {
            const input = document.getElementById('confirmPassword');
            const isPass = input.type === 'password';
            input.type = isPass ? 'text' : 'password';
            this.innerHTML = isPass ? '<i class="bi bi-eye-slash"></i>' : '<i class="bi bi-eye"></i>';
        });

        // Submit AJAX
        document.getElementById('profileForm').addEventListener('submit', function(e) {
            e.preventDefault();

            const btn = document.getElementById('saveBtn');
            btn.disabled = true;
            btn.innerHTML = '<i class="bi bi-hourglass-split me-1"></i>Đang lưu...';

            const formData = new FormData(this);

            fetch('<?= BASE_URL ?>/profile/update', {
                    method: 'POST',
                    body: formData,
                    credentials: 'same-origin',
                    headers: {
                        'X-Requested-With': 'XMLHttpRequest',
                        'X-CSRF-TOKEN': CSRF_TOKEN
                    }
                })
                .then(r => r.json())
                .then(data => {
                    const alert = document.getElementById('profileAlert');
                    if (data.success) {
                        alert.className = 'auth-message success';
                        alert.innerHTML = '<i class="bi bi-check-circle-fill"></i><span>' + data.message + '</span>';
                    } else {
                        alert.className = 'auth-message error';
                        alert.innerHTML = '<i class="bi bi-exclamation-circle-fill"></i><span>' + data.message + '</span>';
                    }
                    alert.style.display = 'flex';
                    btn.disabled = false;
                    btn.innerHTML = '<i class="bi bi-check-circle me-1"></i>Lưu thay đổi';
                })
                .catch(() => {
                    btn.disabled = false;
                    btn.innerHTML = '<i class="bi bi-check-circle me-1"></i>Lưu thay đổi';
                });
        });
    });
</script>