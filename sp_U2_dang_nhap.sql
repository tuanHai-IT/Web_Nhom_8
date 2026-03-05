DROP PROCEDURE IF EXISTS sp_U2_dang_nhap$$
CREATE PROCEDURE sp_U2_dang_nhap(
    IN  p_username  VARCHAR(50),
    IN  p_password  VARCHAR(255),
    OUT p_user_id   INT,
    OUT p_role_id   INT,
    OUT p_full_name VARCHAR(100),
    OUT p_thong_bao VARCHAR(255)
)
BEGIN
    DECLARE v_uid    INT;
    DECLARE v_role   INT;
    DECLARE v_active TINYINT;
    DECLARE v_pass   VARCHAR(255);
    DECLARE v_name   VARCHAR(100);

    -- Lấy thông tin user từ username
    SELECT user_id, role_id, is_active, password, full_name
    INTO   v_uid, v_role, v_active, v_pass, v_name
    FROM   users WHERE username = p_username LIMIT 1;

    IF v_uid IS NULL THEN
        SET p_user_id = 0; SET p_role_id = 0; SET p_full_name = '';
        SET p_thong_bao = 'Lỗi: Tài khoản không tồn tại';

    ELSEIF v_active = 0 THEN
        SET p_user_id = 0; SET p_role_id = 0; SET p_full_name = '';
        SET p_thong_bao = 'Lỗi: Tài khoản đã bị khóa';

    ELSEIF v_pass != p_password THEN
        SET p_user_id = 0; SET p_role_id = 0; SET p_full_name = '';
        SET p_thong_bao = 'Lỗi: Mật khẩu không đúng';

    ELSE
        -- Cập nhật last_login
        UPDATE users SET last_login = NOW() WHERE user_id = v_uid;

        -- Ghi log đăng nhập
        INSERT INTO activity_logs (user_id, action, entity_type, entity_id, details, created_at)
        VALUES (v_uid, 'login', 'user', v_uid,
                JSON_OBJECT('username', p_username), NOW());

        SET p_user_id   = v_uid;
        SET p_role_id   = v_role;
        SET p_full_name = v_name;
        SET p_thong_bao = 'Đăng nhập thành công';
    END IF;
END$$