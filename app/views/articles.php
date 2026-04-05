<?php // app/views/admin/articles.php ?>
<div class="d-flex justify-content-between align-items-center mb-4">
    <h5 class="mb-0" style="font-family:var(--font-display)">All Articles</h5>
    <a href="<?= BASE_URL ?>/admin/articles/create" class="btn btn-accent btn-sm">
        <i class="bi bi-plus-lg me-1"></i>New Article
    </a>
</div>

<div class="admin-table">
    <table class="table table-dark table-hover">
        <thead>
            <tr>
                <th>#</th>
                <th class="d-none d-md-table-cell">Thumbnail</th>
                <th>Title</th>
                <th>Category</th>
                <th class="d-none d-md-table-cell">Author</th>
                <th>Status</th>
                <th class="d-none d-sm-table-cell">Views</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($articles as $a): ?>
            <tr>
                <td class="text-muted"><?= $a['article_id'] ?></td>
                <td class="d-none d-md-table-cell">
                    <img src="<?= $a['thumbnail'] ?? BASE_URL . '/public/images/placeholder.jpg' ?>"
                         style="width:56px;height:38px;object-fit:cover;border-radius:4px">
                </td>
                <td><?= htmlspecialchars(mb_strimwidth($a['title'], 0, 50, '…')) ?></td>
                <td><?= htmlspecialchars($a['category_name']) ?></td>
                <td class="d-none d-md-table-cell"><?= htmlspecialchars($a['author_name']) ?></td>
                <td>
                    <span class="badge badge-<?= $a['status'] ?>">
                        <?= ucfirst($a['status']) ?>
                    </span>
                    <?= $a['is_featured'] ? '<span class="badge bg-warning text-dark ms-1">F</span>' : '' ?>
                    <?= $a['is_breaking'] ? '<span class="badge bg-danger ms-1">B</span>' : '' ?>
                </td>
                <td class="d-none d-sm-table-cell"><?= number_format($a['view_count']) ?></td>
                <td>
                    <a href="<?= BASE_URL ?>/admin/articles/edit/<?= $a['article_id'] ?>"
                       class="btn btn-sm btn-outline-secondary me-1">
                        <i class="bi bi-pencil"></i>
                    </a>
                    <button class="btn btn-sm btn-outline-danger"
                            onclick="deleteArticle(<?= $a['article_id'] ?>)">
                        <i class="bi bi-trash"></i>
                    </button>
                </td>
            </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
</div>

<!-- Pagination -->
<?php include BASE_PATH . '/app/views/partials/pagination.php'; ?>
