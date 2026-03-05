DROP PROCEDURE IF EXISTS sp_R4_dashboard$$
CREATE PROCEDURE sp_R4_dashboard()
BEGIN
    -- Số liệu tổng quan toàn hệ thống
    SELECT
        (SELECT COUNT(*) FROM articles WHERE status = 'published')  AS bai_da_dang,
        (SELECT COUNT(*) FROM articles WHERE status = 'draft')      AS bai_nhap,
        (SELECT COUNT(*) FROM articles WHERE status = 'archived')   AS bai_da_xoa,
        (SELECT COUNT(*) FROM users    WHERE is_active = 1)         AS nguoi_dung_active,
        (SELECT COUNT(*) FROM comments WHERE is_approved = 1)       AS binh_luan,
        (SELECT COUNT(*) FROM ratings)                              AS danh_gia,
        (SELECT COUNT(*) FROM bookmarks)                            AS bookmark,
        (SELECT IFNULL(SUM(view_count), 0) FROM articles)           AS tong_luot_xem,
        -- Hôm nay
        (SELECT COUNT(*) FROM articles
         WHERE  DATE(published_at) = CURDATE()
           AND  status = 'published')                               AS bai_dang_hom_nay,
        (SELECT COUNT(*) FROM users
         WHERE  DATE(created_at) = CURDATE())                       AS dk_moi_hom_nay,
        (SELECT COUNT(*) FROM comments
         WHERE  DATE(created_at) = CURDATE())                       AS binh_luan_hom_nay;

    -- 5 bài viết mới nhất
    SELECT a.title, a.slug, a.published_at, u.full_name AS tac_gia
    FROM   articles a
    JOIN   users    u ON a.author_id = u.user_id
    WHERE  a.status = 'published'
    ORDER BY a.published_at DESC LIMIT 5;

    -- 5 bình luận mới nhất chờ duyệt
    SELECT cm.comment_id, cm.content, cm.created_at,
           u.username, a.title AS bai_viet
    FROM   comments  cm
    JOIN   users     u  ON cm.user_id    = u.user_id
    JOIN   articles  a  ON cm.article_id = a.article_id
    WHERE  cm.is_approved = 0
    ORDER BY cm.created_at DESC LIMIT 5;
END$$