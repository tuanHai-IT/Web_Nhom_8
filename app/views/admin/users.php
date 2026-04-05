<?php // app/views/admin/users.php 
?>
<h5 class="mb-4" style="font-family:var(--font-display)">Manage Users</h5>

<div class="admin-table table-responsive">
    <table class="table table-dark table-hover">
        <thead>
            <tr>
                <th>#</th>
                <th>Username</th>
                <th class="d-none d-md-table-cell">Email</th>
                <th>Role</th>
                <th class="d-none d-sm-table-cell">Joined</th>
                <th>Change Role</th>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($users as $u): ?>
                <tr>
                    <td class="text-muted"><?= $u['user_id'] ?></td>
                    <td class="fw-semibold"><?= htmlspecialchars($u['username']) ?></td>
                    <td class="text-muted d-none d-md-table-cell"><?= htmlspecialchars($u['email']) ?></td>
                    <td>
                        <span class="badge <?= $u['role_name'] === 'admin' ? 'bg-danger' : 'bg-secondary' ?>">
                            <?= htmlspecialchars($u['role_name'] ?? 'user') ?>
                        </span>
                    </td>
                    <td class="text-muted small d-none d-sm-table-cell">
                        <?= date('M d, Y', strtotime($u['created_at'])) ?>
                    </td>
                    <td>
                        <select class="form-select form-select-sm bg-dark text-white border-secondary"
                            style="width:120px"
                            onchange="updateRole(<?= $u['user_id'] ?>, this.value)">
                            <?php foreach ($roles as $r): ?>
                                <option value="<?= $r['role_id'] ?>"
                                    <?= $r['role_id'] == ($u['role_id'] ?? 2) ? 'selected' : '' ?>>
                                    <?= htmlspecialchars($r['role_name']) ?>
                                </option>
                            <?php endforeach; ?>
                        </select>
                    </td>
                </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
</div>

<?php include BASE_PATH . '/app/views/partials/pagination.php'; ?>
