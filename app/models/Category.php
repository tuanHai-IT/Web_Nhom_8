<?php
// app/models/Category.php
// DB uses category_name column; aliased as 'name' for view compatibility

class Category extends Model
{
    protected string $table      = 'categories';
    protected string $primaryKey = 'category_id';

    public function all(string $orderBy = ''): array
    {
        // SP: sp_get_all_categories
        return $this->db->callProc('sp_get_all_categories', []);
    }

    public function getBySlug(string $slug): array|false
    {
        // SP: sp_get_category_by_slug
        $rows = $this->db->callProc('sp_get_category_by_slug', [$slug]);
        return $rows[0] ?? false;
    }

    public function create(array $data): int
    {
        // SP: sp_create_category
        $rows = $this->db->callProc('sp_create_category', [
            $data['name'],
            $data['slug'],
            $data['description'] ?? '',
            $data['color'] ?? '#e63946',
        ]);
        return (int)($rows[0]['new_id'] ?? 0);
    }

    public function update(int $id, array $data): int
    {
        // SP: sp_update_category
        $this->db->callProc('sp_update_category', [
            $id,
            $data['name'],
            $data['slug'],
            $data['description'] ?? '',
            $data['color'] ?? '#e63946',
        ]);
        return 1;
    }

    public function generateSlug(string $name): string
    {
        return strtolower(trim(preg_replace('/[^A-Za-z0-9-]+/', '-', $name), '-'));
    }
}
