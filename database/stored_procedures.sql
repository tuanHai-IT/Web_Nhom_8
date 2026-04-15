-- =============================================================================
-- stored_procedures.sql
-- All stored procedures for the gamenews project.
-- Append to the END of online_news_db.sql (after all CREATE TABLE / INSERT).
-- MariaDB 10.4 compatible.
-- =============================================================================

DELIMITER $$

-- ===========================================================================
-- ARTICLE PROCEDURES
-- ===========================================================================

DROP PROCEDURE IF EXISTS sp_get_latest_articles $$
CREATE PROCEDURE sp_get_latest_articles(IN p_limit INT)
NOT DETERMINISTIC
BEGIN
    SELECT a.*,
           c.category_name AS category_name, c.slug AS category_slug,
           COALESCE(u.full_name, u.username) AS author_name
    FROM articles a
    JOIN categories c ON a.category_id = c.category_id
    JOIN users u ON a.author_id = u.user_id
    WHERE a.status = 'published'
    ORDER BY a.published_at DESC
    LIMIT p_limit;
END $$

DROP PROCEDURE IF EXISTS sp_get_featured_articles $$
CREATE PROCEDURE sp_get_featured_articles(IN p_limit INT)
NOT DETERMINISTIC
BEGIN
    SELECT a.*,
           c.category_name AS category_name, c.slug AS category_slug,
           COALESCE(u.full_name, u.username) AS author_name
    FROM articles a
    JOIN categories c ON a.category_id = c.category_id
    JOIN users u ON a.author_id = u.user_id
    WHERE a.status = 'published' AND a.is_featured = 1
    ORDER BY a.published_at DESC
    LIMIT p_limit;
END $$

DROP PROCEDURE IF EXISTS sp_get_breaking_articles $$
CREATE PROCEDURE sp_get_breaking_articles(IN p_limit INT)
NOT DETERMINISTIC
BEGIN
    SELECT a.*, c.category_name AS category_name
    FROM articles a
    JOIN categories c ON a.category_id = c.category_id
    WHERE a.status = 'published' AND a.is_breaking = 1
    ORDER BY a.published_at DESC
    LIMIT p_limit;
END $$

DROP PROCEDURE IF EXISTS sp_get_most_viewed_articles $$
CREATE PROCEDURE sp_get_most_viewed_articles(IN p_limit INT)
NOT DETERMINISTIC
BEGIN
    SELECT a.*,
           c.category_name AS category_name, c.slug AS category_slug,
           COALESCE(u.full_name, u.username) AS author_name
    FROM articles a
    JOIN categories c ON a.category_id = c.category_id
    JOIN users u ON a.author_id = u.user_id
    WHERE a.status = 'published'
    ORDER BY a.view_count DESC
    LIMIT p_limit;
END $$

DROP PROCEDURE IF EXISTS sp_get_article_by_slug $$
CREATE PROCEDURE sp_get_article_by_slug(IN p_slug VARCHAR(255))
NOT DETERMINISTIC
BEGIN
    SELECT a.*,
           c.category_name AS category_name, c.slug AS category_slug,
           COALESCE(u.full_name, u.username) AS author_name,
           u.user_id AS author_user_id
    FROM articles a
    JOIN categories c ON a.category_id = c.category_id
    JOIN users u ON a.author_id = u.user_id
    WHERE a.slug = p_slug AND a.status = 'published';
END $$

DROP PROCEDURE IF EXISTS sp_increment_article_view $$
CREATE PROCEDURE sp_increment_article_view(IN p_id INT)
NOT DETERMINISTIC
BEGIN
    UPDATE articles SET view_count = view_count + 1 WHERE article_id = p_id;
END $$

