-- ============================================================
--  ONLINE NEWS WEBSITE - FULL DATABASE SCRIPT
--  Bao gồm: Tables + Foreign Keys + Stored Procedures
--  Dùng cho: phpMyAdmin / XAMPP MySQL
-- ============================================================

-- ============================================================
-- PHẦN 1: TẠO DATABASE
-- ============================================================
DROP DATABASE IF EXISTS online_news_db;
CREATE DATABASE online_news_db
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE online_news_db;

-- ============================================================
-- PHẦN 2: TẠO CÁC BẢNG (theo thứ tự không bị lỗi FK)
-- ============================================================

-- -------------------------------------------------------
-- Bảng 1: roles
-- -------------------------------------------------------
CREATE TABLE roles (
    role_id     INT          NOT NULL AUTO_INCREMENT,
    role_name   VARCHAR(50)  NOT NULL COMMENT 'admin - editor - member',
    description TEXT,
    permissions VARCHAR(255) COMMENT 'JSON permissions',
    created_at  TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (role_id),
    UNIQUE KEY uk_role_name (role_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------------------
-- Bảng 2: categories
-- -------------------------------------------------------
CREATE TABLE categories (
    category_id   INT          NOT NULL AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL,
    slug          VARCHAR(100) NOT NULL COMMENT 'SEO friendly',
    description   TEXT,
    icon          VARCHAR(50)  COMMENT 'Font-awesome class',
    color         VARCHAR(50)  COMMENT 'Màu đại diện hex',
    parent_id     INT          DEFAULT NULL COMMENT 'FK tự tham chiếu - cho phép cây danh mục',
    display_order INT          DEFAULT 0,
    is_active     TINYINT      DEFAULT 1,
    created_at    TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (category_id),
    UNIQUE KEY uk_category_name (category_name),
    UNIQUE KEY uk_category_slug (slug),
    CONSTRAINT fk_category_parent FOREIGN KEY (parent_id)
        REFERENCES categories (category_id) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------------------
-- Bảng 3: tags
-- -------------------------------------------------------
CREATE TABLE tags (
    tag_id      INT         NOT NULL AUTO_INCREMENT,
    tag_name    VARCHAR(50) NOT NULL,
    slug        VARCHAR(50) NOT NULL,
    usage_count INT         DEFAULT 0 COMMENT 'Số lần sử dụng',
    created_at  TIMESTAMP   DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (tag_id),
    UNIQUE KEY uk_tag_name (tag_name),
    UNIQUE KEY uk_tag_slug (slug)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------------------
-- Bảng 4: users
-- -------------------------------------------------------
CREATE TABLE users (
    user_id    INT          NOT NULL AUTO_INCREMENT,
    username   VARCHAR(50)  NOT NULL,
    email      VARCHAR(100) NOT NULL,
    password   VARCHAR(255) NOT NULL COMMENT 'Hashed bcrypt',
    full_name  VARCHAR(100),
    avatar     VARCHAR(255) DEFAULT 'default.jpg',
    bio        TEXT         COMMENT 'Giới thiệu bản thân',
    role_id    INT          DEFAULT 3 COMMENT 'DEFAULT: 3 (member)',
    created_at TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP    NULL ON UPDATE CURRENT_TIMESTAMP,
    last_login TIMESTAMP    NULL COMMENT 'Lần đăng nhập cuối',
    is_active  TINYINT      DEFAULT 1,
    PRIMARY KEY (user_id),
    UNIQUE KEY uk_username (username),
    UNIQUE KEY uk_email (email),
    CONSTRAINT fk_user_role FOREIGN KEY (role_id)
        REFERENCES roles (role_id) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------------------
-- Bảng 5: articles
-- -------------------------------------------------------
CREATE TABLE articles (
    article_id       INT          NOT NULL AUTO_INCREMENT,
    title            VARCHAR(255) NOT NULL,
    slug             VARCHAR(255) NOT NULL COMMENT 'SEO friendly URL',
    summary          TEXT         COMMENT 'Tóm tắt ngắn 200 ký tự',
    content          LONGTEXT     COMMENT 'Nội dung HTML đầy đủ',
    thumbnail        VARCHAR(255) COMMENT 'Ảnh đại diện',
    meta_title       VARCHAR(255) COMMENT 'SEO title',
    meta_description TEXT         COMMENT 'SEO description',
    category_id      INT          NOT NULL,
    author_id        INT          NOT NULL,
    view_count       INT          DEFAULT 0,
    status           ENUM('draft','published','archived') DEFAULT 'draft',
    is_featured      TINYINT      DEFAULT 0 COMMENT 'Tin nổi bật',
    is_breaking      TINYINT      DEFAULT 0 COMMENT 'Tin nóng',
    published_at     TIMESTAMP    NULL COMMENT 'Ngày xuất bản',
    created_at       TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP    NULL ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (article_id),
    UNIQUE KEY uk_article_slug (slug),
    CONSTRAINT fk_article_category FOREIGN KEY (category_id)
        REFERENCES categories (category_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_article_author FOREIGN KEY (author_id)
        REFERENCES users (user_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------------------
-- Bảng 6: article_tags (bảng trung gian)
-- -------------------------------------------------------
CREATE TABLE article_tags (
    id         INT       NOT NULL AUTO_INCREMENT,
    article_id INT       NOT NULL,
    tag_id     INT       NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uk_article_tag (article_id, tag_id),
    CONSTRAINT fk_at_article FOREIGN KEY (article_id)
        REFERENCES articles (article_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_at_tag FOREIGN KEY (tag_id)
        REFERENCES tags (tag_id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------------------
-- Bảng 7: comments
-- -------------------------------------------------------
CREATE TABLE comments (
    comment_id        INT       NOT NULL AUTO_INCREMENT,
    article_id        INT       NOT NULL,
    user_id           INT       NOT NULL,
    parent_comment_id INT       DEFAULT NULL COMMENT 'NULL for root - Nested comments',
    content           TEXT      NOT NULL,
    is_approved       TINYINT   DEFAULT 1,
    like_count        INT       DEFAULT 0,
    created_at        TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at        TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (comment_id),
    CONSTRAINT fk_comment_article FOREIGN KEY (article_id)
        REFERENCES articles (article_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_comment_user FOREIGN KEY (user_id)
        REFERENCES users (user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_comment_parent FOREIGN KEY (parent_comment_id)
        REFERENCES comments (comment_id) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------------------
-- Bảng 8: ratings
-- -------------------------------------------------------
CREATE TABLE ratings (
    rating_id  INT       NOT NULL AUTO_INCREMENT,
    article_id INT       NOT NULL,
    user_id    INT       NOT NULL,
    score      TINYINT   NOT NULL COMMENT '1-5 stars',
    review     TEXT      COMMENT 'Nhận xét chi tiết',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (rating_id),
    UNIQUE KEY uk_rating (article_id, user_id),
    CONSTRAINT fk_rating_article FOREIGN KEY (article_id)
        REFERENCES articles (article_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_rating_user FOREIGN KEY (user_id)
        REFERENCES users (user_id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------------------
-- Bảng 9: bookmarks
-- -------------------------------------------------------
CREATE TABLE bookmarks (
    bookmark_id INT       NOT NULL AUTO_INCREMENT,
    user_id     INT       NOT NULL,
    article_id  INT       NOT NULL,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (bookmark_id),
    UNIQUE KEY uk_bookmark (user_id, article_id),
    CONSTRAINT fk_bookmark_user FOREIGN KEY (user_id)
        REFERENCES users (user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_bookmark_article FOREIGN KEY (article_id)
        REFERENCES articles (article_id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------------------
-- Bảng 10: article_views
-- -------------------------------------------------------
CREATE TABLE article_views (
    view_id    INT          NOT NULL AUTO_INCREMENT,
    article_id INT          NOT NULL,
    user_id    INT          DEFAULT NULL COMMENT 'NULL for guest',
    ip_address VARCHAR(45)  COMMENT 'IP người xem',
    user_agent VARCHAR(255) COMMENT 'Browser info',
    viewed_at  TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (view_id),
    CONSTRAINT fk_view_article FOREIGN KEY (article_id)
        REFERENCES articles (article_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_view_user FOREIGN KEY (user_id)
        REFERENCES users (user_id) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------------------
-- Bảng 11: media
-- -------------------------------------------------------
CREATE TABLE media (
    media_id    INT          NOT NULL AUTO_INCREMENT,
    file_name   VARCHAR(255) NOT NULL,
    file_path   VARCHAR(255) NOT NULL,
    file_type   VARCHAR(50)  COMMENT 'image - video - document',
    file_size   INT          COMMENT 'Kích thước bytes',
    uploaded_by INT          COMMENT 'FK -> users(user_id)',
    article_id  INT          DEFAULT NULL COMMENT 'FK -> articles - NULL: chưa gắn bài',
    created_at  TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (media_id),
    CONSTRAINT fk_media_user FOREIGN KEY (uploaded_by)
        REFERENCES users (user_id) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_media_article FOREIGN KEY (article_id)
        REFERENCES articles (article_id) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------------------
-- Bảng 12: activity_logs
-- -------------------------------------------------------
CREATE TABLE activity_logs (
    log_id      INT         NOT NULL AUTO_INCREMENT,
    user_id     INT         NOT NULL,
    action      VARCHAR(50) COMMENT 'create - update - delete - login',
    entity_type VARCHAR(50) COMMENT 'article - category - user',
    entity_id   INT         COMMENT 'ID của đối tượng',
    details     TEXT        COMMENT 'JSON chi tiết thay đổi',
    ip_address  VARCHAR(45),
    created_at  TIMESTAMP   DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (log_id),
    CONSTRAINT fk_log_user FOREIGN KEY (user_id)
        REFERENCES users (user_id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------------------
-- Bảng 13: settings
-- -------------------------------------------------------
CREATE TABLE settings (
    setting_id    INT          NOT NULL AUTO_INCREMENT,
    setting_key   VARCHAR(100) NOT NULL,
    setting_value TEXT,
    setting_group VARCHAR(50)  COMMENT 'general - seo - social',
    updated_at    TIMESTAMP    NULL ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (setting_id),
    UNIQUE KEY uk_setting_key (setting_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- ============================================================
-- PHẦN 3: DỮ LIỆU MẪU (Sample Data)
-- ============================================================

INSERT INTO roles (role_name, description, permissions) VALUES
('admin',  'Quản trị viên toàn quyền', '{"all":true}'),
('editor', 'Biên tập viên',            '{"articles":true,"media":true}'),
('member', 'Thành viên thông thường',  '{"comment":true,"bookmark":true}');

INSERT INTO categories (category_name, slug, description, display_order) VALUES
('Thời sự',      'thoi-su',      'Tin tức thời sự trong và ngoài nước', 1),
('Thể thao',     'the-thao',     'Tin tức thể thao',                    2),
('Công nghệ',    'cong-nghe',    'Tin tức công nghệ',                   3),
('Giải trí',     'giai-tri',     'Tin tức giải trí',                    4),
('Kinh tế',      'kinh-te',      'Tin tức kinh tế tài chính',           5),
('Sức khỏe',     'suc-khoe',     'Tin tức sức khỏe y tế',              6);

INSERT INTO tags (tag_name, slug) VALUES
('Việt Nam',  'viet-nam'),
('Thế giới',  'the-gioi'),
('COVID-19',  'covid-19'),
('AI',        'ai'),
('Bóng đá',   'bong-da');

INSERT INTO users (username, email, password, full_name, role_id) VALUES
('admin',   'admin@news.com',   '$2y$10$examplehash1', 'Quản Trị Viên', 1),
('editor1', 'editor1@news.com', '$2y$10$examplehash2', 'Biên Tập Viên', 2),
('member1', 'member1@news.com', '$2y$10$examplehash3', 'Thành Viên 1',  3);

INSERT INTO articles (title, slug, summary, content, category_id, author_id, status, published_at) VALUES
('Tin tức công nghệ mới nhất 2025', 'tin-tuc-cong-nghe-2025',
 'Tổng hợp các tin tức công nghệ nổi bật', '<p>Nội dung bài viết...</p>',
 3, 2, 'published', NOW()),
('Kết quả bóng đá hôm nay', 'ket-qua-bong-da-hom-nay',
 'Tổng hợp kết quả các trận đấu', '<p>Nội dung bài viết...</p>',
 2, 2, 'published', NOW());

INSERT INTO settings (setting_key, setting_value, setting_group) VALUES
('site_name',        'Online News',              'general'),
('site_description', 'Trang tin tức trực tuyến', 'general'),
('meta_keywords',    'tin tức, news, việt nam',  'seo'),
('facebook_url',     'https://facebook.com',     'social');


-- ============================================================
-- PHẦN 4: STORED PROCEDURES
-- ============================================================

DELIMITER $$

-- -------------------------------------------------------
-- NHÓM A: QUẢN LÝ BÀI VIẾT (Articles)
-- -------------------------------------------------------

-- Proc 1: Tìm kiếm bài viết theo từ khóa
DROP PROCEDURE IF EXISTS sp_search_articles$$
CREATE PROCEDURE sp_search_articles(
    IN  p_keyword    VARCHAR(255),
    IN  p_category_id INT,
    IN  p_page       INT,
    IN  p_page_size  INT
)
BEGIN
    DECLARE v_offset INT DEFAULT 0;
    SET v_offset = (p_page - 1) * p_page_size;

    SELECT
        a.article_id,
        a.title,
        a.slug,
        a.summary,
        a.thumbnail,
        a.view_count,
        a.published_at,
        c.category_name,
        u.full_name AS author_name,
        AVG(r.score) AS avg_rating
    FROM articles a
    JOIN categories c ON a.category_id = c.category_id
    JOIN users      u ON a.author_id   = u.user_id
    LEFT JOIN ratings r ON a.article_id = r.article_id
    WHERE
        a.status = 'published'
        AND (p_keyword IS NULL OR a.title LIKE CONCAT('%', p_keyword, '%')
                               OR a.summary LIKE CONCAT('%', p_keyword, '%'))
        AND (p_category_id IS NULL OR a.category_id = p_category_id)
    GROUP BY a.article_id
    ORDER BY a.published_at DESC
    LIMIT p_page_size OFFSET v_offset;
END$$

-- Proc 2: Lấy danh sách bài viết mới nhất (có phân trang)
DROP PROCEDURE IF EXISTS sp_get_latest_articles$$
CREATE PROCEDURE sp_get_latest_articles(
    IN p_page      INT,
    IN p_page_size INT
)
BEGIN
    DECLARE v_offset INT DEFAULT 0;
    SET v_offset = (p_page - 1) * p_page_size;

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
        c.slug AS category_slug,
        u.full_name AS author_name,
        u.avatar AS author_avatar
    FROM articles a
    JOIN categories c ON a.category_id = c.category_id
    JOIN users      u ON a.author_id   = u.user_id
    WHERE a.status = 'published'
    ORDER BY a.published_at DESC
    LIMIT p_page_size OFFSET v_offset;
END$$

-- Proc 3: Lấy chi tiết 1 bài viết theo slug (tăng view_count)
DROP PROCEDURE IF EXISTS sp_get_article_detail$$
CREATE PROCEDURE sp_get_article_detail(
    IN p_slug VARCHAR(255)
)
BEGIN
    -- Cập nhật lượt xem
    UPDATE articles SET view_count = view_count + 1
    WHERE slug = p_slug AND status = 'published';

    -- Trả về chi tiết bài viết
    SELECT
        a.article_id,
        a.title,
        a.slug,
        a.content,
        a.thumbnail,
        a.meta_title,
        a.meta_description,
        a.view_count,
        a.published_at,
        c.category_name,
        c.slug AS category_slug,
        u.full_name AS author_name,
        u.avatar AS author_avatar,
        u.bio AS author_bio,
        AVG(r.score) AS avg_rating,
        COUNT(DISTINCT r.rating_id) AS total_ratings,
        COUNT(DISTINCT cm.comment_id) AS total_comments
    FROM articles a
    JOIN categories c ON a.category_id = c.category_id
    JOIN users      u ON a.author_id   = u.user_id
    LEFT JOIN ratings  r  ON a.article_id = r.article_id
    LEFT JOIN comments cm ON a.article_id = cm.article_id AND cm.is_approved = 1
    WHERE a.slug = p_slug AND a.status = 'published'
    GROUP BY a.article_id;
END$$

-- Proc 4: Thêm bài viết mới
DROP PROCEDURE IF EXISTS sp_create_article$$
CREATE PROCEDURE sp_create_article(
    IN  p_title       VARCHAR(255),
    IN  p_slug        VARCHAR(255),
    IN  p_summary     TEXT,
    IN  p_content     LONGTEXT,
    IN  p_thumbnail   VARCHAR(255),
    IN  p_category_id INT,
    IN  p_author_id   INT,
    IN  p_status      VARCHAR(20),
    OUT p_article_id  INT,
    OUT p_message     VARCHAR(255)
)
BEGIN
    -- Kiểm tra slug trùng
    IF EXISTS (SELECT 1 FROM articles WHERE slug = p_slug) THEN
        SET p_article_id = 0;
        SET p_message = 'Lỗi: Slug đã tồn tại';
    ELSE
        INSERT INTO articles (title, slug, summary, content, thumbnail, category_id, author_id, status, published_at)
        VALUES (
            p_title, p_slug, p_summary, p_content, p_thumbnail,
            p_category_id, p_author_id, p_status,
            IF(p_status = 'published', NOW(), NULL)
        );
        SET p_article_id = LAST_INSERT_ID();
        SET p_message = 'Tạo bài viết thành công';
    END IF;
END$$

-- Proc 5: Xóa bài viết (soft delete -> archived)
DROP PROCEDURE IF EXISTS sp_delete_article$$
CREATE PROCEDURE sp_delete_article(
    IN  p_article_id INT,
    IN  p_user_id    INT,
    OUT p_message    VARCHAR(255)
)
BEGIN
    IF NOT EXISTS (SELECT 1 FROM articles WHERE article_id = p_article_id) THEN
        SET p_message = 'Lỗi: Bài viết không tồn tại';
    ELSE
        UPDATE articles SET status = 'archived', updated_at = NOW()
        WHERE article_id = p_article_id;

        INSERT INTO activity_logs (user_id, action, entity_type, entity_id, details)
        VALUES (p_user_id, 'delete', 'article', p_article_id,
                JSON_OBJECT('action','archived','article_id', p_article_id));

        SET p_message = 'Xóa bài viết thành công';
    END IF;
END$$


-- -------------------------------------------------------
-- NHÓM B: QUẢN LÝ BÌNH LUẬN (Comments)
-- -------------------------------------------------------

-- Proc 6: Lấy danh sách bình luận của 1 bài viết (có phân cấp)
DROP PROCEDURE IF EXISTS sp_get_comments$$
CREATE PROCEDURE sp_get_comments(
    IN p_article_id INT
)
BEGIN
    SELECT
        cm.comment_id,
        cm.parent_comment_id,
        cm.content,
        cm.like_count,
        cm.created_at,
        u.user_id,
        u.username,
        u.full_name,
        u.avatar
    FROM comments cm
    JOIN users u ON cm.user_id = u.user_id
    WHERE cm.article_id = p_article_id
      AND cm.is_approved = 1
    ORDER BY cm.parent_comment_id IS NULL DESC, cm.created_at ASC;
END$$

-- Proc 7: Thêm bình luận
DROP PROCEDURE IF EXISTS sp_add_comment$$
CREATE PROCEDURE sp_add_comment(
    IN  p_article_id        INT,
    IN  p_user_id           INT,
    IN  p_parent_comment_id INT,
    IN  p_content           TEXT,
    OUT p_comment_id        INT,
    OUT p_message           VARCHAR(255)
)
BEGIN
    IF NOT EXISTS (SELECT 1 FROM articles WHERE article_id = p_article_id AND status = 'published') THEN
        SET p_comment_id = 0;
        SET p_message = 'Lỗi: Bài viết không tồn tại hoặc chưa xuất bản';
    ELSEIF p_content IS NULL OR TRIM(p_content) = '' THEN
        SET p_comment_id = 0;
        SET p_message = 'Lỗi: Nội dung bình luận không được để trống';
    ELSE
        INSERT INTO comments (article_id, user_id, parent_comment_id, content)
        VALUES (p_article_id, p_user_id, p_parent_comment_id, p_content);
        SET p_comment_id = LAST_INSERT_ID();
        SET p_message = 'Thêm bình luận thành công';
    END IF;
END$$


-- -------------------------------------------------------
-- NHÓM C: QUẢN LÝ NGƯỜI DÙNG (Users)
-- -------------------------------------------------------

-- Proc 8: Lấy danh sách người dùng (admin)
DROP PROCEDURE IF EXISTS sp_list_users$$
CREATE PROCEDURE sp_list_users(
    IN p_role_id   INT,
    IN p_is_active TINYINT,
    IN p_page      INT,
    IN p_page_size INT
)
BEGIN
    DECLARE v_offset INT DEFAULT 0;
    SET v_offset = (p_page - 1) * p_page_size;

    SELECT
        u.user_id,
        u.username,
        u.email,
        u.full_name,
        u.avatar,
        u.is_active,
        u.created_at,
        u.last_login,
        r.role_name,
        COUNT(DISTINCT a.article_id) AS total_articles,
        COUNT(DISTINCT cm.comment_id) AS total_comments
    FROM users u
    JOIN roles r ON u.role_id = r.role_id
    LEFT JOIN articles a ON u.user_id = a.author_id
    LEFT JOIN comments cm ON u.user_id = cm.user_id
    WHERE
        (p_role_id IS NULL OR u.role_id = p_role_id)
        AND (p_is_active IS NULL OR u.is_active = p_is_active)
    GROUP BY u.user_id
    ORDER BY u.created_at DESC
    LIMIT p_page_size OFFSET v_offset;
END$$

-- Proc 9: Đăng ký tài khoản mới
DROP PROCEDURE IF EXISTS sp_register_user$$
CREATE PROCEDURE sp_register_user(
    IN  p_username  VARCHAR(50),
    IN  p_email     VARCHAR(100),
    IN  p_password  VARCHAR(255),
    IN  p_full_name VARCHAR(100),
    OUT p_user_id   INT,
    OUT p_message   VARCHAR(255)
)
BEGIN
    IF EXISTS (SELECT 1 FROM users WHERE username = p_username) THEN
        SET p_user_id = 0;
        SET p_message = 'Lỗi: Username đã tồn tại';
    ELSEIF EXISTS (SELECT 1 FROM users WHERE email = p_email) THEN
        SET p_user_id = 0;
        SET p_message = 'Lỗi: Email đã được đăng ký';
    ELSE
        INSERT INTO users (username, email, password, full_name, role_id)
        VALUES (p_username, p_email, p_password, p_full_name, 3);
        SET p_user_id = LAST_INSERT_ID();
        SET p_message = 'Đăng ký thành công';
    END IF;
END$$


-- -------------------------------------------------------
-- NHÓM D: BOOKMARK & RATING
-- -------------------------------------------------------

-- Proc 10: Toggle bookmark (thêm/xóa bookmark)
DROP PROCEDURE IF EXISTS sp_toggle_bookmark$$
CREATE PROCEDURE sp_toggle_bookmark(
    IN  p_user_id    INT,
    IN  p_article_id INT,
    OUT p_status     VARCHAR(20),
    OUT p_message    VARCHAR(255)
)
BEGIN
    IF EXISTS (SELECT 1 FROM bookmarks WHERE user_id = p_user_id AND article_id = p_article_id) THEN
        DELETE FROM bookmarks WHERE user_id = p_user_id AND article_id = p_article_id;
        SET p_status = 'removed';
        SET p_message = 'Đã xóa bookmark';
    ELSE
        INSERT INTO bookmarks (user_id, article_id) VALUES (p_user_id, p_article_id);
        SET p_status = 'added';
        SET p_message = 'Đã thêm bookmark';
    END IF;
END$$

-- Proc 11: Thêm hoặc cập nhật đánh giá bài viết
DROP PROCEDURE IF EXISTS sp_rate_article$$
CREATE PROCEDURE sp_rate_article(
    IN  p_article_id INT,
    IN  p_user_id    INT,
    IN  p_score      TINYINT,
    IN  p_review     TEXT,
    OUT p_message    VARCHAR(255)
)
BEGIN
    IF p_score < 1 OR p_score > 5 THEN
        SET p_message = 'Lỗi: Điểm đánh giá phải từ 1 đến 5';
    ELSEIF EXISTS (SELECT 1 FROM ratings WHERE article_id = p_article_id AND user_id = p_user_id) THEN
        UPDATE ratings
        SET score = p_score, review = p_review, updated_at = NOW()
        WHERE article_id = p_article_id AND user_id = p_user_id;
        SET p_message = 'Cập nhật đánh giá thành công';
    ELSE
        INSERT INTO ratings (article_id, user_id, score, review)
        VALUES (p_article_id, p_user_id, p_score, p_review);
        SET p_message = 'Thêm đánh giá thành công';
    END IF;
END$$

-- Proc 12: Lấy danh sách bookmark của user
DROP PROCEDURE IF EXISTS sp_get_user_bookmarks$$
CREATE PROCEDURE sp_get_user_bookmarks(
    IN p_user_id   INT,
    IN p_page      INT,
    IN p_page_size INT
)
BEGIN
    DECLARE v_offset INT DEFAULT 0;
    SET v_offset = (p_page - 1) * p_page_size;

    SELECT
        b.bookmark_id,
        b.created_at AS bookmarked_at,
        a.article_id,
        a.title,
        a.slug,
        a.summary,
        a.thumbnail,
        a.published_at,
        c.category_name
    FROM bookmarks b
    JOIN articles   a ON b.article_id   = a.article_id
    JOIN categories c ON a.category_id  = c.category_id
    WHERE b.user_id = p_user_id
    ORDER BY b.created_at DESC
    LIMIT p_page_size OFFSET v_offset;
END$$


-- -------------------------------------------------------
-- NHÓM E: THỐNG KÊ (Statistics)
-- -------------------------------------------------------

-- Proc 13: Thống kê tổng quan (Dashboard admin)
DROP PROCEDURE IF EXISTS sp_dashboard_stats$$
CREATE PROCEDURE sp_dashboard_stats()
BEGIN
    SELECT
        (SELECT COUNT(*) FROM articles WHERE status = 'published')  AS total_published,
        (SELECT COUNT(*) FROM articles WHERE status = 'draft')      AS total_draft,
        (SELECT COUNT(*) FROM users    WHERE is_active = 1)         AS total_users,
        (SELECT COUNT(*) FROM comments WHERE is_approved = 1)       AS total_comments,
        (SELECT SUM(view_count) FROM articles)                      AS total_views,
        (SELECT COUNT(*) FROM articles
         WHERE DATE(published_at) = CURDATE())                      AS articles_today;
END$$

-- Proc 14: Top bài viết được xem nhiều nhất
DROP PROCEDURE IF EXISTS sp_get_top_articles$$
CREATE PROCEDURE sp_get_top_articles(
    IN p_limit INT,
    IN p_days  INT
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
        u.full_name AS author_name
    FROM articles a
    JOIN categories c ON a.category_id = c.category_id
    JOIN users      u ON a.author_id   = u.user_id
    WHERE
        a.status = 'published'
        AND (p_days IS NULL OR a.published_at >= DATE_SUB(NOW(), INTERVAL p_days DAY))
    ORDER BY a.view_count DESC
    LIMIT p_limit;
END$$

-- Proc 15: Lấy các bài viết liên quan (cùng category)
DROP PROCEDURE IF EXISTS sp_get_related_articles$$
CREATE PROCEDURE sp_get_related_articles(
    IN p_article_id INT,
    IN p_limit      INT
)
BEGIN
    DECLARE v_category_id INT;
    SELECT category_id INTO v_category_id FROM articles WHERE article_id = p_article_id;

    SELECT
        a.article_id,
        a.title,
        a.slug,
        a.thumbnail,
        a.view_count,
        a.published_at
    FROM articles a
    WHERE
        a.category_id = v_category_id
        AND a.article_id <> p_article_id
        AND a.status = 'published'
    ORDER BY a.published_at DESC
    LIMIT p_limit;
END$$

DELIMITER ;


-- ============================================================
-- PHẦN 5: HƯỚNG DẪN GỌI STORED PROCEDURES
-- ============================================================
/*
-- Tìm kiếm bài viết (từ khóa "công nghệ", tất cả danh mục, trang 1, 10 bài)
CALL sp_search_articles('công nghệ', NULL, 1, 10);

-- Lấy bài viết mới nhất (trang 1, 10 bài)
CALL sp_get_latest_articles(1, 10);

-- Xem chi tiết bài viết
CALL sp_get_article_detail('tin-tuc-cong-nghe-2025');

-- Tạo bài viết mới
CALL sp_create_article(
    'Tiêu đề bài viết', 'tieu-de-bai-viet',
    'Tóm tắt bài viết', '<p>Nội dung...</p>',
    'thumbnail.jpg', 3, 2, 'published',
    @article_id, @msg
);
SELECT @article_id, @msg;

-- Thêm bình luận
CALL sp_add_comment(1, 3, NULL, 'Bài viết rất hay!', @cid, @msg);
SELECT @cid, @msg;

-- Toggle bookmark
CALL sp_toggle_bookmark(3, 1, @status, @msg);
SELECT @status, @msg;

-- Đánh giá bài viết
CALL sp_rate_article(1, 3, 5, 'Rất tốt!', @msg);
SELECT @msg;

-- Đăng ký tài khoản
CALL sp_register_user('newuser', 'new@email.com', 'hashedpw', 'Người Dùng Mới', @uid, @msg);
SELECT @uid, @msg;

-- Dashboard thống kê
CALL sp_dashboard_stats();

-- Top 10 bài viết được xem nhiều trong 7 ngày qua
CALL sp_get_top_articles(10, 7);
*/

-- ============================================================
-- PHẦN 6: BỔ SUNG INDEX HIỆU NĂNG (Performance Indexes)
-- Dành cho các query thường gặp trong ứng dụng
-- ============================================================

ALTER TABLE articles
    ADD INDEX idx_status          (status),
    ADD INDEX idx_category        (category_id),
    ADD INDEX idx_is_featured     (is_featured),
    ADD INDEX idx_is_breaking     (is_breaking),
    ADD INDEX idx_published_at    (published_at),
    ADD INDEX idx_view_count      (view_count DESC);

ALTER TABLE comments
    ADD INDEX idx_article_approved (article_id, is_approved);

ALTER TABLE ratings
    ADD INDEX idx_article_rating   (article_id);

ALTER TABLE bookmarks
    ADD INDEX idx_user_bookmark    (user_id);

-- ============================================================
-- PHẦN 7: TÀI KHOẢN ADMIN MẶC ĐỊNH
-- password: admin123 (bcrypt)
-- ============================================================
-- Chạy sau khi đã import sample_data_fixed.sql nếu cần reset admin password
-- UPDATE users
--   SET password = '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi'
-- WHERE username = 'admin';

