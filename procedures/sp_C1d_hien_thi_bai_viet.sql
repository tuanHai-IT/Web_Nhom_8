DROP PROCEDURE IF EXISTS sp_C1d_hien_thi_bai_viet$$
CREATE PROCEDURE sp_C1d_hien_thi_bai_viet(
    IN p_trang      INT,
    IN p_so_luong   INT
)
BEGIN
    DECLARE v_offset INT DEFAULT (p_trang - 1) * p_so_luong;

    -- Danh sách bài viết
    SELECT
        a.article_id,
        a.title,
        a.slug,
        a.summary,
        a.thumbnail,
        a.view_count,
        a.is_featured,
        a.is_breaking,
        a.published_at,
        c.category_name,
        c.slug            AS category_slug,
        u.full_name       AS ten_tac_gia,
        u.avatar          AS avatar_tac_gia,
        ROUND(AVG(r.score), 1)        AS diem_danh_gia,
        COUNT(DISTINCT cm.comment_id) AS so_binh_luan
    FROM  articles a
    JOIN  categories c  ON a.category_id = c.category_id
    JOIN  users      u  ON a.author_id   = u.user_id
    LEFT JOIN ratings  r  ON a.article_id = r.article_id
    LEFT JOIN comments cm ON a.article_id = cm.article_id AND cm.is_approved = 1
    WHERE a.status = 'published'
    GROUP BY a.article_id
    ORDER BY a.published_at DESC
    LIMIT p_so_luong OFFSET v_offset;

    -- Tổng số bài để tính phân trang
    SELECT COUNT(*) AS tong_bai FROM articles WHERE status = 'published';
END$$