DROP PROCEDURE IF EXISTS sp_get_related_articles $$
CREATE PROCEDURE sp_get_related_articles(IN p_category_id INT, IN p_exclude_id INT, IN p_limit INT)
NOT DETERMINISTIC
BEGIN
    SELECT a.*, c.category_name AS category_name, c.slug AS category_slug
    FROM articles a
    JOIN categories c ON a.category_id = c.category_id
    WHERE a.category_id = p_category_id
      AND a.article_id != p_exclude_id
      AND a.status = 'published'
    ORDER BY a.published_at DESC
    LIMIT p_limit;
END $$

-- Paginated: articles by category — data
DROP PROCEDURE IF EXISTS sp_get_articles_by_category_data $$
CREATE PROCEDURE sp_get_articles_by_category_data(IN p_category_id INT, IN p_limit INT, IN p_offset INT)
NOT DETERMINISTIC
BEGIN
    SELECT a.*,
           c.category_name AS category_name, c.slug AS category_slug,
           COALESCE(u.full_name, u.username) AS author_name
    FROM articles a
    JOIN categories c ON a.category_id = c.category_id
    JOIN users u ON a.author_id = u.user_id
    WHERE a.category_id = p_category_id AND a.status = 'published'
    ORDER BY a.published_at DESC
    LIMIT p_limit OFFSET p_offset;
END $$

-- Paginated: articles by category — count
DROP PROCEDURE IF EXISTS sp_get_articles_by_category_count $$
CREATE PROCEDURE sp_get_articles_by_category_count(IN p_category_id INT)
NOT DETERMINISTIC
BEGIN
    SELECT COUNT(*) AS total
    FROM articles a
    WHERE a.category_id = p_category_id AND a.status = 'published';
END $$

-- Paginated: articles by tag — data
DROP PROCEDURE IF EXISTS sp_get_articles_by_tag_data $$
CREATE PROCEDURE sp_get_articles_by_tag_data(IN p_tag_id INT, IN p_limit INT, IN p_offset INT)
NOT DETERMINISTIC
BEGIN
    SELECT a.*,
           c.category_name AS category_name, c.slug AS category_slug,
           COALESCE(u.full_name, u.username) AS author_name
    FROM articles a
    JOIN categories c ON a.category_id = c.category_id
    JOIN users u ON a.author_id = u.user_id
    JOIN article_tags at ON a.article_id = at.article_id
    WHERE at.tag_id = p_tag_id AND a.status = 'published'
    ORDER BY a.published_at DESC
    LIMIT p_limit OFFSET p_offset;
END $$

-- Paginated: articles by tag — count
DROP PROCEDURE IF EXISTS sp_get_articles_by_tag_count $$
CREATE PROCEDURE sp_get_articles_by_tag_count(IN p_tag_id INT)
NOT DETERMINISTIC
BEGIN
    SELECT COUNT(*) AS total
    FROM articles a
    JOIN article_tags at ON a.article_id = at.article_id
    WHERE at.tag_id = p_tag_id AND a.status = 'published';
END $$

-- Paginated: search — data
DROP PROCEDURE IF EXISTS sp_search_articles_data $$
CREATE PROCEDURE sp_search_articles_data(IN p_like VARCHAR(500), IN p_limit INT, IN p_offset INT)
NOT DETERMINISTIC
BEGIN
    SELECT a.*,
           c.category_name AS category_name, c.slug AS category_slug,
           COALESCE(u.full_name, u.username) AS author_name
    FROM articles a
    JOIN categories c ON a.category_id = c.category_id
    JOIN users u ON a.author_id = u.user_id
    WHERE a.status = 'published'
      AND (a.title LIKE p_like OR a.summary LIKE p_like OR a.content LIKE p_like)
    ORDER BY a.published_at DESC
    LIMIT p_limit OFFSET p_offset;
END $$

-- Paginated: search — count
DROP PROCEDURE IF EXISTS sp_search_articles_count $$
CREATE PROCEDURE sp_search_articles_count(IN p_like VARCHAR(500))
NOT DETERMINISTIC
BEGIN
    SELECT COUNT(*) AS total
    FROM articles a
    WHERE a.status = 'published'
      AND (a.title LIKE p_like OR a.summary LIKE p_like OR a.content LIKE p_like);
