<?php // app/views/partials/sidebar.php — Reusable sidebar widget 
?>
<div class="col-lg-4">

    <?php if (!empty($breaking)): ?>
        <!-- Breaking News -->
        <div class="gn-sidebar-widget">
            <div class="widget-title"><i class="bi bi-lightning-fill me-1"></i>Breaking News</div>
            <?php foreach (array_slice($breaking, 0, 5) as $b): ?>
                <a class="sidebar-list-item" href="<?= BASE_URL ?>/article/<?= $b['slug'] ?>">
                    <div>
                        <div class="item-title"><?= htmlspecialchars($b['title']) ?></div>
                        <div class="item-meta"><?= htmlspecialchars($b['category_name']) ?></div>
                    </div>
                </a>
            <?php endforeach; ?>
        </div>
    <?php endif; ?>

    <!-- Trending Games Widget -->
    <?php if (!empty($trendingGames)): ?>
        <div class="gn-sidebar-widget">
            <div class="widget-title"><i class="bi bi-fire me-1"></i>Trending Games</div>
            <div class="trending-games-list">
                <?php foreach ($trendingGames as $index => $game): ?>
                    <a href="<?= BASE_URL ?>/tag/<?= htmlspecialchars($game['slug']) ?>" class="trending-game-item">
                        <div class="game-rank"><?= $index + 1 ?></div>
                        <div class="game-info">
                            <div class="game-name"><?= htmlspecialchars($game['name']) ?></div>
                            <div class="game-count"><?= $game['article_count'] ?> articles</div>
                        </div>
                        <i class="bi bi-arrow-right"></i>
                    </a>
                <?php endforeach; ?>
            </div>
        </div>
    <?php endif; ?>

    <!-- Upcoming Games Widget -->
    <?php if (!empty($upcomingGames)): ?>
        <div class="gn-sidebar-widget">
            <div class="widget-title"><i class="bi bi-controller me-1"></i>Upcoming Games</div>
            <div class="upcoming-games-list">
                <?php foreach ($upcomingGames as $game): ?>
                    <a href="<?= BASE_URL ?>/upcoming-game/<?= htmlspecialchars($game['slug']) ?>" class="upcoming-game-item">
                        <div class="game-thumbnail">
                            <?php
                            // Use 'image' field if available, fallback to 'thumbnail' for backward compatibility
                            $imagePath = !empty($game['image']) ? $game['image'] : ($game['thumbnail'] ?? null);

                            if (!empty($imagePath)) {
                                // Remove leading slash if any, then add BASE_URL
                                $imagePath = ltrim($imagePath, '/');
                                $imageUrl = BASE_URL . '/' . $imagePath;
                            } else {
                                // No image exists, use default
                                $imageUrl = BASE_URL . '/public/images/default-game.jpg';
                            }
                            ?>
                            <img src="<?= htmlspecialchars($imageUrl) ?>" alt="<?= htmlspecialchars($game['title']) ?>" loading="lazy">
                            <div class="release-badge">
                                <?php
                                $releaseDate = new DateTime($game['release_date']);
                                $today = new DateTime();
                                $interval = $today->diff($releaseDate);

                                if ($interval->invert) {
                                    echo 'Released';
                                } else {
                                    echo $interval->days . 'd';
                                }
                                ?>
                            </div>
                        </div>
                        <div class="game-meta">
                            <div class="game-title"><?= htmlspecialchars($game['title']) ?></div>
                            <div class="game-platform"><?= htmlspecialchars($game['platform']) ?></div>
                            <div class="game-date"><?= date('M d, Y', strtotime($game['release_date'])) ?></div>
                        </div>
                    </a>
                <?php endforeach; ?>
            </div>
        </div>
    <?php endif; ?>

    <!-- Popular Tags -->
    <?php if (!empty($popularTags)): ?>
        <div class="gn-sidebar-widget">
            <div class="widget-title"><i class="bi bi-tags me-1"></i>Trending Tags</div>
            <div class="tag-cloud">
                <?php foreach ($popularTags as $t): ?>
                    <a href="<?= BASE_URL ?>/tag/<?= $t['slug'] ?>" class="tag-pill">
                        #<?= htmlspecialchars($t['name']) ?>
                    </a>
                <?php endforeach; ?>
            </div>
        </div>
    <?php endif; ?>

    <!-- Categories -->
    <?php if (!empty($categories)): ?>
        <div class="gn-sidebar-widget gn-reveal">
            <div class="widget-title"><i class="bi bi-grid me-1"></i>Categories</div>
            <nav class="gn-sidebar-nav">
                <?php foreach ($categories as $cat): ?>
                    <a href="<?= BASE_URL ?>/category/<?= $cat['slug'] ?>" class="gn-sidebar-nav-item">
                        <span class="gn-sidebar-nav-dot" style="background:<?= htmlspecialchars($cat['color'] ?? '#e63946') ?>"></span>
                        <span><?= htmlspecialchars($cat['name']) ?></span>
                        <i class="bi bi-chevron-right gn-sidebar-nav-arrow"></i>
                    </a>
                <?php endforeach; ?>
            </nav>
        </div>
    <?php endif; ?>

</div>