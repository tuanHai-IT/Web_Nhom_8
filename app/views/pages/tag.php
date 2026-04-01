<?php // app/views/pages/tag.php ?>
<div class="container">
    <h1 class="section-heading mb-4">
        <i class="bi bi-hash"></i> <?= htmlspecialchars($tag['name']) ?>
        <span class="text-muted fs-6 fw-normal"><?= $total ?> articles</span>
    </h1>
    <div class="row g-4">
        <?php foreach ($articles as $a): ?>
        <div class="col-md-6 col-lg-4">
            <div class="gn-card h-100">
                <a href="<?= BASE_URL ?>/article/<?= $a['slug'] ?>">
                    <img src="<?= $a['thumbnail'] ?? BASE_URL . '/public/images/placeholder.jpg' ?>"
                         class="gn-card-img" alt="" loading="lazy">
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
        <?php if (empty($articles)): ?>
        <p class="text-muted text-center py-5">No articles for this tag.</p>
        <?php endif; ?>
    </div>

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