END $$

DROP PROCEDURE IF EXISTS sp_get_article_tags $$
CREATE PROCEDURE sp_get_article_tags(IN p_article_id INT)
NOT DETERMINISTIC
BEGIN
    SELECT t.*, t.tag_name AS name
    FROM tags t
    JOIN article_tags at ON t.tag_id = at.tag_id
    WHERE at.article_id = p_article_id;
END $$

-- Paginated: all articles admin — data
DROP PROCEDURE IF EXISTS sp_get_all_articles_admin_data $$
CREATE PROCEDURE sp_get_all_articles_admin_data(IN p_limit INT, IN p_offset INT)
NOT DETERMINISTIC
BEGIN
    SELECT a.*,
           c.category_name AS category_name,
           COALESCE(u.full_name, u.username) AS author_name
    FROM articles a
    JOIN categories c ON a.category_id = c.category_id
    JOIN users u ON a.author_id = u.user_id
    ORDER BY a.created_at DESC
    LIMIT p_limit OFFSET p_offset;
END $$

-- Paginated: all articles admin — count
DROP PROCEDURE IF EXISTS sp_get_all_articles_admin_count $$
CREATE PROCEDURE sp_get_all_articles_admin_count()
NOT DETERMINISTIC
BEGIN
    SELECT COUNT(*) AS total FROM articles;
END $$

DROP PROCEDURE IF EXISTS sp_create_article $$
CREATE PROCEDURE sp_create_article(
    IN p_title            VARCHAR(500),
    IN p_slug             VARCHAR(500),
    IN p_summary          TEXT,
    IN p_content          LONGTEXT,
    IN p_thumbnail        VARCHAR(500),
    IN p_category_id      INT,
    IN p_author_id        INT,
    IN p_status           VARCHAR(50),
    IN p_is_featured      TINYINT,
    IN p_is_breaking      TINYINT,
    IN p_meta_title       VARCHAR(500),
    IN p_meta_description TEXT,
    IN p_published_at     DATETIME
)
NOT DETERMINISTIC
BEGIN
    INSERT INTO articles
        (title, slug, summary, content, thumbnail, category_id, author_id,
         status, is_featured, is_breaking, meta_title, meta_description, published_at)
    VALUES
        (p_title, p_slug, p_summary, p_content, p_thumbnail, p_category_id, p_author_id,
         p_status, p_is_featured, p_is_breaking, p_meta_title, p_meta_description, p_published_at);
    SELECT LAST_INSERT_ID() AS new_id;
END $$

DROP PROCEDURE IF EXISTS sp_update_article $$
CREATE PROCEDURE sp_update_article(
    IN p_id               INT,
    IN p_title            VARCHAR(500),
    IN p_slug             VARCHAR(500),
    IN p_summary          TEXT,
    IN p_content          LONGTEXT,
    IN p_thumbnail        VARCHAR(500),
    IN p_category_id      INT,
    IN p_status           VARCHAR(50),
    IN p_is_featured      TINYINT,
    IN p_is_breaking      TINYINT,
    IN p_meta_title       VARCHAR(500),
    IN p_meta_description TEXT
)
NOT DETERMINISTIC
BEGIN
    UPDATE articles
    SET title=p_title, slug=p_slug, summary=p_summary, content=p_content,
        thumbnail=p_thumbnail, category_id=p_category_id, status=p_status,
        is_featured=p_is_featured, is_breaking=p_is_breaking,
        meta_title=p_meta_title, meta_description=p_meta_description,
        updated_at=NOW()
    WHERE article_id = p_id;
END $$

DROP PROCEDURE IF EXISTS sp_get_avg_rating $$
CREATE PROCEDURE sp_get_avg_rating(IN p_article_id INT)
NOT DETERMINISTIC
BEGIN
    SELECT AVG(score) AS avg_rating FROM ratings WHERE article_id = p_article_id;
END $$

