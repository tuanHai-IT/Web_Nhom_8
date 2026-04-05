<!DOCTYPE html>
<html lang="en" data-bs-theme="dark">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?= htmlspecialchars($pageTitle ?? 'GameNexus') ?></title>
    <meta name="description" content="<?= htmlspecialchars($metaDescription ?? 'Your ultimate gaming news hub') ?>">

    <!-- CSRF token for AJAX requests -->
    <meta name="csrf-token" content="<?= Csrf::token() ?>">

    <!-- Open Graph -->
    <meta property="og:title" content="<?= htmlspecialchars($pageTitle ?? 'GameNexus') ?>">
    <meta property="og:description" content="<?= htmlspecialchars($metaDescription ?? 'Your ultimate gaming news hub') ?>">
    <meta property="og:type" content="website">
    <?php if (!empty($article['thumbnail'])): ?>
        <meta property="og:image" content="<?= htmlspecialchars($article['thumbnail']) ?>">
    <?php endif; ?>

    <!-- Google Fonts: Orbitron (display) + Exo 2 (body) -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;700;900&family=Exo+2:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <!-- Bootstrap 5 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="<?= BASE_URL ?>/public/css/style.css">
</head>

<body>

    <!-- ── BREAKING NEWS TICKER ─────────────────────────────────────────────── -->
    <?php if (!empty($breaking)): ?>
        <div class="breaking-ticker">
            <span class="ticker-label"><i class="bi bi-lightning-fill"></i> BREAKING</span>
            <div class="ticker-track">
                <div class="ticker-content">
                    <?php foreach ($breaking as $b): ?>
                        <a href="<?= BASE_URL ?>/article/<?= $b['slug'] ?>">
                            <?= htmlspecialchars($b['title']) ?>
                        </a>
                        <span class="ticker-sep">◆</span>
                    <?php endforeach; ?>
                </div>
            </div>
        </div>
    <?php endif; ?>

    <!-- ── NAVBAR ────────────────────────────────────────────────────────────── -->
    <nav class="navbar navbar-expand-lg navbar-dark gn-navbar sticky-top">
        <div class="container">
            <a class="navbar-brand d-flex align-items-center gap-2" href="<?= BASE_URL ?>/">
                <img src="<?= BASE_URL ?>/public/images/logo-wolf.png"
                    alt="GameNexus icon"
                    style="height: 46px; width: auto; object-fit: contain;">
                <span style="font-family: 'Exo 2', sans-serif; font-weight: 700; font-size: 1.2rem; letter-spacing: 0.5px;">
                    <span style="color: #ffffff;">Game</span><span style="color: #e63946;">Nexus</span>
                </span>
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navMenu">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navMenu">
                <!-- Category links -->
                <ul class="navbar-nav me-auto">
                    <?php foreach (($categories ?? []) as $cat): ?>
                        <li class="nav-item">
                            <a class="nav-link" href="<?= BASE_URL ?>/category/<?= $cat['slug'] ?>">
                                <?= htmlspecialchars($cat['name']) ?>
                            </a>
                        </li>
                    <?php endforeach; ?>
                </ul>

                <!-- Search -->
                <div class="gn-search-wrap me-3">
                    <form id="searchForm" method="GET" action="<?= BASE_URL ?>/search" class="mb-0">
                        <div class="input-group">
                            <input type="text" id="globalSearch" name="q" class="form-control form-control-sm gn-search-input"
                                placeholder="Search games, reviews…" autocomplete="off">
                            <button class="btn btn-accent btn-sm" id="searchBtn" type="submit">
                                <i class="bi bi-search"></i>
                            </button>
                        </div>
                    </form>
                    <div id="searchDropdown" class="search-dropdown d-none"></div>
                </div>

                <!-- Dark mode toggle -->
                <button class="btn btn-sm btn-outline-secondary me-2" id="darkToggle" title="Toggle theme">
                    <i class="bi bi-moon-fill"></i>
                </button>

                <!-- Auth -->
                <?php if (!empty($_SESSION['user_id'])): ?>
                    <div class="dropdown">
                        <button class="btn btn-sm btn-accent dropdown-toggle" data-bs-toggle="dropdown">
                            <i class="bi bi-person-circle"></i> <?= htmlspecialchars($_SESSION['username'] ?? '') ?>
                        </button>
                        <ul class="dropdown-menu dropdown-menu-dark dropdown-menu-end">
                            <li><a class="dropdown-item" href="<?= BASE_URL ?>/profile">
                                    <i class="bi bi-person-circle"></i> Trang cá nhân</a></li>
                            <li><a class="dropdown-item" href="<?= BASE_URL ?>/profile/history">
                                    <i class="bi bi-clock-history"></i> Lịch sử đọc</a></li>
                            <li><a class="dropdown-item" href="<?= BASE_URL ?>/profile/bookmarks">
                                    <i class="bi bi-bookmark-heart"></i> Bookmarks</a></li>
                            <?php if (($_SESSION['role'] ?? '') === 'admin'): ?>
                                <li><a class="dropdown-item" href="<?= BASE_URL ?>/admin">
                                        <i class="bi bi-speedometer2"></i> Admin Panel</a></li>
                            <?php endif; ?>
                            <li>
                                <hr class="dropdown-divider">
                            </li>
                            <li>
                                <!-- Logout as POST form with CSRF -->
                                <form method="POST" action="<?= BASE_URL ?>/auth/logout" class="d-inline">
                                    <?= Csrf::field() ?>
                                    <button type="submit" class="dropdown-item text-danger">
                                        <i class="bi bi-box-arrow-right"></i> Logout
                                    </button>
                                </form>
                            </li>
                        </ul>
                    </div>
                <?php else: ?>
                    <a href="<?= BASE_URL ?>/auth/login" class="btn btn-sm btn-outline-accent me-1">Login</a>
                    <a href="<?= BASE_URL ?>/auth/register" class="btn btn-sm btn-accent">Register</a>
                <?php endif; ?>
            </div>
        </div>
    </nav>

    <!-- ── MAIN CONTENT ───────────────────────────────────────────────────────── -->
    <main class="gn-main">
        <?= $content ?>
    </main>

    <!-- ── FOOTER ────────────────────────────────────────────────────────────── -->
    <footer class="gn-footer mt-5">
        <!-- Newsletter CTA strip -->
        <div class="gn-footer-cta">
            <div class="container">
                <div class="row align-items-center g-3">
                    <div class="col-md-6">
                        <h6 class="gn-footer-cta-title mb-0"><i class="bi bi-envelope-heart me-2"></i>Đăng ký nhận tin game & review mới nhất</h6>
                    </div>
                    <div class="col-md-6">
                        <form id="footerNewsletterForm" class="d-flex gap-2 flex-wrap">
                            <input type="email" name="email" class="form-control form-control-sm gn-footer-newsletter-input" placeholder="Email của bạn" required>
                            <button type="submit" class="btn btn-accent btn-sm flex-shrink-0">Đăng ký</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div class="container py-5">
            <div class="row g-4 g-lg-5">
                <div class="col-lg-4 col-md-6">
                    <h5 class="gn-footer-brand mb-3">Game<span class="brand-accent">Nexus</span></h5>
                    <p class="gn-footer-desc text-muted small">Nguồn tin game, review và cộng đồng game thủ. Luôn cập nhật nhanh nhất.</p>
                    <div class="gn-footer-social mt-3">
                        <a href="#" class="gn-footer-social-link" title="Facebook"><i class="bi bi-facebook"></i></a>
                        <a href="#" class="gn-footer-social-link" title="Twitter"><i class="bi bi-twitter-x"></i></a>
                        <a href="#" class="gn-footer-social-link" title="YouTube"><i class="bi bi-youtube"></i></a>
                        <a href="#" class="gn-footer-social-link" title="Discord"><i class="bi bi-discord"></i></a>
                    </div>
                </div>
                <div class="col-lg-2 col-md-6">
                    <h6 class="gn-footer-heading">Quick Links</h6>
                    <ul class="gn-footer-links">
                        <li><a href="<?= BASE_URL ?>/">Trang chủ</a></li>
                        <li><a href="<?= BASE_URL ?>/category/reviews">Reviews</a></li>
                        <li><a href="<?= BASE_URL ?>/category/news">News</a></li>
                        <li><a href="<?= BASE_URL ?>/category/guides">Guides</a></li>
                    </ul>
                </div>
                <div class="col-lg-3 col-md-6">
                    <h6 class="gn-footer-heading">Categories</h6>
                    <ul class="gn-footer-links">
                        <?php foreach (($categories ?? []) as $cat): ?>
                            <li><a href="<?= BASE_URL ?>/category/<?= $cat['slug'] ?>"><?= htmlspecialchars($cat['name']) ?></a></li>
                        <?php endforeach; ?>
                    </ul>
                </div>
                <div class="col-lg-3 col-md-6">
                    <h6 class="gn-footer-heading">Quick Contact</h6>
                    <div class="gn-footer-contact-form">
                        <form id="footerContactForm">
                            <div class="mb-2">
                                <label class="form-label">Name</label>
                                <input type="text" class="form-control form-control-sm" name="name" placeholder="Your name" required>
                            </div>
                            <div class="mb-2">
                                <label class="form-label">Email</label>
                                <input type="email" class="form-control form-control-sm" name="email" placeholder="your@email.com" required>
                            </div>
                            <div class="mb-2">
                                <label class="form-label">Message</label>
                                <textarea class="form-control form-control-sm" name="message" rows="2" placeholder="How can we help?" required></textarea>
                            </div>
                            <button type="submit" class="btn btn-accent btn-sm w-100">
                                <i class="bi bi-send me-1"></i>Send Message
                            </button>
                        </form>
                    </div>
                </div>
            </div>
            <hr class="gn-footer-divider mt-4 mb-4">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <p class="gn-footer-copy text-muted small mb-0">© <?= date('Y') ?> GameNexus. All rights reserved.</p>
                </div>
                <div class="col-md-6 text-md-end mt-2 mt-md-0">
                    <div class="d-flex flex-wrap gap-2 justify-content-center justify-content-md-end">
                        <?php foreach (array_slice($popularTags ?? [], 0, 10) as $t): ?>
                            <a href="<?= BASE_URL ?>/tag/<?= $t['slug'] ?>" class="gn-footer-tag">#<?= htmlspecialchars($t['name']) ?></a>
                        <?php endforeach; ?>
                    </div>
                </div>
            </div>
        </div>
    </footer>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- App JS -->
    <script>
        const BASE_URL = '<?= BASE_URL ?>';
        const USER_ID = <?= (int)($_SESSION['user_id'] ?? 0) ?>;
        const CSRF_TOKEN = '<?= Csrf::token() ?>';
    </script>
    <script src="<?= BASE_URL ?>/public/js/app.js"></script>

    <!-- Back to Top button -->
    <button class="gn-back-to-top" id="backToTop" title="Back to top">
        <i class="bi bi-chevron-up"></i>
    </button>
</body>

</html>
