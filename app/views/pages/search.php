<?php // app/views/pages/search.php ?>
<div class="container py-4">
    <!-- Search Header -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="d-flex align-items-center gap-3 mb-3">
                <span class="display-6 text-accent"><i class="bi bi-search"></i></span>
                <div>
                    <?php if (!empty($q)): ?>
                    <h1 class="fw-bold mb-0" style="font-family:var(--font-display); font-size:1.6rem;">
                        Kết quả tìm kiếm cho: "<span class="text-accent"><?= htmlspecialchars($q) ?></span>"
                    </h1>
                    <p class="text-muted mb-0 small mt-1">
                        <?php if ($total > 0): ?>
                            Tìm thấy <strong><?= $total ?></strong> bài viết
                        <?php else: ?>
                            Không tìm thấy kết quả nào
                        <?php endif; ?>
                    </p>
                    <?php else: ?>
                    <h1 class="fw-bold mb-0" style="font-family:var(--font-display); font-size:1.6rem;">
                        Tìm kiếm bài viết
                    </h1>
                    <p class="text-muted mb-0 small mt-1">Nhập từ khóa để tìm kiếm bài viết trên GameNexus</p>
                    <?php endif; ?>
                </div>
            </div>

            <!-- Inline search form -->
            <form method="GET" action="<?= BASE_URL ?>/search" class="mb-3" style="max-width:500px;">
                <div class="input-group">
                    <input type="text" name="q" class="form-control gn-search-input"
                           placeholder="Nhập từ khóa tìm kiếm…" autocomplete="off"
                           value="<?= htmlspecialchars($q ?? '') ?>">
                    <button class="btn btn-accent" type="submit">
                        <i class="bi bi-search"></i> Tìm kiếm
                    </button>
                </div>
            </form>
            <hr class="border-secondary">
        </div>
    </div>

    <!-- Results Grid -->
    <?php if (!empty($articles)): ?>
    <div class="row g-4" id="searchResultsGrid">
        <?php foreach ($articles as $a): ?>
        <div class="col-md-6 col-lg-4">
            <?php include BASE_PATH . '/app/views/partials/article-card.php'; ?>
        </div>
        <?php endforeach; ?>
    </div>

    <!-- Pagination -->
    <?php if ($totalPages > 1): ?>
    <nav class="mt-5 d-flex justify-content-center">
        <ul class="pagination">
            <?php if ($currentPage > 1): ?>
            <li class="page-item">
                <a class="page-link" href="?q=<?= urlencode($q) ?>&page=<?= $currentPage - 1 ?>">‹</a>
            </li>
            <?php endif; ?>

            <?php for ($p = 1; $p <= $totalPages; $p++): ?>
            <li class="page-item <?= $p === $currentPage ? 'active' : '' ?>">
                <a class="page-link" href="?q=<?= urlencode($q) ?>&page=<?= $p ?>"><?= $p ?></a>
            </li>
            <?php endfor; ?>

            <?php if ($currentPage < $totalPages): ?>
            <li class="page-item">
                <a class="page-link" href="?q=<?= urlencode($q) ?>&page=<?= $currentPage + 1 ?>">›</a>
            </li>
            <?php endif; ?>
        </ul>
    </nav>
    <?php endif; ?>

    <?php elseif (!empty($q)): ?>
    <!-- No results -->
    <div class="text-center py-5">
        <div class="mb-3" style="font-size:3rem; opacity:.4;"><i class="bi bi-emoji-frown"></i></div>
        <p class="text-muted fs-5">Không tìm thấy bài viết phù hợp với từ khóa.</p>
        <a href="<?= BASE_URL ?>/" class="btn btn-outline-accent mt-2">
            <i class="bi bi-house me-1"></i>Về trang chủ
        </a>
    </div>
    <?php else: ?>
    <!-- No query entered -->
    <div class="text-center py-5">
        <div class="mb-3" style="font-size:3rem; opacity:.4;"><i class="bi bi-search"></i></div>
        <p class="text-muted fs-5">Hãy nhập từ khóa để bắt đầu tìm kiếm.</p>
    </div>
    <?php endif; ?>
</div>
