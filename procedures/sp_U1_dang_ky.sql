DROP PROCEDURE IF EXISTS sp_U1_dang_ky$$
CREATE PROCEDURE sp_U1_dang_ky(
    IN  p_username  VARCHAR(50),
    IN  p_email     VARCHAR(100),
    IN  p_password  VARCHAR(255),
    IN  p_full_name VARCHAR(100),
    OUT p_user_id   INT,
    OUT p_thong_bao VARCHAR(255)
)
BEGIN
    -- Validate: username trùng
    IF EXISTS (SELECT 1 FROM users WHERE username = p_username) THEN
        SET p_user_id = 0;
        SET p_thong_bao = 'Lỗi: Username đã tồn tại';

    -- Validate: email trùng
    ELSEIF EXISTS (SELECT 1 FROM users WHERE email = p_email) THEN
        SET p_user_id = 0;
        SET p_thong_bao = 'Lỗi: Email đã được đăng ký';

    -- Validate: độ dài mật khẩu
    ELSEIF LENGTH(p_password) < 6 THEN
        SET p_user_id = 0;
        SET p_thong_bao = 'Lỗi: Mật khẩu phải có ít nhất 6 ký tự';

    ELSE
        -- Thêm user mới với role_id = 3 (member)
        INSERT INTO users (username, email, password, full_name, role_id, is_active, created_at)
        VALUES (p_username, p_email, p_password, p_full_name, 3, 1, NOW());

        SET p_user_id   = LAST_INSERT_ID();
        SET p_thong_bao = 'Đăng ký thành công';
    END IF;
END$$