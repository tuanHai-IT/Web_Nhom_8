<!DOCTYPE html>
<html lang="en" data-bs-theme="dark">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?= htmlspecialchars($pageTitle ?? 'Admin') ?> - GameNexus</title>
    <meta name="csrf-token" content="<?= Csrf::token() ?>">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;700;900&family=Exo+2:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link rel="stylesheet" href="<?= BASE_URL ?>/public/css/style.css">
    <link rel="stylesheet" href="<?= BASE_URL ?>/public/css/admin.css">
</head>

<body class="admin-body">
    <?php
    $isActive = static function (string $path): string {
        return str_contains($_SERVER['REQUEST_URI'], $path) ? 'active' : '';
    };

    $renderAdminNav = static function (bool $dismissOnClick = false) use ($isActive): void {
        $dismissAttr = $dismissOnClick ? ' data-admin-mobile-nav="true"' : '';
    ?>
        <li class="nav-item">
            <a class="admin-nav-link <?= $isActive('/admin') && !$isActive('/admin/') ? 'active' : '' ?>"
                href="<?= BASE_URL ?>/admin"<?= $dismissAttr ?>>
                <i class="bi bi-speedometer2"></i> Dashboard
            </a>
        </li>
        <li class="nav-item">
            <a class="admin-nav-link <?= $isActive('/admin/articles') ?>"
                href="<?= BASE_URL ?>/admin/articles"<?= $dismissAttr ?>>
                <i class="bi bi-newspaper"></i> Articles
            </a>
        </li>
        <li class="nav-item">
            <a class="admin-nav-link <?= $isActive('/admin/categories') ?>"
                href="<?= BASE_URL ?>/admin/categories"<?= $dismissAttr ?>>
                <i class="bi bi-grid-3x3-gap"></i> Categories
            </a>
        </li>
        <li class="nav-item">
            <a class="admin-nav-link <?= $isActive('/admin/comments') ?>"
                href="<?= BASE_URL ?>/admin/comments"<?= $dismissAttr ?>>
                <i class="bi bi-chat-left-dots"></i> Comments
            </a>
        </li>
        <li class="nav-item">
            <a class="admin-nav-link <?= $isActive('/admin/upcoming-games') ?>"
                href="<?= BASE_URL ?>/admin/upcoming-games"<?= $dismissAttr ?>>
                <i class="bi bi-hourglass-split"></i> Upcoming Games
            </a>
        </li>
        <li class="nav-item">
            <a class="admin-nav-link <?= $isActive('/admin/trending-games') ?>"
                href="<?= BASE_URL ?>/admin/trending-games"<?= $dismissAttr ?>>
                <i class="bi bi-fire"></i> Trending Games
            </a>
        </li>
        <li class="nav-item">
            <a class="admin-nav-link <?= $isActive('/admin/users') ?>"
                href="<?= BASE_URL ?>/admin/users"<?= $dismissAttr ?>>
                <i class="bi bi-people"></i> Users
            </a>
        </li>
        <li class="nav-item mt-auto">
            <a class="admin-nav-link" href="<?= BASE_URL ?>/" target="_blank"<?= $dismissAttr ?>>
                <i class="bi bi-box-arrow-up-right"></i> View Site
            </a>
        </li>
        <li class="nav-item">
            <form method="POST" action="<?= BASE_URL ?>/auth/logout">
                <?= Csrf::field() ?>
                <button type="submit" class="admin-nav-link text-danger w-100 border-0 bg-transparent text-start"<?= $dismissAttr ?>>
                    <i class="bi bi-box-arrow-right"></i> Logout
                </button>
            </form>
        </li>
    <?php
    };

    ?>

    <div class="d-flex" style="min-height:100vh">

        <!-- Sidebar -->
        <nav class="admin-sidebar d-none d-md-flex flex-column">
            <div class="admin-brand d-flex align-items-center gap-2">
                <img src="<?= BASE_URL ?>/public/images/logo-wolf.png"
                    alt="GameNexus icon"
                    style="height: 38px; width: auto; object-fit: contain;">
                <div>
                    <span style="font-family: 'Exo 2', sans-serif; font-weight: 700; font-size: 1rem;">
                        <span style="color: #ffffff;">Game</span><span style="color: #e63946;">Nexus</span>
                    </span>
                    <small style="display:block; font-size:0.7rem; color:#7a7f8a; font-weight:400; letter-spacing:1px;">Admin Panel</small>
                </div>
            </div>

            <ul class="nav flex-column gap-1 px-2 flex-grow-1 mt-3">
                <?php $renderAdminNav(); ?>
            </ul>
        </nav>

        <!-- Main content -->
        <div class="admin-content flex-grow-1">
            <!-- Topbar -->
            <div class="admin-topbar">
                <div class="d-none d-md-flex align-items-center justify-content-between px-4 py-3">
                    <h5 class="mb-0" style="font-family:var(--font-display)">
                        <?= htmlspecialchars($pageTitle ?? 'Dashboard') ?>
                    </h5>
                    <span class="small text-muted">
                        <i class="bi bi-person-circle me-1"></i>
                        <?= htmlspecialchars($_SESSION['username'] ?? 'Admin') ?>
                    </span>
                </div>

                <div class="admin-mobile-topbar d-flex d-md-none align-items-center justify-content-between px-3 py-3">
                    <a class="admin-mobile-brand text-decoration-none" href="<?= BASE_URL ?>/admin">
                        <img src="<?= BASE_URL ?>/public/images/logo-wolf.png"
                            alt="GameNexus icon"
                            style="height: 34px; width: auto; object-fit: contain;">
                        <span style="font-family: 'Exo 2', sans-serif; font-weight: 700; font-size: 1rem;">
                            <span style="color: #ffffff;">Game</span><span style="color: #e63946;">Nexus</span>
                        </span>
                    </a>

                    <button class="admin-mobile-menu-btn" type="button" data-bs-toggle="offcanvas"
                        data-bs-target="#adminMobileSidebar" aria-controls="adminMobileSidebar" aria-label="Open navigation menu">
                        <i class="bi bi-list"></i>
                    </button>
                </div>
            </div>

            <!-- Page content -->
            <div class="p-4">
                <?= $content ?>
            </div>
        </div>
    </div>

    <div class="offcanvas offcanvas-start admin-mobile-offcanvas d-md-none" tabindex="-1" id="adminMobileSidebar"
        aria-labelledby="adminMobileSidebarLabel">
        <div class="offcanvas-header admin-mobile-offcanvas-header">
            <div class="admin-mobile-offcanvas-brand" id="adminMobileSidebarLabel">
                <span class="admin-mobile-offcanvas-brand-line">
                    <img src="<?= BASE_URL ?>/public/images/logo-wolf.png"
                        alt="GameNexus icon"
                        style="height: 34px; width: auto; object-fit: contain;">
                    <span style="font-family: 'Exo 2', sans-serif; font-weight: 700; font-size: 1rem;">
                        <span style="color: #ffffff;">Game</span><span style="color: #e63946;">Nexus</span>
                    </span>
                </span>
                <small style="display:block; font-size:0.7rem; color:#7a7f8a; font-weight:400; letter-spacing:1px;">Admin Panel</small>
            </div>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas" aria-label="Close"></button>
        </div>

        <div class="offcanvas-body d-flex flex-column p-0">
            <ul class="nav flex-column gap-1 px-2 flex-grow-1 mt-3">
                <?php $renderAdminNav(true); ?>
            </ul>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        const BASE_URL = '<?= BASE_URL ?>';
        const CSRF_TOKEN = '<?= Csrf::token() ?>';

        const adminMobileSidebar = document.getElementById('adminMobileSidebar');

        if (adminMobileSidebar && window.bootstrap?.Offcanvas) {
            const adminMobileSidebarInstance = bootstrap.Offcanvas.getOrCreateInstance(adminMobileSidebar);
            let pendingAdminMobileAction = null;

            adminMobileSidebar.addEventListener('click', (event) => {
                const link = event.target.closest('a.admin-nav-link[data-admin-mobile-nav]');

                if (link) {
                    if (link.target === '_blank') {
                        adminMobileSidebarInstance.hide();
                        return;
                    }

                    event.preventDefault();
                    pendingAdminMobileAction = () => {
                        window.location.href = link.href;
                    };
                    adminMobileSidebarInstance.hide();
                    return;
                }

                const submitButton = event.target.closest('button.admin-nav-link[data-admin-mobile-nav][type="submit"]');

                if (submitButton?.form) {
                    event.preventDefault();
                    pendingAdminMobileAction = () => {
                        submitButton.form.submit();
                    };
                    adminMobileSidebarInstance.hide();
                }
            });

            adminMobileSidebar.addEventListener('hidden.bs.offcanvas', () => {
                if (!pendingAdminMobileAction) {
                    return;
                }

                const action = pendingAdminMobileAction;
                pendingAdminMobileAction = null;
                action();
            });
        }
    </script>
    <!-- Chart.js CDN for dashboard widgets -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.7/dist/chart.umd.min.js"></script>
    <script src="<?= BASE_URL ?>/public/js/admin.js"></script>
</body>

</html>
