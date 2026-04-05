<?php // app/views/admin/comments.php ?>
<h5 class="mb-4" style="font-family:var(--font-display)">Manage Comments</h5>

<div class="admin-table">
    <table class="table table-dark table-hover">
        <thead>
            <tr>
                <th>#</th>
                <th>User</th>
                <th>Article</th>
                <th>Comment</th>
                <th>Status</th>
                <th>Date</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($comments as $c): ?>
            <tr id="comment-row-<?= $c['comment_id'] ?>">
                <td class="text-muted"><?= $c['comment_id'] ?></td>
                <td><?= htmlspecialchars($c['username']) ?></td>
                <td>
                    <a href="<?= BASE_URL ?>/article/<?= $c['article_slug'] ?>" target="_blank"
                       class="text-accent small">
                        <?= htmlspecialchars(mb_strimwidth($c['article_title'], 0, 35, '…')) ?>
                    </a>
                </td>
                <td class="small"><?= htmlspecialchars(mb_strimwidth($c['content'], 0, 80, '…')) ?></td>
                <td>
                    <span class="badge <?= !empty($c['is_approved']) ? 'bg-success' : 'bg-warning text-dark' ?>">
                        <?= !empty($c['is_approved']) ? 'Approved' : 'Pending' ?>
                    </span>
                </td>
                <td class="text-muted small"><?= date('M d, Y', strtotime($c['created_at'])) ?></td>
                <td>
                    <?php if (empty($c['is_approved'])): ?>
                    <button class="btn btn-sm btn-outline-success me-1"
                            onclick="approveComment(<?= $c['comment_id'] ?>)">
                        <i class="bi bi-check-lg"></i>
                    </button>
                    <?php endif; ?>
                    <button class="btn btn-sm btn-outline-danger"
                            onclick="deleteComment(<?= $c['comment_id'] ?>)">
                        <i class="bi bi-trash"></i>
                    </button>
                </td>
            </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
</div>

<?php include BASE_PATH . '/app/views/partials/pagination.php'; ?>
