DROP PROCEDURE IF EXISTS sp_C1b_chinh_sua_bai_viet$$
CREATE PROCEDURE sp_C1b_chinh_sua_bai_viet(
    IN  p_article_id       INT,
    IN  p_title            VARCHAR(255),
    IN  p_slug             VARCHAR(255),
    IN  p_summary          TEXT,
    IN  p_content          LONGTEXT,
    IN  p_thumbnail        VARCHAR(255),
    IN  p_meta_title       VARCHAR(255),
    IN  p_meta_description TEXT,
    IN  p_category_id      INT,
    IN  p_status           VARCHAR(20),
    IN  p_editor_id        INT,
    OUT p_thong_bao        VARCHAR(255)
)
BEGIN
    IF NOT EXISTS (SELECT 1 FROM articles WHERE article_id = p_article_id) THEN
        SET p_thong_bao = 'Lỗi: Bài viết không tồn tại';

    ELSEIF EXISTS (SELECT 1 FROM articles
                   WHERE  slug = p_slug AND article_id != p_article_id) THEN
        SET p_thong_bao = 'Lỗi: Slug đã được dùng bởi bài viết khác';

    ELSE
        UPDATE articles
        SET    title            = p_title,
               slug             = p_slug,
               summary          = p_summary,
               content          = p_content,
               thumbnail        = IFNULL(p_thumbnail, thumbnail),
               meta_title       = p_meta_title,
               meta_description = p_meta_description,
               category_id      = p_category_id,
               status           = p_status,
               published_at     = IF(p_status = 'published' AND published_at IS NULL,
                                     NOW(), published_at),
               updated_at       = NOW()
        WHERE  article_id = p_article_id;

        INSERT INTO activity_logs (user_id, action, entity_type, entity_id, details, created_at)
        VALUES (p_editor_id, 'update', 'article', p_article_id,
                JSON_OBJECT('new_title', p_title, 'status', p_status), NOW());

        SET p_thong_bao = 'Cập nhật bài viết thành công';
    END IF;
END$$