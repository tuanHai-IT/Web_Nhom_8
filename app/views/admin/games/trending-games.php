<?php // app/views/admin/games/trending-games.php — List of trending games 
?>

<div class="gn-admin-header mb-4">
    <h1 class="mb-1"><?= htmlspecialchars($pageTitle) ?></h1>
    <a href="<?= BASE_URL ?>/admin/trending-games/create" class="btn btn-primary btn-sm">
        <i class="bi bi-plus-circle me-1"></i>Add Trending Game
    </a>
</div>

<?php if (empty($games)): ?>
    <div class="alert alert-info">No trending games found. <a href="<?= BASE_URL ?>/admin/trending-games/create">Create one</a></div>
<?php else: ?>
    <div class="table-responsive">
        <table class="table table-hover">
            <thead>
                <tr>
                    <th class="d-none d-md-table-cell">Thumbnail</th>
                    <th>Game Name</th>
                    <th class="d-none d-md-table-cell">Slug</th>
                    <th>Rank</th>
                    <th class="d-none d-sm-table-cell">Articles</th>
                    <th>Active</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($games as $game): ?>
                    <tr>
                        <td width="70" class="d-none d-md-table-cell">
                            <?php if (!empty($game['thumbnail'])): ?>
                                <img src="<?= htmlspecialchars($game['thumbnail']) ?>" alt="<?= htmlspecialchars($game['name']) ?>" width="60" height="60" class="rounded" style="object-fit: cover;">
                            <?php else: ?>
                                <span class="badge bg-secondary">No image</span>
                            <?php endif; ?>
                        </td>
                        <td>
                            <strong><?= htmlspecialchars($game['name']) ?></strong>
                        </td>
                        <td class="d-none d-md-table-cell">
                            <code><?= htmlspecialchars($game['slug']) ?></code>
                        </td>
                        <td>
                            <?= $game['featured_rank'] ?? '—' ?>
                        </td>
                        <td class="d-none d-sm-table-cell">
                            <span class="badge bg-info"><?= $game['article_count'] ?></span>
                        </td>
                        <td>
                            <?= $game['is_Active'] ? '<i class="bi bi-check-circle text-success"></i>' : '<i class="bi bi-x-circle text-danger"></i>' ?>
                        </td>
                        <td width="120">
                            <a href="<?= BASE_URL ?>/admin/trending-games/<?= $game['id'] ?>/edit" class="btn btn-sm btn-outline-primary" title="Edit">
                                <i class="bi bi-pencil"></i>
                            </a>
                            <button class="btn btn-sm btn-outline-danger" onclick="deleteGame('trending', <?= $game['id'] ?>)" title="Delete">
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
                        <a class="page-link" href="<?= BASE_URL ?>/admin/trending-games?page=<?= $i ?>"><?= $i ?></a>
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
