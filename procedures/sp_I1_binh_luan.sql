DROP PROCEDURE IF EXISTS sp_I1_binh_luan$$
CREATE PROCEDURE sp_I1_binh_luan(
    IN  p_article_id        INT,
    IN  p_user_id           INT,
    IN  p_parent_comment_id INT,       -- NULL nếu là bình luận gốc
    IN  p_noi_dung          TEXT,
    OUT p_comment_id        INT,
    OUT p_thong_bao         VARCHAR(255)
)
BEGIN
    IF NOT EXISTS (SELECT 1 FROM articles
                   WHERE  article_id = p_article_id AND status = 'published') THEN
        SET p_comment_id = 0;
        SET p_thong_bao  = 'Lỗi: Bài viết không tồn tại hoặc chưa xuất bản';

    ELSEIF p_noi_dung IS NULL OR TRIM(p_noi_dung) = '' THEN
        SET p_comment_id = 0;
        SET p_thong_bao  = 'Lỗi: Nội dung bình luận không được để trống';

    ELSE
        INSERT INTO comments
            (article_id, user_id, parent_comment_id,
             content, is_approved, like_count, created_at)
        VALUES
            (p_article_id, p_user_id, p_parent_comment_id,
             p_noi_dung, 1, 0, NOW());

        SET p_comment_id = LAST_INSERT_ID();
        SET p_thong_bao  = IF(p_parent_comment_id IS NULL,
                              'Đăng bình luận thành công',
                              'Trả lời bình luận thành công');
    END IF;
END$$