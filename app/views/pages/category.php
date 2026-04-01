<?php // app/views/pages/category.php ?>
<div class="container">
    <div class="row">
        <div class="col-12 mb-4">
            <div class="d-flex align-items-center gap-3">
                <span class="display-6" style="color:<?= htmlspecialchars($category['color'] ?? '#e63946') ?>">■</span>
                <div>
                    <h1 class="fw-bold mb-0" style="font-family:var(--font-display)">
                        <?= htmlspecialchars($category['name']) ?>
                    </h1>
                    <p class="text-muted mb-0 small"><?= htmlspecialchars($category['description'] ?? '') ?></p>
                </div>
            </div>
            <hr class="border-secondary">
        </div>
    </div>

    <div class="row g-4" id="articleGrid">
        <?php foreach ($articles as $a): ?>
        <div class="col-md-6 col-lg-4">
            <div class="gn-card h-100">
                <a href="<?= BASE_URL ?>/article/<?= $a['slug'] ?>">
                    <img src="<?= $a['thumbnail'] ?? BASE_URL . '/public/images/placeholder.jpg' ?>"
                         class="gn-card-img" alt="<?= htmlspecialchars($a['title']) ?>" loading="lazy">
                </a>
                <div class="gn-card-body">
                    <div class="gn-card-title">
                        <a href="<?= BASE_URL ?>/article/<?= $a['slug'] ?>"><?= htmlspecialchars($a['title']) ?></a>
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
        <?php if (empty($articles)): ?>
        <div class="col-12 text-center text-muted py-5">No articles in this category yet.</div>
        <?php endif; ?>
    </div>

    <!-- Pagination -->
    <?php if ($totalPages > 1): ?>
    <nav class="mt-5 d-flex justify-content-center">
        <ul class="pagination">
            <?php for ($p = 1; $p <= $totalPages; $p++): ?>
            <li class="page-item <?= $p === $currentPage ? 'active' : '' ?>">
                <a class="page-link" href="?page=<?= $p ?>"><?= $p ?></a>
            </li>
            <?php endfor; ?>
        </ul>
    </nav>
    <?php endif; ?>
</div>