DROP PROCEDURE IF EXISTS sp_get_user_rating $$
CREATE PROCEDURE sp_get_user_rating(IN p_article_id INT, IN p_user_id INT)
NOT DETERMINISTIC
BEGIN
    SELECT score FROM ratings WHERE article_id = p_article_id AND user_id = p_user_id;
END $$

DROP PROCEDURE IF EXISTS sp_rate_article $$
CREATE PROCEDURE sp_rate_article(IN p_article_id INT, IN p_user_id INT, IN p_score INT)
NOT DETERMINISTIC
BEGIN
    INSERT INTO ratings (article_id, user_id, score)
    VALUES (p_article_id, p_user_id, p_score)
    ON DUPLICATE KEY UPDATE score = VALUES(score);
END $$

DROP PROCEDURE IF EXISTS sp_is_bookmarked $$
CREATE PROCEDURE sp_is_bookmarked(IN p_article_id INT, IN p_user_id INT)
NOT DETERMINISTIC
BEGIN
    SELECT 1 AS bookmarked FROM bookmarks WHERE article_id = p_article_id AND user_id = p_user_id;
END $$

DROP PROCEDURE IF EXISTS sp_add_bookmark $$
CREATE PROCEDURE sp_add_bookmark(IN p_article_id INT, IN p_user_id INT)
NOT DETERMINISTIC
BEGIN
    INSERT IGNORE INTO bookmarks (article_id, user_id) VALUES (p_article_id, p_user_id);
END $$

DROP PROCEDURE IF EXISTS sp_delete_bookmark $$
CREATE PROCEDURE sp_delete_bookmark(IN p_article_id INT, IN p_user_id INT)
NOT DETERMINISTIC
BEGIN
    DELETE FROM bookmarks WHERE article_id = p_article_id AND user_id = p_user_id;
END $$

DROP PROCEDURE IF EXISTS sp_get_user_bookmarks $$
CREATE PROCEDURE sp_get_user_bookmarks(IN p_user_id INT)
NOT DETERMINISTIC
BEGIN
    SELECT a.*, c.category_name AS category_name, c.slug AS category_slug
    FROM articles a
    JOIN categories c ON a.category_id = c.category_id
    JOIN bookmarks b ON a.article_id = b.article_id
    WHERE b.user_id = p_user_id AND a.status = 'published'
    ORDER BY b.created_at DESC;
END $$

DROP PROCEDURE IF EXISTS sp_check_article_slug $$
CREATE PROCEDURE sp_check_article_slug(IN p_slug VARCHAR(500))
NOT DETERMINISTIC
BEGIN
    SELECT 1 AS found FROM articles WHERE slug = p_slug;
END $$

DROP PROCEDURE IF EXISTS sp_add_read_history $$
CREATE PROCEDURE sp_add_read_history(IN p_user_id INT, IN p_article_id INT)
NOT DETERMINISTIC
BEGIN
    INSERT INTO read_history (user_id, article_id, read_at)
    VALUES (p_user_id, p_article_id, NOW())
    ON DUPLICATE KEY UPDATE read_at = NOW();
END $$

DROP PROCEDURE IF EXISTS sp_get_read_history $$
CREATE PROCEDURE sp_get_read_history(IN p_user_id INT, IN p_limit INT)
NOT DETERMINISTIC
BEGIN
    SELECT a.*, c.category_name AS category_name, c.slug AS category_slug,
           rh.read_at
    FROM read_history rh
    JOIN articles a ON rh.article_id = a.article_id
    JOIN categories c ON a.category_id = c.category_id
    WHERE rh.user_id = p_user_id AND a.status = 'published'
    ORDER BY rh.read_at DESC
    LIMIT p_limit;
END $$

-- ===========================================================================
-- USER PROCEDURES
-- ===========================================================================

