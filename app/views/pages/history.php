<?php // app/views/pages/history.php 
?>
<div class="container py-4">

    <h1 class="section-heading mb-4">
        <i class="bi bi-clock-history"></i> Lịch sử đọc
        <span class="text-muted fs-6 fw-normal ms-2"><?= count($history) ?> bài</span>
    </h1>

    <?php if (empty($history)): ?>
        <div class="text-center py-5 text-muted">
            <i class="bi bi-clock display-3 d-block mb-3 opacity-25"></i>
            <p>Bạn chưa đọc bài viết nào.</p>
            <a href="<?= BASE_URL ?>/" class="btn btn-accent">Khám phá bài viết</a>
        </div>
    <?php else: ?>

        <!-- Group theo ngày -->
        <?php
        $grouped = [];
        foreach ($history as $item) {
            $day = date('d/m/Y', strtotime($item['read_at']));
            $grouped[$day][] = $item;
        }
        ?>

        <?php foreach ($grouped as $date => $items): ?>
            <div class="mb-4">
                <div class="d-flex align-items-center gap-2 mb-3">
                    <i class="bi bi-calendar3 text-accent"></i>
                    <span class="small fw-semibold text-muted"><?= $date === date('d/m/Y') ? 'Hôm nay' : $date ?></span>
                    <hr class="flex-grow-1 border-secondary my-0">
                </div>

                <div class="row g-3">
                    <?php foreach ($items as $a): ?>
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
                                        <a href="<?= BASE_URL ?>/article/<?= $a['slug'] ?>">
                                            <?= htmlspecialchars($a['title']) ?>
                                        </a>
                                    </div>
                                    <div class="gn-card-meta">
                                        <i class="bi bi-clock me-1"></i>
                                        <?= date('H:i', strtotime($a['read_at'])) ?>
                                        <span class="mx-2">·</span>
                                        <i class="bi bi-eye me-1"></i><?= number_format($a['view_count']) ?>
                                    </div>
                                </div>
                            </div>
                        </div>
                    <?php endforeach; ?>
                </div>
            </div>
        <?php endforeach; ?>

    <?php endif; ?>
</div>