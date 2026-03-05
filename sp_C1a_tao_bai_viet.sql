DROP PROCEDURE IF EXISTS sp_C1a_tao_bai_viet$$
CREATE PROCEDURE sp_C1a_tao_bai_viet(
    IN  p_title            VARCHAR(255),
    IN  p_slug             VARCHAR(255),
    IN  p_summary          TEXT,
    IN  p_content          LONGTEXT,
    IN  p_thumbnail        VARCHAR(255),
    IN  p_meta_title       VARCHAR(255),
    IN  p_meta_description TEXT,
    IN  p_category_id      INT,
    IN  p_author_id        INT,
    IN  p_status           VARCHAR(20),
    OUT p_article_id       INT,
    OUT p_thong_bao        VARCHAR(255)
)
BEGIN
    IF EXISTS (SELECT 1 FROM articles WHERE slug = p_slug) THEN
        SET p_article_id = 0;
        SET p_thong_bao  = 'Lỗi: Slug đã tồn tại';

    ELSEIF NOT EXISTS (SELECT 1 FROM categories WHERE category_id = p_category_id) THEN
        SET p_article_id = 0;
        SET p_thong_bao  = 'Lỗi: Danh mục không tồn tại';

    ELSE
        INSERT INTO articles
            (title, slug, summary, content, thumbnail,
             meta_title, meta_description,
             category_id, author_id, status,
             published_at, created_at)
        VALUES
            (p_title, p_slug, p_summary, p_content, p_thumbnail,
             p_meta_title, p_meta_description,
             p_category_id, p_author_id, p_status,
             IF(p_status = 'published', NOW(), NULL), NOW());

        SET p_article_id = LAST_INSERT_ID();

        INSERT INTO activity_logs (user_id, action, entity_type, entity_id, details, created_at)
        VALUES (p_author_id, 'create', 'article', p_article_id,
                JSON_OBJECT('title', p_title, 'status', p_status), NOW());

        SET p_thong_bao = 'Tạo bài viết thành công';
    END IF;
END$$