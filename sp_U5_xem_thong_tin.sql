DROP PROCEDURE IF EXISTS sp_U5_xem_thong_tin$$
CREATE PROCEDURE sp_U5_xem_thong_tin(
    IN p_user_id INT
)
BEGIN
    SELECT
        u.user_id,
        u.username,
        u.email,
        u.full_name,
        u.avatar,
        u.bio,
        u.created_at,
        u.last_login,
        u.is_active,
        r.role_name,
        COUNT(DISTINCT a.article_id)  AS tong_bai_viet,
        COUNT(DISTINCT cm.comment_id) AS tong_binh_luan,
        COUNT(DISTINCT b.bookmark_id) AS tong_bai_da_luu
    FROM  users u
    JOIN  roles r   ON u.role_id = r.role_id
    LEFT JOIN articles  a  ON u.user_id = a.author_id AND a.status = 'published'
    LEFT JOIN comments  cm ON u.user_id = cm.user_id
    LEFT JOIN bookmarks b  ON u.user_id = b.user_id
    WHERE u.user_id = p_user_id
    GROUP BY u.user_id;
END$$