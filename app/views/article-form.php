<?php // app/views/admin/article-form.php
$isEdit = !empty($article);
$a      = $article ?? [];
?>
<div class="mb-4 d-flex align-items-center gap-3">
    <a href="<?= BASE_URL ?>/admin/articles" class="btn btn-sm btn-outline-secondary">
        <i class="bi bi-arrow-left"></i>
    </a>
    <h5 class="mb-0" style="font-family:var(--font-display)">
        <?= $isEdit ? 'Edit Article' : 'New Article' ?>
    </h5>
</div>

<?php if (!empty($errors)): ?>
<div class="alert alert-danger">
    <ul class="mb-0 ps-3">
        <?php foreach ($errors as $field => $msg): ?>
        <li><?= htmlspecialchars($msg) ?></li>
        <?php endforeach; ?>
    </ul>
</div>
<?php endif; ?>

<form method="POST"
      action="<?= BASE_URL ?>/admin/articles/<?= $isEdit ? 'update/' . $a['article_id'] : 'store' ?>"
      enctype="multipart/form-data">

    <?= $csrfField ?>

    <div class="row g-4">
        <div class="col-lg-8">
            <!-- Title -->
            <div class="mb-3">
                <label class="form-label fw-semibold">Title *</label>
                <input type="text" name="title" class="form-control" required
                       value="<?= htmlspecialchars($a['title'] ?? '') ?>">
            </div>

            <!-- Slug -->
            <div class="mb-3">
                <label class="form-label fw-semibold">Slug</label>
                <input type="text" name="slug" class="form-control"
                       placeholder="Auto-generated if empty"
                       value="<?= htmlspecialchars($a['slug'] ?? '') ?>">
            </div>

            <!-- Summary -->
            <div class="mb-3">
                <label class="form-label fw-semibold">Summary</label>
                <textarea name="summary" class="form-control" rows="3"><?= htmlspecialchars($a['summary'] ?? '') ?></textarea>
            </div>

            <!-- Content -->
            <div class="mb-3">
                <label class="form-label fw-semibold">Content (HTML)</label>
                <textarea name="content" class="form-control" rows="14"
                          style="font-family:monospace;font-size:13px"><?= htmlspecialchars($a['content'] ?? '') ?></textarea>
                <div class="form-text">You can paste HTML content directly. Dangerous tags will be stripped.</div>
            </div>

            <!-- Meta -->
            <div class="mb-3">
                <label class="form-label fw-semibold">Meta Title</label>
                <input type="text" name="meta_title" class="form-control"
                       value="<?= htmlspecialchars($a['meta_title'] ?? '') ?>">
            </div>
            <div class="mb-3">
                <label class="form-label fw-semibold">Meta Description</label>
                <textarea name="meta_description" class="form-control" rows="2"><?= htmlspecialchars($a['meta_description'] ?? '') ?></textarea>
            </div>
        </div>

        <div class="col-lg-4">
            <!-- Publish settings -->
            <div class="gn-sidebar-widget mb-4">
                <div class="widget-title">Publish Settings</div>

                <label class="form-label fw-semibold">Status</label>
                <select name="status" class="form-select mb-3">
                    <option value="draft"     <?= ($a['status'] ?? '') === 'draft'     ? 'selected' : '' ?>>Draft</option>
                    <option value="published" <?= ($a['status'] ?? '') === 'published' ? 'selected' : '' ?>>Published</option>
                    <option value="archived"  <?= ($a['status'] ?? '') === 'archived'  ? 'selected' : '' ?>>Archived</option>
                </select>

                <label class="form-label fw-semibold">Category *</label>
                <select name="category_id" class="form-select mb-3" required>
                    <option value="">Select…</option>
                    <?php foreach ($categories as $cat): ?>
                    <option value="<?= $cat['category_id'] ?>"
                        <?= ($a['category_id'] ?? '') == $cat['category_id'] ? 'selected' : '' ?>>
                        <?= htmlspecialchars($cat['name']) ?>
                    </option>
                    <?php endforeach; ?>
                </select>

                <div class="form-check mb-2">
                    <input class="form-check-input" type="checkbox" name="is_featured" value="1" id="ckFeatured"
                           <?= !empty($a['is_featured']) ? 'checked' : '' ?>>
                    <label class="form-check-label" for="ckFeatured">
                        <i class="bi bi-star-fill text-warning me-1"></i>Featured Article
                    </label>
                </div>
                <div class="form-check mb-3">
                    <input class="form-check-input" type="checkbox" name="is_breaking" value="1" id="ckBreaking"
                           <?= !empty($a['is_breaking']) ? 'checked' : '' ?>>
                    <label class="form-check-label" for="ckBreaking">
                        <i class="bi bi-lightning-fill text-danger me-1"></i>Breaking News
                    </label>
                </div>

                <button type="submit" class="btn btn-accent w-100 fw-bold">
                    <i class="bi bi-check-lg me-1"></i>
                    <?= $isEdit ? 'Update Article' : 'Publish Article' ?>
                </button>
            </div>

            <!-- Thumbnail -->
            <div class="gn-sidebar-widget">
                <div class="widget-title">Thumbnail</div>

                <div id="thumbPreviewWrap" class="mb-3" <?= empty($a['thumbnail']) ? 'style="display:none"' : '' ?>>
                    <img id="thumbPreview"
                         src="<?= htmlspecialchars($a['thumbnail'] ?? '') ?>"
                         class="img-fluid rounded"
                         style="width:100%;aspect-ratio:16/9;object-fit:cover;">
                </div>

                <input type="file" name="thumbnail" id="thumbnailInput"
                       class="form-control mb-1" accept="image/jpeg,image/png,image/webp,image/gif">
                <div class="form-text">JPG, PNG, WebP, GIF. Max 5MB.</div>

                <?php if (!empty($a['thumbnail'])): ?>
                <div class="form-text text-warning mt-1">
                    <i class="bi bi-info-circle me-1"></i>
                    Select a new image to replace. Leave empty to keep current.
                </div>
                <?php endif; ?>
            </div>

            <script>
            document.getElementById('thumbnailInput').addEventListener('change', function() {
                const file = this.files[0];
                if (!file) return;
                if (file.size > 5 * 1024 * 1024) {
                    alert('Image too large! Max 5MB.');
                    this.value = '';
                    return;
                }
                const reader = new FileReader();
                reader.onload = e => {
                    document.getElementById('thumbPreview').src = e.target.result;
                    document.getElementById('thumbPreviewWrap').style.display = 'block';
                };
                reader.readAsDataURL(file);
            });
            </script>
        </div>
    </div>
</form>