DROP PROCEDURE IF EXISTS sp_find_user_by_email $$
CREATE PROCEDURE sp_find_user_by_email(IN p_email VARCHAR(255))
NOT DETERMINISTIC
BEGIN
    SELECT u.*, r.role_name AS role_name
    FROM users u
    LEFT JOIN roles r ON u.role_id = r.role_id
    WHERE u.email = p_email;
END $$

DROP PROCEDURE IF EXISTS sp_find_user_by_username $$
CREATE PROCEDURE sp_find_user_by_username(IN p_username VARCHAR(255))
NOT DETERMINISTIC
BEGIN
    SELECT * FROM users WHERE username = p_username;
END $$

DROP PROCEDURE IF EXISTS sp_create_user $$
CREATE PROCEDURE sp_create_user(IN p_username VARCHAR(255), IN p_email VARCHAR(255), IN p_password VARCHAR(255))
NOT DETERMINISTIC
BEGIN
    INSERT INTO users (username, email, password, role_id) VALUES (p_username, p_email, p_password, 3);
    SELECT LAST_INSERT_ID() AS new_id;
END $$

DROP PROCEDURE IF EXISTS sp_create_social_user $$
CREATE PROCEDURE sp_create_social_user(IN p_username VARCHAR(255), IN p_email VARCHAR(255), IN p_provider VARCHAR(50))
NOT DETERMINISTIC
BEGIN
    INSERT INTO users (username, email, password, provider, role_id, created_at)
    VALUES (p_username, p_email, '', p_provider, 3, NOW());
    SELECT LAST_INSERT_ID() AS new_id;
END $$

-- Paginated: all users admin — data
DROP PROCEDURE IF EXISTS sp_get_all_users_admin_data $$
CREATE PROCEDURE sp_get_all_users_admin_data(IN p_limit INT, IN p_offset INT)
NOT DETERMINISTIC
BEGIN
    SELECT u.*, r.role_name AS role_name
    FROM users u
    LEFT JOIN roles r ON u.role_id = r.role_id
    ORDER BY u.created_at DESC
    LIMIT p_limit OFFSET p_offset;
END $$

-- Paginated: all users admin — count
DROP PROCEDURE IF EXISTS sp_get_all_users_admin_count $$
CREATE PROCEDURE sp_get_all_users_admin_count()
NOT DETERMINISTIC
BEGIN
    SELECT COUNT(*) AS total FROM users;
END $$

DROP PROCEDURE IF EXISTS sp_update_user_role $$
CREATE PROCEDURE sp_update_user_role(IN p_user_id INT, IN p_role_id INT)
NOT DETERMINISTIC
BEGIN
    UPDATE users SET role_id = p_role_id WHERE user_id = p_user_id;
END $$

DROP PROCEDURE IF EXISTS sp_get_roles $$
CREATE PROCEDURE sp_get_roles()
NOT DETERMINISTIC
BEGIN
    SELECT * FROM roles ORDER BY role_id;
END $$

DROP PROCEDURE IF EXISTS sp_email_exists $$
CREATE PROCEDURE sp_email_exists(IN p_email VARCHAR(255))
NOT DETERMINISTIC
BEGIN
    SELECT 1 AS found FROM users WHERE email = p_email;
END $$

DROP PROCEDURE IF EXISTS sp_username_exists $$
CREATE PROCEDURE sp_username_exists(IN p_username VARCHAR(255))
NOT DETERMINISTIC
BEGIN
    SELECT 1 AS found FROM users WHERE username = p_username;
END $$

DROP PROCEDURE IF EXISTS sp_delete_user_reset_tokens $$
CREATE PROCEDURE sp_delete_user_reset_tokens(IN p_user_id INT)
NOT DETERMINISTIC
BEGIN
    DELETE FROM reset_tokens WHERE user_id = p_user_id;
END $$

DROP PROCEDURE IF EXISTS sp_create_reset_token $$
CREATE PROCEDURE sp_create_reset_token(IN p_user_id INT, IN p_token VARCHAR(255), IN p_expires_at DATETIME)
NOT DETERMINISTIC
BEGIN
    INSERT INTO reset_tokens (user_id, token, expires_at, created_at)
    VALUES (p_user_id, p_token, p_expires_at, NOW());
    SELECT LAST_INSERT_ID() AS new_id;
