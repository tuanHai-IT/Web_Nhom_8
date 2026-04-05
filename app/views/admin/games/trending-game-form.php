<?php // app/views/admin/games/trending-game-form.php — Create/Edit trending game form 
?>

<div class="gn-admin-header mb-4">
    <h1 class="mb-1"><?= htmlspecialchars($pageTitle) ?></h1>
    <a href="<?= BASE_URL ?>/admin/trending-games" class="btn btn-secondary btn-sm">
        <i class="bi bi-arrow-left me-1"></i>Back
    </a>
</div>

<form method="POST" enctype="multipart/form-data" class="form-admin max-width-800">
    <?= $csrfField ?>

    <div class="mb-3">
        <label for="name" class="form-label">Game Name *</label>
        <input type="text" class="form-control" id="name" name="name"
            value="<?= htmlspecialchars($game['name'] ?? '') ?>" required>
    </div>

    <div class="row mb-3">
        <div class="col-md-6">
            <label for="slug" class="form-label">Slug</label>
            <input type="text" class="form-control" id="slug" name="slug"
                value="<?= htmlspecialchars($game['slug'] ?? '') ?>"
                placeholder="auto-generated">
            <small class="text-muted">Auto-generated from name if empty</small>
        </div>
        <div class="col-md-6">
            <label for="featured_rank" class="form-label">Featured Rank</label>
            <input type="number" class="form-control" id="featured_rank" name="featured_rank"
                value="<?= htmlspecialchars($game['featured_rank'] ?? '999') ?>"
                min="0" placeholder="0 = highest priority">
            <small class="text-muted">Lower number = higher priority</small>
        </div>
    </div>

    <div class="row mb-3">
        <div class="col-md-6">
            <label for="article_count" class="form-label">Article Count</label>
            <input type="number" class="form-control" id="article_count" name="article_count"
                value="<?= htmlspecialchars($game['article_count'] ?? '0') ?>" min="0">
            <small class="text-muted">Number of related articles</small>
        </div>
    </div>

    <!-- Image Upload -->
    <div class="mb-3">
        <label for="thumbnail" class="form-label">Game Thumbnail</label>
        <div class="mb-2">
            <?php if (!empty($game['thumbnail'])): ?>
                <div class="mb-2">
                    <img src="<?= htmlspecialchars($game['thumbnail']) ?>" alt="Current" width="100" height="100" class="rounded" style="object-fit: cover;">
                    <p class="text-muted small mt-1">Current thumbnail</p>
                </div>
            <?php endif; ?>
        </div>
        <input type="file" class="form-control" id="thumbnail" name="thumbnail" accept="image/*">
        <small class="text-muted">JPG, PNG, WebP, GIF. Max 5MB. <?= $game ? '(Leave empty to keep current)' : '' ?></small>
    </div>

    <div class="form-check mb-3">
        <input type="checkbox" class="form-check-input" id="is_Active" name="is_Active"
            value="1" <?= ($game['is_Active'] ?? 1) ? 'checked' : '' ?>>
        <label class="form-check-label" for="is_Active">
            Active (show in widgets)
        </label>
    </div>

    <div class="d-flex gap-2">
        <button type="submit" class="btn btn-primary">
            <i class="bi bi-check-circle me-1"></i><?= $game ? 'Update Game' : 'Create Game' ?>
        </button>
        <a href="<?= BASE_URL ?>/admin/trending-games" class="btn btn-secondary">Cancel</a>
    </div>
</form>

<style>
    .form-admin {
        background: var(--bg-card);
        border: 1px solid var(--border);
        border-radius: var(--radius);
        padding: 24px;
        margin-top: 20px;
    }

    .max-width-800 {
        max-width: 800px;
    }
</style>