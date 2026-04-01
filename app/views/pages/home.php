<?php // app/views/pages/home.php 
?>
<div class="container">

    <!-- Swiper CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css">



    <!-- ── FEATURED HERO ──────────────────────────────────────────────── -->
    <?php if (!empty($featured)): ?>
        <div class="row g-3 hero-row">
            <div class="col-lg-8 hero-col-left">
                <div class="hero-slider swiper">
                    <div class="swiper-wrapper">

                        <?php foreach ($featured as $article): ?>
                            <div class="swiper-slide hero-slide">

                                <img src="<?= !empty($article['thumbnail']) ? htmlspecialchars($article['thumbnail']) : BASE_URL . '/public/images/placeholder.jpg' ?>" class="hero-image" alt="<?= htmlspecialchars($article['title']) ?>">

                                <div class="hero-overlay">
                                    <span class="hero-category">
                                        <?= htmlspecialchars($article['category_name']) ?>
                                    </span>

                                    <h2 class="hero-title">
                                        <?= htmlspecialchars($article['title']) ?>
                                    </h2>

                                    <p class="hero-excerpt">
                                        <?= htmlspecialchars($article['excerpt'] ?? $article['summary'] ?? '') ?>
                                    </p>

                                    <a href="<?= BASE_URL ?>/article/<?= htmlspecialchars($article['slug']) ?>" class="hero-readmore">
                                        Đọc tiếp &rarr;
                                    </a>
                                </div>

                                <div class="hero-progress"></div>

                            </div>
                        <?php endforeach; ?>

                    </div>

                    <div class="swiper-button-prev"></div>
                    <div class="swiper-button-next"></div>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="hero-sidebar">
                    <?php foreach (array_slice($mostViewed, 0, 4) as $f): ?>
                        <a href="<?= BASE_URL ?>/article/<?= htmlspecialchars($f['slug']) ?>" class="hero-sidebar-post">
                            <div class="post-thumb">
                                <?php
                                $cardThumb = !empty($f['thumbnail']) ? $f['thumbnail'] : null;
                                if ($cardThumb && !str_starts_with($cardThumb, 'http')) {
                                    $cardThumb = BASE_URL . '/' . ltrim($cardThumb, '/');
                                }
                                $cardThumb = $cardThumb ?? (BASE_URL . '/public/images/placeholder.jpg');
                                ?>
                                <img src="<?= htmlspecialchars($cardThumb) ?>"
                                    alt="<?= htmlspecialchars($f['title']) ?>"
                                    onerror="this.src='<?= BASE_URL ?>/public/images/placeholder.jpg'">
                            </div>

                            <div class="post-info">
                                <span class="post-category"><?= htmlspecialchars($f['category_name']) ?></span>
                                <h4 class="post-title"><?= htmlspecialchars($f['title']) ?></h4>
                                <span class="gn-card-meta">
                                    <i class="bi bi-eye me-1"></i><?= number_format($f['view_count']) ?> views
                                </span>
                            </div>
                        </a>
                    <?php endforeach; ?>
                </div>
            </div>
        </div>

        <!-- Swiper JS -->
        <script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                const slideCount = <?= count($featured) ?>;
                const heroSwiper = new Swiper('.hero-slider', {
                    loop: slideCount > 1,
                    effect: 'fade',
                    fadeEffect: { crossFade: true },
                    autoplay: slideCount > 1 ? {
                        delay: 6000,
                        disableOnInteraction: false
                    } : false,
                    navigation: {
                        nextEl: '.swiper-button-next',
                        prevEl: '.swiper-button-prev'
                    },
                    on: {
                        slideChangeTransitionStart: function() {
                            document.querySelectorAll('.hero-progress').forEach(el => {
                                el.style.animation = 'none';
                                el.offsetHeight; /* trigger reflow */
                                el.style.animation = null;
                            });
                        }
                    }
                });
            });
        </script>
    <?php endif; ?>

    <!-- ── MAIN GRID + SIDEBAR ───────────────────────────────────────── -->
    <div class="row g-4 mt-4">
        <!-- Latest Articles -->
        <div class="col-lg-8">
            <h2 class="section-heading"><i class="bi bi-fire"></i> Latest News</h2>

            <div class="row g-4" id="articleGrid">
                <?php foreach ($latest as $a): ?>
                    <div class="col-md-6 mb-2">
                        <div class="gn-card h-100">
                            <a href="<?= BASE_URL ?>/article/<?= htmlspecialchars($a['slug']) ?>">
                                <img src="<?= !empty($a['thumbnail']) ? htmlspecialchars($a['thumbnail']) : BASE_URL . '/public/images/placeholder.jpg' ?>"
                                    class="gn-card-img" alt="<?= htmlspecialchars($a['title']) ?>" loading="lazy">
                            </a>
                            <div class="gn-card-body">
                                <a href="<?= BASE_URL ?>/category/<?= $a['category_slug'] ?>" class="card-cat-badge">
                                    <?= htmlspecialchars($a['category_name']) ?>
                                </a>
                                <div class="gn-card-title">
                                    <a href="<?= BASE_URL ?>/article/<?= $a['slug'] ?>">
                                        <?= htmlspecialchars($a['title']) ?>
                                    </a>
                                </div>
                                <div class="gn-card-meta">
                                    <i class="bi bi-person me-1"></i><?= htmlspecialchars($a['author_name']) ?>
                                    <span class="mx-2">·</span>
                                    <i class="bi bi-eye me-1"></i><?= number_format($a['view_count']) ?>
                                </div>
                            </div>
                        </div>
                    </div>
                <?php endforeach; ?>
            </div>

            <!-- Load More -->
            <div class="text-center mt-4">
                <button id="loadMoreBtn" class="btn btn-outline-accent" data-category-id="0">
                    Load More <i class="bi bi-arrow-down-circle ms-1"></i>
                </button>
            </div>
        </div>

        <!-- Sidebar -->
        <?php include BASE_PATH . '/app/views/partials/sidebar.php'; ?>
    </div>
</div>