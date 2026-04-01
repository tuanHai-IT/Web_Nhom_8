<?php
// app/models/Category.php
// DB uses category_name column; aliased as 'name' for view compatibility

class Category extends Model {
    protected string $table      = 'categories';
    protected string $primaryKey = 'category_id';

    public function all(string $orderBy = ''): array {
        return $this->db->fetchAll(
            "SELECT *, category_name AS name FROM categories WHERE is_active = 1 ORDER BY category_name ASC"
        );
    }

    public function getBySlug(string $slug): array|false {
        return $this->db->fetchOne(
            "SELECT *, category_name AS name FROM categories WHERE slug = ?", [$slug]
        );
    }

    public function create(array $data): int {
        return $this->db->insert(
            "INSERT INTO categories (category_name, slug, description, color) VALUES (?,?,?,?)",
            [$data['name'], $data['slug'], $data['description'] ?? '', $data['color'] ?? '#e63946']
        );
    }

    public function update(int $id, array $data): int {
        return $this->db->execute(
            "UPDATE categories SET category_name=?, slug=?, description=?, color=? WHERE category_id=?",
            [$data['name'], $data['slug'], $data['description'] ?? '', $data['color'] ?? '#e63946', $id]
        );
    }

    public function generateSlug(string $name): string {
        return strtolower(trim(preg_replace('/[^A-Za-z0-9-]+/', '-', $name), '-'));
    }
}
