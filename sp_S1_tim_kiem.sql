DROP PROCEDURE IF EXISTS sp_S1_tim_kiem$$
CREATE PROCEDURE sp_S1_tim_kiem(
    IN p_tu_khoa    VARCHAR(255),
    IN p_category_id INT,          -- NULL = tất cả
    IN p_trang      INT,
    IN p_so_luong   INT
)
BEGIN
    DECLARE v_offset INT DEFAULT (p_trang - 1) * p_so_luong;

    SELECT
        a.article_id,
        a.title,
        a.slug,
        a.summary,
        a.thumbnail,
        a.view_count,
        a.published_at,
        c.category_name,
        u.full_name AS ten_tac_gia,
        -- Ưu tiên kết quả: title match = 3, summary = 2, content = 1
        (IF(a.title   LIKE CONCAT('%', p_tu_khoa, '%'), 3, 0) +
         IF(a.summary LIKE CONCAT('%', p_tu_khoa, '%'), 2, 0) +
         IF(a.content LIKE CONCAT('%', p_tu_khoa, '%'), 1, 0)) AS do_lien_quan
    FROM  articles a
    JOIN  categories c ON a.category_id = c.category_id
    JOIN  users      u ON a.author_id   = u.user_id
    WHERE a.status = 'published'
      AND (
            a.title   LIKE CONCAT('%', p_tu_khoa, '%')
         OR a.summary LIKE CONCAT('%', p_tu_khoa, '%')
         OR a.content LIKE CONCAT('%', p_tu_khoa, '%')
          )
      AND (p_category_id IS NULL OR a.category_id = p_category_id)
    ORDER BY do_lien_quan DESC, a.published_at DESC
    LIMIT p_so_luong OFFSET v_offset;

    -- Tổng kết quả
    SELECT COUNT(*) AS tong_ket_qua
    FROM   articles a
    WHERE  a.status = 'published'
      AND (
            a.title   LIKE CONCAT('%', p_tu_khoa, '%')
         OR a.summary LIKE CONCAT('%', p_tu_khoa, '%')
         OR a.content LIKE CONCAT('%', p_tu_khoa, '%')
          )
      AND (p_category_id IS NULL OR a.category_id = p_category_id);
END$$