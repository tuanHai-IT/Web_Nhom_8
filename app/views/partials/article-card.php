<?php // app/views/partials/article-card.php — Reusable article card ?>
<?php // Expects $a (article array) to be set before including ?>
<div class="gn-card h-100">
    <a href="<?= BASE_URL ?>/article/<?= $a['slug'] ?>">
        <img src="<?= $a['thumbnail'] ?? BASE_URL . '/public/images/placeholder.jpg' ?>"
             class="gn-card-img" alt="<?= htmlspecialchars($a['title']) ?>" loading="lazy">
    </a>
    <div class="gn-card-body">
        <?php if (!empty($a['category_slug'])): ?>
        <a href="<?= BASE_URL ?>/category/<?= $a['category_slug'] ?>" class="card-cat-badge">
            <?= htmlspecialchars($a['category_name']) ?>
        </a>
        <?php endif; ?>
        <div class="gn-card-title">
            <a href="<?= BASE_URL ?>/article/<?= $a['slug'] ?>"><?= htmlspecialchars($a['title']) ?></a>
        </div>
        <div class="gn-card-meta">
            <?php if (!empty($a['author_name'])): ?>
            <i class="bi bi-person me-1"></i><?= htmlspecialchars($a['author_name']) ?>
            <span class="mx-2">·</span>
            <?php endif; ?>
            <i class="bi bi-eye me-1"></i><?= number_format($a['view_count'] ?? 0) ?>
            <span class="mx-2">·</span>
            <span class="gn-read-time"><i class="bi bi-clock"></i> 5 min</span>
        </div>
    </div>
</div>
