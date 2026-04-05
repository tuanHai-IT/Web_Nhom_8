<?php // app/views/admin/games/upcoming-games.php — List of upcoming games 
?>

<div class="gn-admin-header mb-4">
    <h1 class="mb-1"><?= htmlspecialchars($pageTitle) ?></h1>
    <a href="<?= BASE_URL ?>/admin/upcoming-games/create" class="btn btn-primary btn-sm">
        <i class="bi bi-plus-circle me-1"></i>Add Upcoming Game
    </a>
</div>

<?php if (empty($games)): ?>
    <div class="alert alert-info">No upcoming games found. <a href="<?= BASE_URL ?>/admin/upcoming-games/create">Create one</a></div>
<?php else: ?>
    <div class="table-responsive">
        <table class="table table-hover">
            <thead>
                <tr>
                    <th class="d-none d-md-table-cell">Cover</th>
                    <th>Title</th>
                    <th>Release Date</th>
                    <th class="d-none d-md-table-cell">Platform</th>
                    <th>Status</th>
                    <th class="d-none d-sm-table-cell">Featured</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($games as $game): ?>
                    <tr>
                        <td width="80" class="d-none d-md-table-cell">
                            <?php if (!empty($game['image'])): ?>
                                <img src="<?= BASE_URL . '/' . htmlspecialchars($game['image']) ?>" alt="<?= htmlspecialchars($game['title']) ?>" width="60" height="75" class="rounded" style="object-fit: cover;">
                            <?php else: ?>
                                <span class="badge bg-secondary">No image</span>
                            <?php endif; ?>
                        </td>
                        <td>
                            <strong><?= htmlspecialchars($game['title']) ?></strong>
                            <br>
                            <small class="text-muted"><?= htmlspecialchars($game['slug']) ?></small>
                        </td>
                        <td><?= date('M d, Y', strtotime($game['release_date'])) ?></td>
                        <td class="d-none d-md-table-cell"><small><?= htmlspecialchars($game['platform']) ?></small></td>
                        <td>
                            <span class="badge bg-<?= $game['status'] === 'upcoming' ? 'info' : ($game['status'] === 'delayed' ? 'warning' : 'danger') ?>">
                                <?= ucfirst($game['status']) ?>
                            </span>
                        </td>
                        <td class="d-none d-sm-table-cell">
                            <?= $game['is_featured'] ? '<i class="bi bi-star-fill text-warning"></i>' : '' ?>
                        </td>
                        <td width="120">
                            <a href="<?= BASE_URL ?>/admin/upcoming-games/<?= $game['id'] ?>/edit" class="btn btn-sm btn-outline-primary" title="Edit">
                                <i class="bi bi-pencil"></i>
                            </a>
                            <button class="btn btn-sm btn-outline-danger" onclick="deleteGame('upcoming', <?= $game['id'] ?>)" title="Delete">
                                <i class="bi bi-trash"></i>
                            </button>
                        </td>
                    </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    </div>

    <!-- Pagination -->
    <?php if ($totalPages > 1): ?>
        <nav class="d-flex justify-content-center mt-4">
            <ul class="pagination">
                <?php for ($i = 1; $i <= $totalPages; $i++): ?>
                    <li class="page-item <?= $i === $currentPage ? 'active' : '' ?>">
                        <a class="page-link" href="<?= BASE_URL ?>/admin/upcoming-games?page=<?= $i ?>"><?= $i ?></a>
                    </li>
                <?php endfor; ?>
            </ul>
        </nav>
    <?php endif; ?>
<?php endif; ?>

<script>
    function deleteGame(type, id) {
        if (!confirm('Are you sure you want to delete this game?')) return;

        const url = type === 'upcoming' ?
            `<?= BASE_URL ?>/admin/upcoming-games/${id}/delete` :
            `<?= BASE_URL ?>/admin/trending-games/${id}/delete`;

        fetch(url, {
                method: 'POST',
                headers: {
                    'X-Requested-With': 'XMLHttpRequest',
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'csrf_token=' + encodeURIComponent(CSRF_TOKEN)
            })
            .then(r => r.json())
            .then(data => {
                if (data.success) {
                    location.reload();
                } else {
                    alert('Error: ' + (data.message || 'Failed to delete'));
                }
            })
            .catch(() => alert('Request failed'));
    }
</script>
