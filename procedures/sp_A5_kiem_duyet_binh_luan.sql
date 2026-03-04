DROP PROCEDURE IF EXISTS sp_A5_kiem_duyet_binh_luan$$
CREATE PROCEDURE sp_A5_kiem_duyet_binh_luan(
    IN  p_comment_id INT,
    IN  p_duyet      TINYINT,      -- 1 = duyệt | 0 = từ chối
    IN  p_admin_id   INT,
    OUT p_thong_bao  VARCHAR(255)
)
BEGIN
    IF NOT EXISTS (SELECT 1 FROM comments WHERE comment_id = p_comment_id) THEN
        SET p_thong_bao = 'Lỗi: Bình luận không tồn tại';
    ELSE
        UPDATE comments
        SET    is_approved = p_duyet
        WHERE  comment_id  = p_comment_id;

        INSERT INTO activity_logs (user_id, action, entity_type, entity_id, details, created_at)
        VALUES (p_admin_id,
                IF(p_duyet = 1, 'approve_comment', 'reject_comment'),
                'comment', p_comment_id,
                JSON_OBJECT('comment_id', p_comment_id), NOW());

        SET p_thong_bao = IF(p_duyet = 1,
                             'Duyệt bình luận thành công',
                             'Từ chối bình luận thành công');
    END IF;
END$$