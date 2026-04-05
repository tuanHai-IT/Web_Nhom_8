<?php // app/views/admin/categories.php ?>
<div class="d-flex justify-content-between align-items-center mb-4">
    <h5 class="mb-0" style="font-family:var(--font-display)">Categories</h5>
    <button class="btn btn-accent btn-sm" data-bs-toggle="modal" data-bs-target="#addCatModal">
        <i class="bi bi-plus-lg me-1"></i>Add Category
    </button>
</div>

<div class="admin-table">
    <table class="table table-dark table-hover">
        <thead><tr><th>#</th><th>Color</th><th>Name</th><th>Slug</th><th>Description</th><th>Actions</th></tr></thead>
        <tbody>
            <?php foreach ($categories as $c): ?>
            <tr>
                <td class="text-muted"><?= $c['category_id'] ?></td>
                <td><span style="color:<?= htmlspecialchars($c['color'] ?? '#e63946') ?>;font-size:1.2rem">■</span></td>
                <td class="fw-semibold"><?= htmlspecialchars($c['name']) ?></td>
                <td class="text-muted small"><?= htmlspecialchars($c['slug']) ?></td>
                <td><?= htmlspecialchars(mb_strimwidth($c['description'] ?? '', 0, 50, '…')) ?></td>
                <td>
                    <button class="btn btn-sm btn-outline-secondary me-1"
                            onclick="editCategory(<?= htmlspecialchars(json_encode($c)) ?>)">
                        <i class="bi bi-pencil"></i>
                    </button>
                    <button class="btn btn-sm btn-outline-danger"
                            onclick="deleteCategory(<?= $c['category_id'] ?>)">
                        <i class="bi bi-trash"></i>
                    </button>
                </td>
            </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
</div>

<!-- Add Category Modal -->
<div class="modal fade" id="addCatModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content bg-dark border border-secondary">
            <div class="modal-header border-secondary">
                <h5 class="modal-title" style="font-family:var(--font-display)">Add Category</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form id="addCatForm">
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">Name *</label>
                        <input type="text" name="name" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Description</label>
                        <textarea name="description" class="form-control" rows="2"></textarea>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Color</label>
                        <input type="color" name="color" class="form-control form-control-color" value="#e63946">
                    </div>
                </div>
                <div class="modal-footer border-secondary">
                    <button type="submit" class="btn btn-accent">Add Category</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Edit Category Modal -->
<div class="modal fade" id="editCatModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content bg-dark border border-secondary">
            <div class="modal-header border-secondary">
                <h5 class="modal-title" style="font-family:var(--font-display)">Edit Category</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form id="editCatForm">
                <input type="hidden" name="cat_id" id="editCatId">
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">Name *</label>
                        <input type="text" name="name" id="editCatName" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Slug</label>
                        <input type="text" name="slug" id="editCatSlug" class="form-control">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Description</label>
                        <textarea name="description" id="editCatDesc" class="form-control" rows="2"></textarea>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Color</label>
                        <input type="color" name="color" id="editCatColor" class="form-control form-control-color">
                    </div>
                </div>
                <div class="modal-footer border-secondary">
                    <button type="submit" class="btn btn-accent">Update</button>
                </div>
            </form>
        </div>
    </div>
</div>
