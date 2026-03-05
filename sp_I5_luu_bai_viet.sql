DROP PROCEDURE IF EXISTS sp_I5_luu_bai_viet$$
CREATE PROCEDURE sp_I5_luu_bai_viet(
    IN  p_user_id    INT,
    IN  p_article_id INT,
    OUT p_trang_thai VARCHAR(20),   -- 'saved' hoặc 'removed'
    OUT p_thong_bao  VARCHAR(255)
)
BEGIN
    IF NOT EXISTS (SELECT 1 FROM articles
                   WHERE  article_id = p_article_id AND status = 'published') THEN
        SET p_trang_thai = 'error';
        SET p_thong_bao  = 'Lỗi: Bài viết không tồn tại';

    -- Đã bookmark rồi thì xóa
    ELSEIF EXISTS (SELECT 1 FROM bookmarks
                   WHERE  user_id = p_user_id AND article_id = p_article_id) THEN
        DELETE FROM bookmarks
        WHERE  user_id = p_user_id AND article_id = p_article_id;
        SET p_trang_thai = 'removed';
        SET p_thong_bao  = 'Đã bỏ lưu bài viết';

    -- Chưa bookmark thì thêm
    ELSE
        INSERT INTO bookmarks (user_id, article_id, created_at)
        VALUES (p_user_id, p_article_id, NOW());
        SET p_trang_thai = 'saved';
        SET p_thong_bao  = 'Đã lưu bài viết thành công';
    END IF;
END$$