END $$

DROP PROCEDURE IF EXISTS sp_get_reset_token $$
CREATE PROCEDURE sp_get_reset_token(IN p_token VARCHAR(255))
NOT DETERMINISTIC
BEGIN
    SELECT * FROM reset_tokens WHERE token = p_token;
END $$

DROP PROCEDURE IF EXISTS sp_delete_reset_token $$
CREATE PROCEDURE sp_delete_reset_token(IN p_token VARCHAR(255))
NOT DETERMINISTIC
BEGIN
    DELETE FROM reset_tokens WHERE token = p_token;
END $$

DROP PROCEDURE IF EXISTS sp_update_user_password $$
CREATE PROCEDURE sp_update_user_password(IN p_user_id INT, IN p_hashed_password VARCHAR(255))
NOT DETERMINISTIC
BEGIN
    UPDATE users SET password = p_hashed_password, updated_at = NOW() WHERE user_id = p_user_id;
END $$

DROP PROCEDURE IF EXISTS sp_find_user_by_id $$
CREATE PROCEDURE sp_find_user_by_id(IN p_user_id INT)
NOT DETERMINISTIC
BEGIN
    SELECT u.*, r.role_name
    FROM users u
    LEFT JOIN roles r ON u.role_id = r.role_id
    WHERE u.user_id = p_user_id;
END $$

-- ===========================================================================
-- CATEGORY PROCEDURES
-- ===========================================================================

DROP PROCEDURE IF EXISTS sp_get_all_categories $$
CREATE PROCEDURE sp_get_all_categories()
NOT DETERMINISTIC
BEGIN
    SELECT *, category_name AS name
    FROM categories
    WHERE is_active = 1
    ORDER BY category_name ASC;
END $$

DROP PROCEDURE IF EXISTS sp_get_category_by_slug $$
CREATE PROCEDURE sp_get_category_by_slug(IN p_slug VARCHAR(255))
NOT DETERMINISTIC
BEGIN
    SELECT *, category_name AS name FROM categories WHERE slug = p_slug;
END $$

DROP PROCEDURE IF EXISTS sp_create_category $$
CREATE PROCEDURE sp_create_category(
    IN p_name        VARCHAR(255),
    IN p_slug        VARCHAR(255),
    IN p_description TEXT,
    IN p_color       VARCHAR(50)
)
NOT DETERMINISTIC
BEGIN
    INSERT INTO categories (category_name, slug, description, color)
    VALUES (p_name, p_slug, p_description, p_color);
    SELECT LAST_INSERT_ID() AS new_id;
END $$

DROP PROCEDURE IF EXISTS sp_update_category $$
CREATE PROCEDURE sp_update_category(
    IN p_id          INT,
    IN p_name        VARCHAR(255),
    IN p_slug        VARCHAR(255),
    IN p_description TEXT,
    IN p_color       VARCHAR(50)
)
NOT DETERMINISTIC
BEGIN
    UPDATE categories
    SET category_name = p_name, slug = p_slug, description = p_description, color = p_color
    WHERE category_id = p_id;
END $$

-- ===========================================================================
-- COMMENT PROCEDURES
-- ===========================================================================

DROP PROCEDURE IF EXISTS sp_get_approved_comments $$
CREATE PROCEDURE sp_get_approved_comments(IN p_article_id INT)
NOT DETERMINISTIC
BEGIN
    SELECT c.*, u.username, u.avatar
    FROM comments c
    JOIN users u ON c.user_id = u.user_id
    WHERE c.article_id = p_article_id AND c.is_approved = 1
    ORDER BY c.created_at ASC;
END $$

