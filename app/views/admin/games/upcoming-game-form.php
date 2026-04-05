<?php // app/views/admin/games/upcoming-game-form.php — Create/Edit upcoming game form 
?>

<div class="gn-admin-header mb-4">
    <h1 class="mb-1"><?= htmlspecialchars($pageTitle) ?></h1>
    <a href="<?= BASE_URL ?>/admin/upcoming-games" class="btn btn-secondary btn-sm">
        <i class="bi bi-arrow-left me-1"></i>Back
    </a>
</div>

<form method="POST"
    action="<?= $game ? BASE_URL . '/admin/upcoming-games/update/' . $game['id'] : BASE_URL . '/admin/upcoming-games/store' ?>"
    enctype="multipart/form-data" class="form-admin max-width-800">
    <?= $csrfField ?>

    <div class="mb-3">
        <label for="title" class="form-label">Game Title *</label>
        <input type="text" class="form-control" id="title" name="title"
            value="<?= htmlspecialchars($game['title'] ?? '') ?>" required>
    </div>

    <div class="row mb-3">
        <div class="col-md-6">
            <label for="slug" class="form-label">Slug</label>
            <input type="text" class="form-control" id="slug" name="slug"
                value="<?= htmlspecialchars($game['slug'] ?? '') ?>"
                placeholder="auto-generated">
            <small class="text-muted">Auto-generated from title if empty</small>
        </div>
        <div class="col-md-6">
            <label for="release_date" class="form-label">Release Date *</label>
            <input type="date" class="form-control" id="release_date" name="release_date"
                value="<?= htmlspecialchars($game['release_date'] ?? '') ?>" required>
        </div>
    </div>

    <div class="mb-3">
        <label for="platform" class="form-label">Platform</label>
        <input type="text" class="form-control" id="platform" name="platform"
            value="<?= htmlspecialchars($game['platform'] ?? '') ?>"
            placeholder="e.g., PlayStation 5, Xbox Series X|S, PC">
        <small class="text-muted">Comma-separated list of platforms</small>
    </div>

    <div class="mb-3">
        <label for="description" class="form-label">Description</label>
        <textarea class="form-control" id="description" name="description" rows="3"><?= htmlspecialchars($game['description'] ?? '') ?></textarea>
    </div>

    <!-- Image Upload -->
    <div class="mb-3">
        <label for="image" class="form-label">Cover Image</label>
        <div class="mb-2">
            <?php if (!empty($game['image'])): ?>
                <div class="mb-2">
                    <img src="<?= BASE_URL . '/' . htmlspecialchars($game['image']) ?>" alt="Current" width="150" height="200" class="rounded" style="object-fit: cover;">
                    <p class="text-muted small mt-1">Current image</p>
                </div>
            <?php endif; ?>
        </div>
        <input type="file" class="form-control" id="image" name="image" accept="image/jpeg,image/png,image/webp,image/gif">
        <small class="text-muted">JPG, PNG, WebP, GIF. Max 2MB. <?= $game ? '(Leave empty to keep current)' : '' ?></small>
    </div>

    <div class="row mb-3">
        <div class="col-md-6">
            <label for="status" class="form-label">Status</label>
            <select class="form-select" id="status" name="status">
                <option value="upcoming" <?= ($game['status'] ?? 'upcoming') === 'upcoming' ? 'selected' : '' ?>>Upcoming</option>
                <option value="delayed" <?= ($game['status'] ?? '') === 'delayed' ? 'selected' : '' ?>>Delayed</option>
                <option value="cancelled" <?= ($game['status'] ?? '') === 'cancelled' ? 'selected' : '' ?>>Cancelled</option>
            </select>
        </div>
        <div class="col-md-6">
            <div class="form-check mt-4">
                <input type="checkbox" class="form-check-input" id="is_featured" name="is_featured"
                    value="1" <?= ($game['is_featured'] ?? 0) ? 'checked' : '' ?>>
                <label class="form-check-label" for="is_featured">
                    Featured in sidebar
                </label>
            </div>
        </div>
    </div>

    <div class="d-flex gap-2">
        <button type="submit" class="btn btn-primary">
            <i class="bi bi-check-circle me-1"></i><?= $game ? 'Update Game' : 'Create Game' ?>
        </button>
        <a href="<?= BASE_URL ?>/admin/upcoming-games" class="btn btn-secondary">Cancel</a>
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