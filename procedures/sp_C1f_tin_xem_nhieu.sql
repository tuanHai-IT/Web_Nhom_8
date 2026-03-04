DROP PROCEDURE IF EXISTS sp_C1f_tin_xem_nhieu$$
CREATE PROCEDURE sp_C1f_tin_xem_nhieu(
    IN p_so_luong INT,
    IN p_so_ngay  INT     -- NULL = tất cả thời gian
)
BEGIN
    SELECT
        a.article_id,
        a.title,
        a.slug,
        a.thumbnail,
        a.view_count,
        a.published_at,
        c.category_name,
        u.full_name AS ten_tac_gia
    FROM  articles a
    JOIN  categories c ON a.category_id = c.category_id
    JOIN  users      u ON a.author_id   = u.user_id
    WHERE a.status = 'published'
      AND (p_so_ngay IS NULL
           OR a.published_at >= DATE_SUB(NOW(), INTERVAL p_so_ngay DAY))
    ORDER BY a.view_count DESC
    LIMIT p_so_luong;
END$$