DROP PROCEDURE IF EXISTS sp_create_comment $$
CREATE PROCEDURE sp_create_comment(IN p_article_id INT, IN p_user_id INT, IN p_content TEXT)
NOT DETERMINISTIC
BEGIN
    INSERT INTO comments (article_id, user_id, content, is_approved)
    VALUES (p_article_id, p_user_id, p_content, 1);
    SELECT LAST_INSERT_ID() AS new_id;
END $$

-- Paginated: all comments admin — data
DROP PROCEDURE IF EXISTS sp_get_all_comments_admin_data $$
CREATE PROCEDURE sp_get_all_comments_admin_data(IN p_limit INT, IN p_offset INT)
NOT DETERMINISTIC
BEGIN
    SELECT c.*, u.username, a.title AS article_title, a.slug AS article_slug
    FROM comments c
    JOIN users u ON c.user_id = u.user_id
    JOIN articles a ON c.article_id = a.article_id
    ORDER BY c.created_at DESC
    LIMIT p_limit OFFSET p_offset;
END $$

-- Paginated: all comments admin — count
DROP PROCEDURE IF EXISTS sp_get_all_comments_admin_count $$
CREATE PROCEDURE sp_get_all_comments_admin_count()
NOT DETERMINISTIC
BEGIN
    SELECT COUNT(*) AS total FROM comments;
END $$

DROP PROCEDURE IF EXISTS sp_approve_comment $$
CREATE PROCEDURE sp_approve_comment(IN p_id INT)
NOT DETERMINISTIC
BEGIN
    UPDATE comments SET is_approved = 1 WHERE comment_id = p_id;
END $$

DROP PROCEDURE IF EXISTS sp_delete_comment $$
CREATE PROCEDURE sp_delete_comment(IN p_id INT)
NOT DETERMINISTIC
BEGIN
    DELETE FROM comments WHERE comment_id = p_id;
END $$

DROP PROCEDURE IF EXISTS sp_get_pending_comment_count $$
CREATE PROCEDURE sp_get_pending_comment_count()
NOT DETERMINISTIC
BEGIN
    SELECT COUNT(*) AS cnt FROM comments WHERE is_approved = 0;
END $$

-- ===========================================================================
-- TAG PROCEDURES
-- ===========================================================================

DROP PROCEDURE IF EXISTS sp_get_tag_by_slug $$
CREATE PROCEDURE sp_get_tag_by_slug(IN p_slug VARCHAR(255))
NOT DETERMINISTIC
BEGIN
    SELECT *, tag_name AS name FROM tags WHERE slug = p_slug;
END $$

DROP PROCEDURE IF EXISTS sp_get_popular_tags $$
CREATE PROCEDURE sp_get_popular_tags(IN p_limit INT)
NOT DETERMINISTIC
BEGIN
    SELECT t.*, t.tag_name AS name, COUNT(at.article_id) AS article_count
    FROM tags t
    JOIN article_tags at ON t.tag_id = at.tag_id
    JOIN articles a ON at.article_id = a.article_id
    WHERE a.status = 'published'
    GROUP BY t.tag_id
    ORDER BY article_count DESC
    LIMIT p_limit;
END $$

DROP PROCEDURE IF EXISTS sp_get_trending_tags $$
CREATE PROCEDURE sp_get_trending_tags(IN p_limit INT)
NOT DETERMINISTIC
BEGIN
    SELECT t.*, t.tag_name AS name, COUNT(at.article_id) AS article_count
    FROM tags t
    JOIN article_tags at ON t.tag_id = at.tag_id
    JOIN articles a ON at.article_id = a.article_id
    WHERE a.status = 'published'
    GROUP BY t.tag_id
    ORDER BY article_count DESC, a.published_at DESC
    LIMIT p_limit;
END $$

-- ===========================================================================
-- TRENDING GAME PROCEDURES
-- ===========================================================================

DROP PROCEDURE IF EXISTS sp_get_all_active_trending_games $$
CREATE PROCEDURE sp_get_all_active_trending_games(IN p_limit INT)
NOT DETERMINISTIC
BEGIN
    SELECT * FROM trending_games
    WHERE is_Active = 1
    ORDER BY featured_rank ASC, article_count DESC
    LIMIT p_limit;
