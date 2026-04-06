<?php // app/views/pages/bookmarks.php ?>
<div class="container">
    <h1 class="section-heading mb-4"><i class="bi bi-bookmark-heart"></i> My Bookmarks</h1>

    <?php if (empty($bookmarks)): ?>
    <div class="text-center py-5 text-muted">
        <i class="bi bi-bookmark-x display-3 d-block mb-3"></i>
        <p>You haven't bookmarked any articles yet.</p>
        <a href="<?= BASE_URL ?>/" class="btn btn-accent">Browse Articles</a>
    </div>
    <?php else: ?>
    <div class="row g-4">
        <?php foreach ($bookmarks as $a): ?>
        <div class="col-md-6 col-lg-4">
            <div class="gn-card h-100">
                <a href="<?= BASE_URL ?>/article/<?= $a['slug'] ?>">
                    <img src="<?= $a['thumbnail'] ?? BASE_URL . '/public/images/placeholder.jpg' ?>"
                         class="gn-card-img" alt="<?= htmlspecialchars($a['title']) ?>" loading="lazy">
                </a>
                <div class="gn-card-body">
                    <a href="<?= BASE_URL ?>/category/<?= $a['category_slug'] ?>" class="card-cat-badge">
                        <?= htmlspecialchars($a['category_name']) ?>
                    </a>
                    <div class="gn-card-title">
                        <a href="<?= BASE_URL ?>/article/<?= $a['slug'] ?>"><?= htmlspecialchars($a['title']) ?></a>
                    </div>
                </div>
            </div>
        </div>
        <?php endforeach; ?>
    </div>
    <?php endif; ?>
</div>
