<?php // app/views/partials/pagination.php — Reusable pagination widget ?>
<?php if (isset($totalPages) && $totalPages > 1): ?>
<nav class="mt-5 d-flex justify-content-center">
    <ul class="pagination">
        <?php if ($currentPage > 1): ?>
        <li class="page-item">
            <a class="page-link" href="?page=<?= $currentPage - 1 ?>">‹</a>
        </li>
        <?php endif; ?>

        <?php for ($p = 1; $p <= $totalPages; $p++): ?>
        <li class="page-item <?= $p === $currentPage ? 'active' : '' ?>">
            <a class="page-link" href="?page=<?= $p ?>"><?= $p ?></a>
        </li>
        <?php endfor; ?>

        <?php if ($currentPage < $totalPages): ?>
        <li class="page-item">
            <a class="page-link" href="?page=<?= $currentPage + 1 ?>">›</a>
        </li>
        <?php endif; ?>
    </ul>
</nav>
<?php endif; ?>