END $$

-- Paginated: trending games admin — data
DROP PROCEDURE IF EXISTS sp_get_all_trending_games_admin_data $$
CREATE PROCEDURE sp_get_all_trending_games_admin_data(IN p_limit INT, IN p_offset INT)
NOT DETERMINISTIC
BEGIN
    SELECT * FROM trending_games
    ORDER BY featured_rank ASC, created_at DESC
    LIMIT p_limit OFFSET p_offset;
END $$

-- Paginated: trending games admin — count
DROP PROCEDURE IF EXISTS sp_get_all_trending_games_admin_count $$
CREATE PROCEDURE sp_get_all_trending_games_admin_count()
NOT DETERMINISTIC
BEGIN
    SELECT COUNT(*) AS total FROM trending_games;
END $$

DROP PROCEDURE IF EXISTS sp_get_trending_game_by_slug $$
CREATE PROCEDURE sp_get_trending_game_by_slug(IN p_slug VARCHAR(255))
NOT DETERMINISTIC
BEGIN
    SELECT * FROM trending_games WHERE slug = p_slug;
END $$

-- ===========================================================================
-- UPCOMING GAME PROCEDURES
-- ===========================================================================

DROP PROCEDURE IF EXISTS sp_get_upcoming_games $$
CREATE PROCEDURE sp_get_upcoming_games(IN p_status VARCHAR(50), IN p_limit INT)
NOT DETERMINISTIC
BEGIN
    SELECT * FROM upcoming_games
    WHERE status = p_status
    ORDER BY is_featured DESC, release_date ASC
    LIMIT p_limit;
END $$

DROP PROCEDURE IF EXISTS sp_get_featured_upcoming_games $$
CREATE PROCEDURE sp_get_featured_upcoming_games(IN p_limit INT)
NOT DETERMINISTIC
BEGIN
    SELECT * FROM upcoming_games
    WHERE is_featured = 1 AND status = 'upcoming'
    ORDER BY release_date ASC
    LIMIT p_limit;
END $$

DROP PROCEDURE IF EXISTS sp_get_releasing_soon_games $$
CREATE PROCEDURE sp_get_releasing_soon_games()
NOT DETERMINISTIC
BEGIN
    SELECT * FROM upcoming_games
    WHERE status = 'upcoming'
      AND release_date BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 30 DAY)
    ORDER BY release_date ASC;
END $$

DROP PROCEDURE IF EXISTS sp_get_upcoming_game_by_slug $$
CREATE PROCEDURE sp_get_upcoming_game_by_slug(IN p_slug VARCHAR(255))
NOT DETERMINISTIC
BEGIN
    SELECT * FROM upcoming_games WHERE slug = p_slug;
END $$

-- Paginated: upcoming games admin — data
DROP PROCEDURE IF EXISTS sp_get_all_upcoming_games_admin_data $$
CREATE PROCEDURE sp_get_all_upcoming_games_admin_data(IN p_limit INT, IN p_offset INT)
NOT DETERMINISTIC
BEGIN
    SELECT * FROM upcoming_games
    ORDER BY release_date DESC
    LIMIT p_limit OFFSET p_offset;
END $$

-- Paginated: upcoming games admin — count
DROP PROCEDURE IF EXISTS sp_get_all_upcoming_games_admin_count $$
CREATE PROCEDURE sp_get_all_upcoming_games_admin_count()
NOT DETERMINISTIC
BEGIN
    SELECT COUNT(*) AS total FROM upcoming_games;
END $$

DROP PROCEDURE IF EXISTS sp_get_upcoming_game_release_date $$
CREATE PROCEDURE sp_get_upcoming_game_release_date(IN p_id INT)
NOT DETERMINISTIC
BEGIN
    SELECT release_date FROM upcoming_games WHERE id = p_id;
END $$

DELIMITER ;
