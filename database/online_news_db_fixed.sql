-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th3 22, 2026 lúc 11:13 AM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `online_news_db`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `activity_logs`
--

CREATE TABLE `activity_logs` (
  `log_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `action` varchar(50) DEFAULT NULL COMMENT 'create - update - delete - login',
  `entity_type` varchar(50) DEFAULT NULL COMMENT 'article - category - user',
  `entity_id` int(11) DEFAULT NULL COMMENT 'ID của đối tượng',
  `details` text DEFAULT NULL COMMENT 'JSON chi tiết thay đổi',
  `ip_address` varchar(45) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `activity_logs`
--

INSERT INTO `activity_logs` (`log_id`, `user_id`, `action`, `entity_type`, `entity_id`, `details`, `ip_address`, `created_at`) VALUES
(1, 1, 'login.success', NULL, NULL, 'User admin logged in', '::1', '2026-03-13 17:54:31'),
(2, 1, 'login.success', NULL, NULL, 'User admin logged in', '::1', '2026-03-13 19:15:08'),
(3, 1, 'article.update', NULL, NULL, 'Updated article #41: Đánh Giá Elden Ring: Shadow of the Erdtree – Kiệt Tác Mở Rộng Hoàn Hảo Cho Huyền Thoại Souls-like', '::1', '2026-03-13 19:17:25'),
(4, 1, 'article.update', NULL, NULL, 'Updated article #45: Hướng Dẫn Đánh Tất Cả Boss Trong Hollow Knight – Chiến Thuật Chi Tiết Từ A Đến Z', '::1', '2026-03-13 19:18:36'),
(5, 1, 'article.update', NULL, NULL, 'Updated article #45: Hướng Dẫn Đánh Tất Cả Boss Trong Hollow Knight – Chiến Thuật Chi Tiết Từ A Đến Z', '::1', '2026-03-13 19:19:24'),
(6, 1, 'article.update', NULL, NULL, 'Updated article #43: Top Card Đồ Họa Gaming Giá Rẻ Đáng Mua Nhất 2025 – Hướng Dẫn Mua Sắm Chi Tiết', '::1', '2026-03-13 19:19:49'),
(7, 1, 'article.update', NULL, NULL, 'Updated article #42: GTA VI Chính Thức Xác Nhận Ngày Ra Mắt – Tất Tần Tật Những Gì Chúng Ta Biết', '::1', '2026-03-13 19:20:37'),
(8, 1, 'article.update', NULL, NULL, 'Updated article #44: Black Myth: Wukong Tung Bản Cập Nhật Khổng Lồ – New Game+, Photo Mode Và Nhiều Hơn Nữa', '::1', '2026-03-13 19:21:36'),
(9, 1, 'article.create', NULL, NULL, 'Created article #46: Resident Evil Requiem Review – Sự Trở Lại Đầy Ám Ảnh Của Dòng Game Kinh Dị Huyền Thoại', '::1', '2026-03-13 19:29:02'),
(10, 1, 'article.update', NULL, NULL, 'Updated article #44: Black Myth: Wukong Tung Bản Cập Nhật Khổng Lồ – New Game+, Photo Mode Và Nhiều Hơn Nữa', '::1', '2026-03-13 19:31:11'),
(11, 12, 'login.success', NULL, NULL, 'User phuc123 logged in', '::1', '2026-03-14 06:47:54'),
(12, 12, 'comment.create', NULL, NULL, 'Comment #37 on article #46', '::1', '2026-03-14 06:48:20'),
(13, 1, 'login.success', NULL, NULL, 'User admin logged in', '::1', '2026-03-14 07:06:49'),
(14, 1, 'login.success', NULL, NULL, 'User admin logged in', '::1', '2026-03-14 15:13:44'),
(15, 1, 'game.upload.success', NULL, NULL, 'Uploaded: public/images/uploads/games/game_69b590389a4ad_1773506616.webp', '::1', '2026-03-14 16:43:36'),
(16, 1, 'game.upcoming.update', NULL, NULL, 'Updated upcoming game #4: The Witcher 4', '::1', '2026-03-14 16:43:36'),
(17, 1, 'game.upload.success', NULL, NULL, 'Uploaded: public/images/uploads/games/game_69b5908a1b3c1_1773506698.webp', '::1', '2026-03-14 16:44:58'),
(18, 1, 'game.upcoming.update', NULL, NULL, 'Updated upcoming game #1: Grand Theft Auto VI', '::1', '2026-03-14 16:44:58'),
(19, 1, 'game.upcoming.update', NULL, NULL, 'Updated upcoming game #1: Grand Theft Auto VI', '::1', '2026-03-14 16:45:19'),
(20, 1, 'game.upcoming.update', NULL, NULL, 'Updated upcoming game #4: The Witcher 4', '::1', '2026-03-14 16:51:06'),
(21, 1, 'game.upcoming.update', NULL, NULL, 'Updated upcoming game #3: Fable', '::1', '2026-03-14 16:51:38'),
(22, 1, 'game.upload.success', NULL, NULL, 'Uploaded: public/images/uploads/games/game_69b5947e3afe5_1773507710.jpg', '::1', '2026-03-14 17:01:50'),
(23, 1, 'game.upcoming.update', NULL, NULL, 'Updated upcoming game #4: The Witcher 4', '::1', '2026-03-14 17:01:50'),
(24, 1, 'login.success', NULL, NULL, 'User admin logged in', '::1', '2026-03-14 17:08:08'),
(25, 1, 'game.upload.success', NULL, NULL, 'Uploaded: public/images/uploads/games/game_69b599f1cc959_1773509105.webp', '::1', '2026-03-14 17:25:05'),
(26, 1, 'game.upcoming.update', NULL, NULL, 'Updated upcoming game #4: The Witcher 4', '::1', '2026-03-14 17:25:05'),
(27, 1, 'game.upload.success', NULL, NULL, 'Uploaded: public/images/uploads/games/game_69b59a0d2a4e8_1773509133.jpg', '::1', '2026-03-14 17:25:33'),
(28, 1, 'game.upcoming.update', NULL, NULL, 'Updated upcoming game #6: Marvel&#039;s Wolverine', '::1', '2026-03-14 17:25:33'),
(29, 1, 'game.upload.success', NULL, NULL, 'Uploaded: public/images/uploads/games/game_69b59a239328e_1773509155.png', '::1', '2026-03-14 17:25:55'),
(30, 1, 'game.upcoming.update', NULL, NULL, 'Updated upcoming game #8: Monster Hunter Wilds', '::1', '2026-03-14 17:25:55'),
(31, 1, 'game.upload.success', NULL, NULL, 'Uploaded: public/images/uploads/games/game_69b59a3da5490_1773509181.webp', '::1', '2026-03-14 17:26:21'),
(32, 1, 'game.upcoming.update', NULL, NULL, 'Updated upcoming game #2: Hades II', '::1', '2026-03-14 17:26:21'),
(33, 1, 'game.upload.success', NULL, NULL, 'Uploaded: public/images/uploads/games/game_69b59a52bd021_1773509202.jpg', '::1', '2026-03-14 17:26:42'),
(34, 1, 'game.upcoming.update', NULL, NULL, 'Updated upcoming game #3: Fable', '::1', '2026-03-14 17:26:42'),
(35, 1, 'game.upload.success', NULL, NULL, 'Uploaded: public/images/uploads/games/game_69b59a6b0c368_1773509227.webp', '::1', '2026-03-14 17:27:07'),
(36, 1, 'game.upcoming.update', NULL, NULL, 'Updated upcoming game #7: Death Stranding 2: On the Beach', '::1', '2026-03-14 17:27:07'),
(37, 1, 'game.upload.success', NULL, NULL, 'Uploaded: public/images/uploads/games/game_69b59a8c33486_1773509260.jpeg', '::1', '2026-03-14 17:27:40'),
(38, 1, 'game.upcoming.update', NULL, NULL, 'Updated upcoming game #5: Black Myth: Wukong – Expansion', '::1', '2026-03-14 17:27:40'),
(39, 1, 'game.upload.success', NULL, NULL, 'Uploaded: public/images/uploads/games/game_69b59aa526fe9_1773509285.webp', '::1', '2026-03-14 17:28:05'),
(40, 1, 'game.upcoming.update', NULL, NULL, 'Updated upcoming game #1: Grand Theft Auto VI', '::1', '2026-03-14 17:28:05'),
(41, 1, 'game.upcoming.update', NULL, NULL, 'Updated upcoming game #7: Death Stranding 2: On the Beach', '::1', '2026-03-14 17:28:44'),
(42, 1, 'game.upcoming.update', NULL, NULL, 'Updated upcoming game #2: Hades II', '::1', '2026-03-14 17:28:51'),
(43, 1, 'game.upload.success', NULL, NULL, 'Uploaded: public/images/uploads/games/game_69b59b07620e7_1773509383.webp', '::1', '2026-03-14 17:29:43'),
(44, 1, 'game.upcoming.update', NULL, NULL, 'Updated upcoming game #1: Grand Theft Auto VI', '::1', '2026-03-14 17:29:43'),
(45, 1, 'game.upload.success', NULL, NULL, 'Uploaded: public/images/uploads/games/game_69b59b372da59_1773509431.png', '::1', '2026-03-14 17:30:31'),
(46, 1, 'game.upcoming.update', NULL, NULL, 'Updated upcoming game #1: Grand Theft Auto VI', '::1', '2026-03-14 17:30:31'),
(47, 1, 'game.upload.success', NULL, NULL, 'Uploaded: public/images/uploads/games/game_69b59be3b961e_1773509603.jpg', '::1', '2026-03-14 17:33:23'),
(48, 1, 'game.upcoming.update', NULL, NULL, 'Updated upcoming game #4: The Witcher 4', '::1', '2026-03-14 17:33:23'),
(49, 1, 'game.upcoming.update', NULL, NULL, 'Updated upcoming game #4: The Witcher 4', '::1', '2026-03-14 17:33:43'),
(50, 1, 'game.upcoming.update', NULL, NULL, 'Updated upcoming game #3: Fable', '::1', '2026-03-14 17:33:49'),
(51, 1, 'article.update', NULL, NULL, 'Updated article #42: GTA VI Chính Thức Xác Nhận Ngày Ra Mắt – Tất Tần Tật Những Gì Chúng Ta Biết', '::1', '2026-03-14 17:35:10'),
(52, 1, 'article.update', NULL, NULL, 'Updated article #1: GTA VI chính thức xác nhận ngày ra mắt: 26 tháng 5 năm 2026', '::1', '2026-03-14 17:35:48'),
(53, 1, 'article.update', NULL, NULL, 'Updated article #45: Hướng Dẫn Đánh Tất Cả Boss Trong Hollow Knight – Chiến Thuật Chi Tiết Từ A Đến Z', '::1', '2026-03-14 17:37:23'),
(54, 1, 'article.update', NULL, NULL, 'Updated article #45: Hướng Dẫn Đánh Tất Cả Boss Trong Hollow Knight – Chiến Thuật Chi Tiết Từ A Đến Z', '::1', '2026-03-14 19:00:10'),
(55, 1, 'article.update', NULL, NULL, 'Updated article #17: Fortnite Chapter 6 – Map mới và collab Marvel Spider-Man', '::1', '2026-03-14 19:01:33'),
(56, 1, 'article.update', NULL, NULL, 'Updated article #45: Hướng Dẫn Đánh Tất Cả Boss Trong Hollow Knight – Chiến Thuật Chi Tiết Từ A Đến Z', '::1', '2026-03-14 19:02:05'),
(57, 1, 'article.update', NULL, NULL, 'Updated article #11: Liên Quân Mobile – Tướng mới Keera siêu cơ động ra mắt', '::1', '2026-03-14 19:02:16'),
(58, 12, 'login.success', NULL, NULL, 'User phuc123 logged in', '::1', '2026-03-15 05:46:15'),
(59, 12, 'comment.create', NULL, NULL, 'Comment #38 on article #44', '::1', '2026-03-15 05:46:36'),
(60, 12, 'login.success', NULL, NULL, 'User phuc123 logged in', '::1', '2026-03-15 08:41:51'),
(61, 12, 'comment.create', NULL, NULL, 'Comment #39 on article #42', '::1', '2026-03-15 08:43:04'),
(62, 12, 'logout', NULL, NULL, 'User logged out', '::1', '2026-03-15 08:43:29'),
(63, 1, 'login.success', NULL, NULL, 'User admin logged in', '::1', '2026-03-15 08:43:39'),
(64, 1, 'logout', NULL, NULL, 'User logged out', '::1', '2026-03-15 09:00:47'),
(65, 1, 'login.success', NULL, NULL, 'User admin logged in', '::1', '2026-03-15 16:54:42'),
(66, 1, 'article.update', NULL, NULL, 'Updated article #46: Resident Evil Requiem Review – Sự Trở Lại Đầy Ám Ảnh Của Dòng Game Kinh Dị Huyền Thoại', '::1', '2026-03-15 17:02:12'),
(67, 1, 'game.upcoming.update', NULL, NULL, 'Updated upcoming game #6: Marvel&amp;#039;s Wolverine', '::1', '2026-03-15 17:05:02'),
(68, 1, 'game.upcoming.update', NULL, NULL, 'Updated upcoming game #4: The Witcher 4', '::1', '2026-03-15 17:05:07'),
(69, 1, 'article.update', NULL, NULL, 'Updated article #10: The Witcher 4 – Trailer đầu tiên xác nhận Ciri là nhân vật chính', '::1', '2026-03-15 17:26:33'),
(70, 1, 'article.update', NULL, NULL, 'Updated article #10: The Witcher 4 – Trailer đầu tiên xác nhận Ciri là nhân vật chính', '::1', '2026-03-15 17:33:20'),
(71, 1, 'article.update', NULL, NULL, 'Updated article #2: Nintendo Switch 2 – Tất cả thông tin chính thức trước ngày ra mắt', '::1', '2026-03-15 17:35:34'),
(72, 1, 'article.update', NULL, NULL, 'Updated article #17: Fortnite Chapter 6 – Map mới và collab Marvel Spider-Man', '::1', '2026-03-15 17:38:23'),
(73, 1, 'article.update', NULL, NULL, 'Updated article #5: Elden Ring DLC Shadow of the Erdtree – 6 tháng nhìn lại', '::1', '2026-03-15 17:39:51'),
(74, 1, 'article.update', NULL, NULL, 'Updated article #9: Baldur&amp;#039;s Gate 3 Patch 8 – Thêm 12 subclass mới và New Game+', '::1', '2026-03-15 17:41:46'),
(75, 1, 'article.update', NULL, NULL, 'Updated article #3: Liên Minh Huyền Thoại mùa 2025 – Riot Games công bố những thay đổi lớn', '::1', '2026-03-15 17:42:55'),
(76, 1, 'logout', NULL, NULL, 'User logged out', '::1', '2026-03-15 17:57:12'),
(77, 1, 'login.success', NULL, NULL, 'User admin logged in', '::1', '2026-03-15 17:58:32'),
(78, 1, 'logout', NULL, NULL, 'User logged out', '::1', '2026-03-15 17:58:40'),
(79, 13, 'login.success', NULL, NULL, 'User phuc1234 logged in', '::1', '2026-03-15 18:16:25'),
(80, 13, 'logout', NULL, NULL, 'User logged out', '::1', '2026-03-15 19:18:39'),
(81, 13, 'login.success', NULL, NULL, 'User phuc1234 logged in', '::1', '2026-03-18 16:31:18'),
(82, 13, 'logout', NULL, NULL, 'User logged out', '::1', '2026-03-18 16:41:42'),
(83, 1, 'login.success', NULL, NULL, 'User admin logged in', '::1', '2026-03-18 17:09:05'),
(84, 12, 'login.success', NULL, NULL, 'User phuc123 logged in', '::1', '2026-03-19 14:56:33'),
(85, 12, 'profile.update', NULL, NULL, 'User #12 updated profile', '::1', '2026-03-19 14:57:17'),
(86, 12, 'history.error', NULL, NULL, 'SQLSTATE[42S02]: Base table or view not found: 1146 Table \'online_news_db.read_history\' doesn\'t exist', '::1', '2026-03-19 16:06:24'),
(87, 12, 'history.error', NULL, NULL, 'SQLSTATE[42S02]: Base table or view not found: 1146 Table \'online_news_db.read_history\' doesn\'t exist', '::1', '2026-03-19 16:06:38'),
(88, 12, 'profile.update', NULL, NULL, 'User #12 updated profile', '::1', '2026-03-19 16:09:30'),
(89, 12, 'logout', NULL, NULL, 'User logged out', '::1', '2026-03-19 16:09:34'),
(90, 12, 'login.success', NULL, NULL, 'User phuc123 logged in', '::1', '2026-03-19 16:09:42');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `articles`
--

CREATE TABLE `articles` (
  `article_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL COMMENT 'SEO friendly URL',
  `summary` text DEFAULT NULL COMMENT 'Tóm tắt ngắn 200 ký tự',
  `content` longtext DEFAULT NULL COMMENT 'Nội dung HTML đầy đủ',
  `thumbnail` varchar(255) DEFAULT NULL COMMENT 'Ảnh đại diện',
  `meta_title` varchar(255) DEFAULT NULL COMMENT 'SEO title',
  `meta_description` text DEFAULT NULL COMMENT 'SEO description',
  `category_id` int(11) NOT NULL,
  `author_id` int(11) NOT NULL,
  `view_count` int(11) DEFAULT 0,
  `status` enum('draft','published','archived') DEFAULT 'draft',
  `is_featured` tinyint(4) DEFAULT 0 COMMENT 'Tin nổi bật',
  `is_breaking` tinyint(4) DEFAULT 0 COMMENT 'Tin nóng',
  `published_at` timestamp NULL DEFAULT NULL COMMENT 'Ngày xuất bản',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `articles`
--

INSERT INTO `articles` (`article_id`, `title`, `slug`, `summary`, `content`, `thumbnail`, `meta_title`, `meta_description`, `category_id`, `author_id`, `view_count`, `status`, `is_featured`, `is_breaking`, `published_at`, `created_at`, `updated_at`) VALUES
(1, 'GTA VI chính thức xác nhận ngày ra mắt: 26 tháng 5 năm 2026', 'gta-vi-ngay-ra-mat-2026', 'Rockstar Games xác nhận GTA VI ra mắt ngày 26/5/2026 trên PS5 và Xbox Series X/S với nhân vật nữ chính đầu tiên trong series.', '<h2>GTA VI – Bom tấn 2026</h2>\r\n<p>Sau nhiều năm chờ đợi, Rockstar Games chính thức xác nhận <strong>GTA VI sẽ ra mắt ngày 26/5/2026</strong> trên PS5 và Xbox Series X/S.</p>\r\n<p>Nhân vật chính Lucia trở thành nữ nhân vật đầu tiên trong series GTA chính. Cô cùng đồng phạm Jason hoạt động ở Leonida – phiên bản hư cấu của bang Florida.</p>\r\n<h3>Điểm nổi bật:</h3>\r\n<ul>\r\n  <li>Bản đồ rộng gấp đôi GTA V</li>\r\n  <li>Đồ họa Unreal Engine 5 thế hệ mới</li>\r\n  <li>AI NPC hoạt động thực tế hơn bao giờ hết</li>\r\n  <li>GTA Online 2 ra mắt sau 6 tháng</li>\r\n</ul>\r\n<p>Phiên bản PC chưa có ngày ra mắt chính thức nhưng dự kiến sau 6–12 tháng.</p>', 'http://localhost/gamenews/public/images/uploads/img_69b406da14a53_1773405914.jpg', 'GTA VI ngày ra mắt chính thức 26/5/2026', 'Rockstar xác nhận GTA VI ra mắt 26/5/2026 trên PS5 và Xbox Series X/S.', 3, 2, 125864, 'published', 0, 1, '2026-01-14 18:00:00', '2026-03-11 06:31:39', '2026-03-15 17:07:47'),
(2, 'Nintendo Switch 2 – Tất cả thông tin chính thức trước ngày ra mắt', 'nintendo-switch-2-thong-tin-chinh-thuc', 'Nintendo xác nhận Switch 2 với màn hình lớn hơn, Joy-Con nam châm mới và khả năng chơi 4K khi dock.', '<h2>Nintendo Switch 2 – Những thông tin quan trọng trước ngày ra mắt</h2>\r\n\r\n<p>Sau thành công vang dội của thế hệ Nintendo Switch đầu tiên, Nintendo cuối cùng cũng đã công bố những thông tin chính thức đầu tiên về <strong>Nintendo Switch 2</strong>. Đây được xem là bản nâng cấp lớn nhất của dòng máy console lai (hybrid console) với nhiều cải tiến về hiệu năng, màn hình và trải nghiệm chơi game.</p>\r\n\r\n<p>Dù Nintendo vẫn chưa tiết lộ toàn bộ chi tiết phần cứng, nhiều thông tin từ trailer, tài liệu phát triển và các nguồn rò rỉ đã cho thấy Switch 2 sẽ mang đến bước tiến đáng kể so với thế hệ trước.</p>\r\n\r\n<h2>Màn hình lớn hơn và thiết kế cải tiến</h2>\r\n\r\n<p>Một trong những thay đổi dễ nhận thấy nhất trên Switch 2 là màn hình lớn hơn với viền mỏng hơn đáng kể. Theo các thông tin được công bố, máy có thể được trang bị màn hình khoảng <strong>8 inch</strong>, giúp trải nghiệm chơi game ở chế độ cầm tay trở nên sống động hơn.</p>\r\n\r\n<p>Nintendo vẫn giữ thiết kế hybrid đặc trưng, cho phép người chơi chuyển đổi linh hoạt giữa ba chế độ:</p>\r\n\r\n<ul>\r\n<li>Chơi cầm tay (Handheld Mode)</li>\r\n<li>Chơi trên bàn với chân đế (Tabletop Mode)</li>\r\n<li>Kết nối TV thông qua dock (Docked Mode)</li>\r\n</ul>\r\n\r\n<h2>Joy-Con thế hệ mới</h2>\r\n\r\n<p>Switch 2 được cho là sẽ sử dụng phiên bản <strong>Joy-Con mới</strong> với cơ chế kết nối nam châm thay vì thanh trượt truyền thống. Thiết kế này giúp việc gắn và tháo tay cầm trở nên nhanh hơn và chắc chắn hơn.</p>\r\n\r\n<p>Ngoài ra, Nintendo cũng được kỳ vọng sẽ cải thiện vấn đề <em>Joy-Con Drift</em> – lỗi từng gây nhiều tranh cãi trên thế hệ Switch đầu tiên.</p>\r\n\r\n<h2>Hiệu năng mạnh hơn đáng kể</h2>\r\n\r\n<p>Một nâng cấp quan trọng khác của Switch 2 là phần cứng mạnh hơn. Nhiều nguồn tin cho rằng Nintendo đang hợp tác với NVIDIA để trang bị chipset mới dựa trên kiến trúc hiện đại, giúp máy có thể xử lý các tựa game phức tạp hơn.</p>\r\n\r\n<p>Những cải tiến về hiệu năng có thể bao gồm:</p>\r\n\r\n<ul>\r\n<li>Hỗ trợ độ phân giải <strong>4K khi chơi ở chế độ dock</strong></li>\r\n<li>1080p khi chơi ở chế độ cầm tay</li>\r\n<li>Tốc độ khung hình ổn định hơn</li>\r\n<li>Hỗ trợ công nghệ upscaling tương tự DLSS</li>\r\n</ul>\r\n\r\n<h2>Tương thích với game Switch đời đầu</h2>\r\n\r\n<p>Một tin vui cho người dùng Nintendo là Switch 2 được cho là vẫn <strong>tương thích với thư viện game của Nintendo Switch</strong>. Điều này có nghĩa là người chơi có thể tiếp tục trải nghiệm những tựa game nổi tiếng như:</p>\r\n\r\n<ul>\r\n<li>The Legend of Zelda: Tears of the Kingdom</li>\r\n<li>Super Mario Odyssey</li>\r\n<li>Mario Kart 8 Deluxe</li>\r\n<li>Animal Crossing: New Horizons</li>\r\n</ul>\r\n\r\n<p>Khả năng tương thích ngược giúp hệ máy mới giữ được cộng đồng người chơi đông đảo ngay từ khi ra mắt.</p>\r\n\r\n<h2>Giá bán và thời điểm ra mắt</h2>\r\n\r\n<p>Nintendo hiện vẫn chưa công bố chính thức ngày phát hành của Switch 2. Tuy nhiên nhiều nguồn tin trong ngành cho rằng máy có thể ra mắt trong khoảng <strong>2025 – 2026</strong>.</p>\r\n\r\n<p>Mức giá dự kiến của hệ máy này rơi vào khoảng <strong>399 – 449 USD</strong>, cao hơn một chút so với Nintendo Switch đời đầu nhưng vẫn cạnh tranh so với các hệ máy console hiện nay.</p>\r\n\r\n<h2>Kỳ vọng của cộng đồng game thủ</h2>\r\n\r\n<p>Sau hơn 7 năm kể từ khi Nintendo Switch ra mắt, cộng đồng game thủ đang rất mong chờ thế hệ tiếp theo của hệ máy này. Với những cải tiến về phần cứng, thiết kế và hiệu năng, Switch 2 được kỳ vọng sẽ tiếp tục duy trì thành công của dòng console lai độc đáo mà Nintendo đã xây dựng.</p>\r\n\r\n<p>Nếu những thông tin hiện tại là chính xác, Nintendo Switch 2 có thể trở thành một trong những hệ máy đáng chú ý nhất của ngành công nghiệp game trong vài năm tới.</p>', 'http://localhost/gamenews/public/images/uploads/img_69b3cfe0a081f_1773391840.jpg', 'Nintendo Switch 2 thông tin chính thức', 'Tất cả thông tin về Nintendo Switch 2 trước ngày ra mắt.', 4, 4, 92152, 'published', 1, 1, '2025-06-30 19:00:00', '2026-03-11 06:31:39', '2026-03-15 17:36:30'),
(3, 'Liên Minh Huyền Thoại mùa 2025 – Riot Games công bố những thay đổi lớn', 'lmht-mua-2025-thay-doi-lon', 'Riot Games công bố toàn bộ thay đổi lớn LMHT mùa 2025: map mới, cơ chế drake mới, hệ thống rank cải tiến.', '<h2>LMHT Mùa 2025 – Revolution</h2>\r\n\r\n<p>Riot Games đã công bố mùa giải 2025 của Liên Minh Huyền Thoại với tên gọi <strong>Revolution</strong>. Đây được xem là một trong những bản cập nhật lớn nhất trong lịch sử của trò chơi kể từ khi ra mắt vào năm 2009.</p>\r\n\r\n<p>Bản cập nhật này mang đến hàng loạt thay đổi quan trọng cho Summoner’s Rift, hệ thống xếp hạng cũng như nhiều cơ chế gameplay mới. Riot cho biết mục tiêu của mùa giải mới là làm mới trải nghiệm thi đấu và tạo thêm nhiều chiến thuật cho người chơi.</p>\r\n\r\n<h2>Những thay đổi lớn trong bản cập nhật</h2>\r\n\r\n<ul>\r\n  <li><strong>Map Summoner’s Rift:</strong> Một khu vực mới được thêm vào gần hang rồng, tạo thêm điểm giao tranh quan trọng ở giai đoạn giữa trận.</li>\r\n  <li><strong>Void Drake:</strong> Loại rồng hoàn toàn mới với hiệu ứng buff đặc biệt dành cho đội tiêu diệt.</li>\r\n  <li><strong>Rank Emerald:</strong> Riot bổ sung bậc xếp hạng Emerald nằm giữa Platinum và Diamond nhằm cân bằng hệ thống rank.</li>\r\n  <li><strong>Objective Atakhan:</strong> Một boss trung lập mới xuất hiện ở giữa trận, mang lại phần thưởng lớn cho đội kiểm soát được khu vực.</li>\r\n</ul>\r\n\r\n<h2>Summoner’s Rift được thay đổi đáng kể</h2>\r\n\r\n<p>Summoner’s Rift vẫn là bản đồ chính của Liên Minh Huyền Thoại, nhưng mùa 2025 mang đến nhiều thay đổi nhằm làm mới meta. Các khu vực rừng được điều chỉnh lại, một số địa hình mới được thêm vào để tạo ra nhiều góc giao tranh và phục kích.</p>\r\n\r\n<p>Những thay đổi này được kỳ vọng sẽ khiến các trận đấu trở nên đa dạng hơn và buộc người chơi phải thích nghi với nhiều chiến thuật khác nhau.</p>\r\n\r\n<h2>Mùa giải mới hứa hẹn nhiều thay đổi meta</h2>\r\n\r\n<p>Với sự xuất hiện của các objective mới như Void Drake và Atakhan, meta của Liên Minh Huyền Thoại có thể sẽ thay đổi mạnh trong thời gian tới. Các đội tuyển và người chơi xếp hạng sẽ cần tìm ra những chiến thuật mới để tận dụng tối đa các lợi thế từ những mục tiêu này.</p>\r\n\r\n<p>Mùa giải 2025 được Riot kỳ vọng sẽ mang lại làn gió mới cho cộng đồng Liên Minh Huyền Thoại và tiếp tục giữ vị trí là một trong những tựa game esports lớn nhất thế giới.</p>', 'http://localhost/gamenews/public/images/uploads/img_69b3cfb5330f2_1773391797.jpg', 'LMHT mùa 2025 thay đổi lớn nhất lịch sử', 'Riot Games công bố toàn bộ thay đổi lớn LMHT mùa 2025.', 3, 3, 98754, 'published', 1, 1, '2025-11-14 18:00:00', '2026-03-11 06:31:39', '2026-03-17 18:36:16'),
(4, 'Valorant Episode 10 – Agent mới Tejo và map Abyss', 'valorant-episode-10-tejo-abyss', 'Riot Games ra mắt Valorant Episode 10 với Tejo – Initiator người Colombia – và map Abyss hoàn toàn mới không có rào cản.', '<h2>Valorant Episode 10 – Đầu năm mới nhiều bất ngờ</h2>\r\n<p>Episode 10 mang đến Agent thứ 26 tên <strong>Tejo</strong> – một Initiator với gadget công nghệ cao từ Colombia.</p>\r\n<h3>Kỹ năng của Tejo:</h3>\r\n<ul>\r\n  <li><strong>Stealth Drone (Q):</strong> Drone trinh sát tàng hình</li>\r\n  <li><strong>Guided Salvo (E):</strong> Phóng tên lửa điều khiển</li>\r\n  <li><strong>Ultimate – Armageddon:</strong> Gọi không kích diện rộng</li>\r\n</ul>\r\n<p>Map Abyss đặc biệt ở chỗ hoàn toàn không có tường bao quanh – rơi xuống biên là chết ngay.</p>', 'http://localhost/gamenews/public/images/uploads/img_69b3d13e33e10_1773392190.webp', 'Valorant Episode 10 Agent Tejo và map Abyss', 'Valorant Episode 10 ra mắt Agent Tejo và map Abyss.', 3, 3, 75320, 'published', 1, 0, '2025-10-21 20:00:00', '2026-03-11 06:31:39', '2026-03-13 01:56:30'),
(5, 'Elden Ring DLC Shadow of the Erdtree – 6 tháng nhìn lại', 'elden-ring-dlc-shadow-6-thang', 'DLC lớn nhất lịch sử FromSoftware đã ra mắt 6 tháng với hơn 10 triệu bản bán ra. Cộng đồng nói gì?', '<h2>Shadow of the Erdtree – Nửa năm nhìn lại</h2>\r\n\r\n<p>Sau 6 tháng kể từ ngày ra mắt, DLC <strong>Shadow of the Erdtree</strong> của Elden Ring vẫn là một trong những bản mở rộng được cộng đồng game thủ nhắc đến nhiều nhất. Đây là DLC lớn nhất mà FromSoftware từng phát hành, mang đến một khu vực hoàn toàn mới cùng nhiều boss và cốt truyện bổ sung cho thế giới của Elden Ring.</p>\r\n\r\n<p>Ngay từ khi ra mắt, DLC đã thu hút lượng người chơi khổng lồ và nhanh chóng trở thành một trong những bản mở rộng thành công nhất trong lịch sử game Souls-like.</p>\r\n\r\n<h2>Thành công ấn tượng của DLC</h2>\r\n\r\n<ul>\r\n<li>Hơn 10 triệu bản DLC được bán ra chỉ trong thời gian ngắn sau khi phát hành</li>\r\n<li>DLC lớn nhất từng được FromSoftware phát triển</li>\r\n<li>Điểm đánh giá trung bình trên Metacritic đạt khoảng 94/100</li>\r\n<li>Hàng trăm nghìn người xem trên Twitch trong tuần đầu ra mắt</li>\r\n</ul>\r\n\r\n<p>Thành công này cho thấy sức hút mạnh mẽ của thương hiệu Elden Ring cũng như niềm tin của cộng đồng dành cho FromSoftware.</p>\r\n\r\n<h2>Thế giới mới rộng lớn và nhiều bí ẩn</h2>\r\n\r\n<p>Shadow of the Erdtree đưa người chơi đến một khu vực hoàn toàn mới mang tên <strong>Land of Shadow</strong>. Khu vực này có thiết kế map phức tạp với nhiều tầng lớp địa hình, các dungeon ẩn và vô số bí mật chờ người chơi khám phá.</p>\r\n\r\n<p>Phong cách thiết kế môi trường vẫn giữ được đặc trưng của FromSoftware: u tối, bí ẩn và đầy thử thách. Người chơi phải liên tục khám phá, chiến đấu và tìm hiểu lore để hiểu rõ hơn về thế giới của Elden Ring.</p>\r\n\r\n<h2>Messmer the Impaler – Boss được yêu thích nhất</h2>\r\n\r\n<p>Một trong những nhân vật nổi bật nhất của DLC là <strong>Messmer the Impaler</strong>. Boss này nhanh chóng trở thành biểu tượng của Shadow of the Erdtree nhờ thiết kế ấn tượng, cốt truyện bí ẩn và độ khó cao.</p>\r\n\r\n<p>Nhiều người chơi đánh giá Messmer là một trong những trận boss hay nhất trong toàn bộ Elden Ring. Các đòn tấn công nhanh, combo phức tạp và hiệu ứng lửa đặc trưng khiến trận chiến trở nên cực kỳ căng thẳng.</p>\r\n\r\n<h2>Cộng đồng Elden Ring nói gì sau 6 tháng?</h2>\r\n\r\n<p>Sau nửa năm ra mắt, cộng đồng game thủ vẫn đánh giá Shadow of the Erdtree là một DLC xuất sắc. Nhiều người cho rằng bản mở rộng này thậm chí còn mang lại trải nghiệm thử thách và đáng nhớ hơn cả phần game gốc.</p>\r\n\r\n<p>Dù độ khó của DLC khiến nhiều người chơi gặp khó khăn, nhưng chính điều đó lại tạo nên sức hấp dẫn đặc trưng của dòng game Souls-like do FromSoftware phát triển.</p>', 'http://localhost/gamenews/public/images/uploads/img_69b3ce83841d4_1773391491.webp', 'Elden Ring DLC Shadow of the Erdtree 6 tháng', 'Nhìn lại DLC Shadow of the Erdtree sau 6 tháng ra mắt.', 3, 2, 89326, 'published', 1, 0, '2025-12-09 20:00:00', '2026-03-11 06:31:39', '2026-03-15 17:39:51'),
(6, 'PUBG Mobile Season 20 – Bản đồ mới Rondo và vũ khí huyền thoại', 'pubg-mobile-season-20-rondo', 'PUBG Mobile Season 20 ra mắt với bản đồ Rondo 8x8km, vũ khí SMG mới PP-19 Bizon và Royal Pass cực hot.', '<h2>PUBG Mobile Season 20 – Rondo Map</h2>\r\n<p>Krafton mang đến bản đồ hoàn toàn mới lấy cảm hứng từ đô thị châu Á hiện đại.</p>\r\n<h3>Điểm mới nổi bật:</h3>\r\n<ul>\r\n  <li>Rondo Map: 8x8km với trung tâm thành phố dày đặc</li>\r\n  <li>PP-19 Bizon: SMG mới với băng đạn 53 viên</li>\r\n  <li>Vehicle mới: Motor Glider phiên bản 2 chỗ</li>\r\n  <li>Royal Pass Season 20: Theme Neon City</li>\r\n</ul>', 'http://localhost/gamenews/public/images/uploads/img_69b3d1c9e5a03_1773392329.webp', 'PUBG Mobile Season 20 bản đồ Rondo', 'PUBG Mobile Season 20 ra mắt với bản đồ Rondo và PP-19 Bizon.', 5, 3, 88941, 'published', 1, 0, '2025-10-14 18:00:00', '2026-03-11 06:31:39', '2026-03-13 01:58:49'),
(7, 'Genshin Impact 5.3 – Hoàn tất arc Natlan với nhân vật mới', 'genshin-53-natlan-hoan-tat', 'HoYoverse phát hành phiên bản 5.3 hoàn tất câu chuyện Natlan với 2 nhân vật 5 sao mới: Citlali và Iansan.', '<h2>Genshin Impact 5.3 – Kết thúc Natlan</h2>\r\n<p>Phiên bản 5.3 đánh dấu cột mốc quan trọng: kết thúc toàn bộ arc Natlan kéo dài hơn 1 năm.</p>\r\n<h3>Nhân vật mới:</h3>\r\n<ul>\r\n  <li><strong>Citlali (5★ Cryo):</strong> Shaman tộc Mictlan, hỗ trợ đặc biệt</li>\r\n  <li><strong>Iansan (5★ Electro):</strong> Nữ chiến binh DPS mạnh nhất patch</li>\r\n</ul>\r\n<h3>Sự kiện đặc biệt:</h3>\r\n<ul>\r\n  <li>Nhân vật 5★ miễn phí dành cho người chơi hoàn thành cốt truyện</li>\r\n  <li>Rerun banner Xilonen và Mualani</li>\r\n</ul>', 'http://localhost/gamenews/public/images/uploads/img_69b3d07a1525a_1773391994.jpg', 'Genshin Impact 5.3 Natlan kết thúc', 'Genshin Impact 5.3 hoàn tất arc Natlan với nhân vật mới Citlali và Iansan.', 5, 4, 71560, 'published', 1, 0, '2025-09-14 18:00:00', '2026-03-11 06:31:39', '2026-03-13 01:53:14'),
(8, 'Minecraft 1.22 Garden Awakens – Pale Garden biome và sinh vật Creaking', 'minecraft-122-garden-awakens-pale', 'Mojang phát hành Minecraft 1.22 với biome Pale Garden rừng trắng huyền bí và sinh vật mới Creaking đáng sợ.', '<h2>Minecraft 1.22 Garden Awakens</h2>\r\n<p>Bản cập nhật Garden Awakens mang đến hai điểm nhấn lớn: biome mới và sinh vật độc đáo chưa từng có trong Minecraft.</p>\r\n<h3>Pale Garden Biome:</h3>\r\n<ul>\r\n  <li>Rừng cây trắng mờ ảo, không có âm thanh mob thông thường</li>\r\n  <li>Block mới: Pale Oak Wood, Pale Moss</li>\r\n  <li>Luôn có sương mù dày đặc</li>\r\n</ul>\r\n<h3>Sinh vật Creaking:</h3>\r\n<ul>\r\n  <li>Chỉ di chuyển khi bạn không nhìn vào nó</li>\r\n  <li>Bất tử nếu còn Creaking Heart trong cây</li>\r\n  <li>Cơ chế đặc biệt nhất từng có trong Minecraft</li>\r\n</ul>', 'http://localhost/gamenews/public/images/uploads/img_69b3d15d136fa_1773392221.webp', 'Minecraft 1.22 Garden Awakens biome Pale Garden', 'Minecraft 1.22 Garden Awakens với Pale Garden và sinh vật Creaking.', 3, 2, 62100, 'published', 0, 0, '2025-09-29 19:00:00', '2026-03-11 06:31:39', '2026-03-13 01:57:01'),
(9, 'Baldur&amp;#039;s Gate 3 Patch 8 – Thêm 12 subclass mới và New Game+', 'bg3-patch-8-subclass-moi', 'Larian Studios phát hành Patch 8 khổng lồ cho BG3 với 12 subclass mới, New Game+ và hàng trăm fix bug.', '<h2>Baldur\'s Gate 3 Patch 8 – Bản cập nhật lớn cuối cùng</h2>\r\n\r\n<p>Larian Studios đã chính thức phát hành <strong>Patch 8</strong> cho Baldur\'s Gate 3, được xem là bản cập nhật nội dung lớn cuối cùng dành cho tựa game RPG đình đám này. Bản patch mang đến hàng loạt nội dung mới bao gồm 12 subclass mới, chế độ New Game+ cùng rất nhiều thay đổi về gameplay và sửa lỗi.</p>\r\n\r\n<p>Dù đã ra mắt từ năm 2023, Baldur\'s Gate 3 vẫn giữ được lượng người chơi ổn định nhờ các bản cập nhật lớn và sự hỗ trợ liên tục từ nhà phát triển.</p>\r\n\r\n<h2>12 Subclass mới cho tất cả các class</h2>\r\n\r\n<p>Điểm nổi bật nhất của Patch 8 là việc bổ sung <strong>12 subclass mới</strong>, giúp người chơi có thêm nhiều lựa chọn xây dựng nhân vật và chiến thuật chiến đấu.</p>\r\n\r\n<ul>\r\n<li>Barbarian – Giant Instinct</li>\r\n<li>Bard – College of Glamour</li>\r\n<li>Cleric – Death Domain</li>\r\n<li>Druid – Circle of Stars</li>\r\n<li>Fighter – Arcane Archer</li>\r\n<li>Monk – Way of the Drunken Master</li>\r\n<li>Paladin – Oath of Conquest</li>\r\n<li>Ranger – Swarmkeeper</li>\r\n<li>Rogue – Swashbuckler</li>\r\n<li>Sorcerer – Shadow Magic</li>\r\n<li>Warlock – Hexblade</li>\r\n<li>Wizard – Bladesinging</li>\r\n</ul>\r\n\r\n<p>Những subclass này mang lại nhiều phong cách chơi hoàn toàn mới, đặc biệt là với những người chơi muốn trải nghiệm lại game theo các hướng build nhân vật khác nhau.</p>\r\n\r\n<h2>Chế độ New Game+</h2>\r\n\r\n<p>Patch 8 cũng giới thiệu chế độ <strong>New Game+</strong>, cho phép người chơi bắt đầu lại cuộc phiêu lưu sau khi hoàn thành game nhưng vẫn giữ lại một số tiến trình từ lần chơi trước.</p>\r\n\r\n<ul>\r\n<li>Giữ lại level và một phần trang bị</li>\r\n<li>Kẻ địch mạnh hơn để tăng độ thử thách</li>\r\n<li>Nhiều lựa chọn build nhân vật mới với subclass bổ sung</li>\r\n</ul>\r\n\r\n<p>Chế độ này giúp người chơi có thêm lý do để quay lại khám phá thế giới của Baldur\'s Gate 3.</p>\r\n\r\n<h2>Nhiều cải tiến và sửa lỗi</h2>\r\n\r\n<p>Ngoài nội dung mới, Patch 8 còn mang đến hàng trăm thay đổi nhỏ nhằm cải thiện trải nghiệm người chơi. Larian Studios đã sửa nhiều lỗi liên quan đến nhiệm vụ, hội thoại, hiệu năng và cân bằng gameplay.</p>\r\n\r\n<p>Những cải tiến này giúp Baldur\'s Gate 3 trở thành một phiên bản hoàn thiện hơn, đồng thời khép lại vòng đời phát triển nội dung chính của trò chơi.</p>', 'http://localhost/gamenews/public/images/uploads/img_69b3cf850af69_1773391749.jpg', 'BG3 Patch 8 12 subclass mới và New Game+', 'Baldur&amp;#039;s Gate 3 Patch 8 thêm 12 subclass và chế độ New Game+.', 3, 4, 54211, 'published', 0, 0, '2025-11-20 00:00:00', '2026-03-11 06:31:39', '2026-03-15 17:41:46'),
(10, 'The Witcher 4 – Trailer đầu tiên xác nhận Ciri là nhân vật chính', 'witcher-4-trailer-ciri-nhan-vat-chinh', 'CD Projekt Red gây sốt tại The Game Awards với trailer The Witcher 4, chính thức xác nhận Ciri thay thế Geralt.', '<h2>The Witcher 4 – Kỷ nguyên mới của Ciri</h2>\r\n\r\n<p>Tại sự kiện <strong>The Game Awards</strong>, CD Projekt Red đã chính thức công bố trailer đầu tiên của <strong>The Witcher 4</strong>, đánh dấu sự trở lại của một trong những series RPG nổi tiếng nhất lịch sử game. Điều khiến cộng đồng game thủ bất ngờ nhất chính là việc <strong>Ciri</strong> được xác nhận sẽ trở thành nhân vật chính của phần game mới, thay thế vai trò trung tâm mà Geralt of Rivia đã đảm nhận trong suốt ba phần trước.</p>\r\n\r\n<p>Đoạn trailer mang đến một cái nhìn đầu tiên về thế giới rộng lớn và đầy bí ẩn của phần game mới. Người chơi có thể thấy Ciri đang thực hiện nhiệm vụ săn quái vật trong một ngôi làng hẻo lánh, nơi người dân đang chuẩn bị thực hiện một nghi lễ hiến tế. Không khí u ám, căng thẳng và đầy chất dark fantasy quen thuộc của series vẫn được giữ nguyên.</p>\r\n\r\n<h2>Ciri – Nhân vật trung tâm của câu chuyện</h2>\r\n\r\n<p>Trong trilogy trước, Ciri là nhân vật cực kỳ quan trọng trong cốt truyện của <em>The Witcher 3: Wild Hunt</em>. Tuy nhiên cô chỉ xuất hiện trong một số phân đoạn gameplay ngắn. Với <strong>The Witcher 4</strong>, CD Projekt Red muốn đưa Ciri trở thành trung tâm của câu chuyện, mở ra một chương hoàn toàn mới cho vũ trụ Witcher.</p>\r\n\r\n<p>Khác với Geralt – một witcher đã trải qua quá trình biến đổi, Ciri sở hữu những năng lực đặc biệt liên quan đến Elder Blood. Điều này có thể giúp gameplay của phần game mới trở nên đa dạng và sáng tạo hơn, khi nhân vật chính có thể sử dụng những khả năng dịch chuyển hoặc phép thuật đặc biệt.</p>\r\n\r\n<h2>Sử dụng Unreal Engine 5</h2>\r\n\r\n<p>Một trong những thay đổi lớn nhất của phần game mới là việc CD Projekt Red chuyển sang sử dụng <strong>Unreal Engine 5</strong> thay vì REDengine – công nghệ nội bộ đã được dùng cho các phần Witcher trước đó và Cyberpunk 2077.</p>\r\n\r\n<p>Việc chuyển sang Unreal Engine 5 hứa hẹn sẽ mang lại nhiều cải tiến đáng kể về:</p>\r\n\r\n<ul>\r\n<li>Chất lượng đồ họa và ánh sáng chân thực hơn</li>\r\n<li>Thế giới mở rộng lớn và chi tiết hơn</li>\r\n<li>Hiệu suất ổn định hơn trên các nền tảng mới</li>\r\n<li>Hỗ trợ phát triển game nhanh hơn cho đội ngũ phát triển</li>\r\n</ul>\r\n\r\n<h2>Geralt vẫn có thể xuất hiện</h2>\r\n\r\n<p>Mặc dù Geralt không còn là nhân vật chính, CD Projekt Red cho biết nhân vật huyền thoại này vẫn có khả năng xuất hiện trong câu chuyện với vai trò nhất định. Điều này khiến nhiều người hâm mộ kỳ vọng rằng game sẽ tiếp tục duy trì sự kết nối với trilogy trước.</p>\r\n\r\n<p>Ngoài ra, The Witcher 4 được xác nhận là phần mở đầu cho một trilogy hoàn toàn mới trong vũ trụ Witcher. Điều này đồng nghĩa với việc câu chuyện của Ciri có thể sẽ được phát triển xuyên suốt nhiều phần game trong tương lai.</p>\r\n\r\n<h2>Ngày phát hành dự kiến</h2>\r\n\r\n<p>Hiện tại CD Projekt Red vẫn chưa công bố ngày phát hành chính thức cho <strong>The Witcher 4</strong>. Tuy nhiên theo nhiều dự đoán từ cộng đồng, trò chơi có thể sẽ ra mắt trong giai đoạn <strong>2026 – 2027</strong>, khi quá trình phát triển vẫn đang ở giai đoạn đầu.</p>\r\n\r\n<p>Dù còn khá lâu mới đến ngày phát hành, trailer đầu tiên của The Witcher 4 đã đủ khiến cộng đồng game thủ toàn cầu vô cùng hào hứng. Với một nhân vật chính mới, công nghệ đồ họa hiện đại và tham vọng xây dựng trilogy tiếp theo, đây có thể sẽ là bước khởi đầu cho một kỷ nguyên mới của series Witcher.</p>', 'http://localhost/gamenews/public/images/uploads/img_69b40639925a9_1773405753.png', 'The Witcher 4 trailer Ciri nhân vật chính', 'The Witcher 4 trailer xác nhận Ciri là nhân vật chính thay Geralt.', 3, 2, 79667, 'published', 1, 0, '2025-12-12 18:00:00', '2026-03-11 06:31:39', '2026-03-15 17:33:20'),
(11, 'Liên Quân Mobile – Tướng mới Keera siêu cơ động ra mắt', 'lien-quan-keera-tuong-moi-ra-mat', 'Garena ra mắt Keera – tướng Assassin thứ 130 của Liên Quân Mobile với khả năng dash liên tục và burst damage cực cao.', '<h2>Keera – Sát Thủ Cơ Động Nhất Liên Quân</h2>\r\n<p>Keera là tướng được fan chờ đợi nhất 2025 với bộ kỹ năng hoàn toàn mới lạ trong MOBA mobile.</p>\r\n<h3>Bộ kỹ năng:</h3>\r\n<ul>\r\n  <li><strong>Nội công (Passive):</strong> Mỗi lần dash nạp thêm 1 chồng sát thương</li>\r\n  <li><strong>Kỹ năng 1:</strong> Dash nhanh, áp dụng Slow</li>\r\n  <li><strong>Kỹ năng 2:</strong> Tàng hình ngắn + tăng tốc</li>\r\n  <li><strong>Kỹ năng 3:</strong> Dash xuyên tường địa hình</li>\r\n  <li><strong>Chiêu cuối:</strong> 5 lần dash liên tiếp + burst toàn bộ chồng sát thương</li>\r\n</ul>', 'http://localhost/gamenews/public/images/uploads/img_69b3d0fa206d5_1773392122.jpg', 'Liên Quân tướng mới Keera Assassin', 'Liên Quân Mobile ra mắt tướng Assassin Keera siêu cơ động.', 5, 3, 55870, 'published', 1, 0, '2025-08-19 20:00:00', '2026-03-11 06:31:39', '2026-03-14 19:02:16'),
(12, 'Steam Deck OLED 2 – Valve hé lộ thế hệ handheld tiếp theo', 'steam-deck-oled-2-valve-he-lo', 'Valve bất ngờ hé lộ Steam Deck OLED 2 với màn hình 8 inch, chip AMD mới và pin 6000mAh.', '<h2>Steam Deck OLED 2 – Nâng cấp đáng kể</h2>\r\n<p>Chỉ 2 năm sau Steam Deck OLED đời đầu, Valve đã sẵn sàng với thế hệ tiếp theo.</p>\r\n<h3>Nâng cấp chính:</h3>\r\n<ul>\r\n  <li>Màn hình 8 inch OLED 90Hz (tăng từ 7.4 inch 60Hz)</li>\r\n  <li>Chip AMD Ryzen AI 365 – mạnh gấp đôi thế hệ cũ</li>\r\n  <li>Pin 6000mAh – chơi được 4–6 tiếng liên tục</li>\r\n  <li>Hỗ trợ Wi-Fi 7</li>\r\n  <li>Giá dự kiến: 599 USD</li>\r\n</ul>', 'http://localhost/gamenews/public/images/uploads/img_69b3d17bbb877_1773392251.webp', 'Steam Deck OLED 2 thế hệ mới', 'Valve hé lộ Steam Deck OLED 2 với chip AMD mới và màn hình lớn hơn.', 3, 2, 45320, 'published', 1, 0, '2025-08-09 19:00:00', '2026-03-11 06:31:39', '2026-03-13 01:57:31'),
(13, 'Diablo IV Season 8 – Endgame mới và Necromancer overhaul', 'diablo4-season-8-endgame', 'Blizzard phát hành Season 8 của Diablo IV với Pit of Artificer, Necromancer overhaul và hệ thống Paragon mới.', '<h2>Diablo IV Season 8 – Sins of the Horadrim</h2>\r\n<p>Season 8 là bản cập nhật lớn nhất kể từ khi Diablo IV ra mắt, thay đổi hoàn toàn endgame loop.</p>\r\n<h3>Nội dung mới:</h3>\r\n<ul>\r\n  <li><strong>Pit of Artificer:</strong> Dungeon 100 tầng mới – khó hơn Pit hiện tại</li>\r\n  <li><strong>Necromancer Overhaul:</strong> Hệ thống Summoner được làm lại từ đầu</li>\r\n  <li><strong>Paragon V2:</strong> Bảng talent mới linh hoạt hơn</li>\r\n  <li>Boss mới: Azmodan phiên bản Uber</li>\r\n</ul>', 'http://localhost/gamenews/public/images/uploads/img_69b3d19f108c9_1773392287.jpg', 'Diablo IV Season 8 nội dung mới', 'Diablo IV Season 8 Sins of the Horadrim với endgame mới.', 3, 4, 52340, 'published', 0, 0, '2025-05-19 19:00:00', '2026-03-11 06:31:39', '2026-03-13 01:58:07'),
(14, 'Cyberpunk 2077 Ultimate Edition giảm giá còn 299k trên Steam', 'cyberpunk-2077-sale-299k-steam', 'CD Projekt Red giảm giá sốc Cyberpunk 2077 Ultimate Edition xuống còn 299.000 VND – thấp nhất lịch sử.', '<h2>Cyberpunk 2077 – Deal Không Thể Bỏ Qua</h2>\r\n<p>Đây là lần đầu tiên Ultimate Edition (bao gồm game + DLC Phantom Liberty) xuống mức giá này trên Steam.</p>\r\n<h3>Gói bao gồm:</h3>\r\n<ul>\r\n  <li>Cyberpunk 2077 game chính – 60–80 giờ chơi</li>\r\n  <li>Phantom Liberty DLC – thêm 20–30 giờ</li>\r\n  <li>Toàn bộ DLC cosmetic và xe cộ</li>\r\n</ul>\r\n<p>Sale kéo dài đến 31/7/2025. Yêu cầu: RTX 2060 / RX 5700 để chơi 1080p 60fps.</p>', 'http://localhost/gamenews/public/images/uploads/img_69b3d23a112ac_1773392442.jpeg', 'Cyberpunk 2077 sale 299k Steam', 'Cyberpunk 2077 Ultimate Edition giảm còn 299k VND trên Steam.', 3, 2, 38760, 'published', 0, 1, '2025-07-25 01:00:00', '2026-03-11 06:31:39', '2026-03-13 02:00:42'),
(15, 'Hades II chính thức ra khỏi Early Access – Phiên bản đầy đủ', 'hades-2-chinh-thuc-full-release', 'Supergiant Games phát hành Hades II bản đầy đủ sau 1 năm Early Access với Act 3 và kết thúc chính thức.', '<h2>Hades II – Full Release</h2>\r\n<p>Sau 1 năm Early Access được đón nhận nồng nhiệt, Hades II chính thức ra mắt bản đầy đủ với cốt truyện hoàn chỉnh.</p>\r\n<h3>Nội dung mới trong bản full:</h3>\r\n<ul>\r\n  <li>Act 3: Olympus – hành trình cuối cùng của Melinoë</li>\r\n  <li>Boss mới: Chronos phiên bản final</li>\r\n  <li>10 weapon mới</li>\r\n  <li>Kết thúc true ending và multiple endings</li>\r\n  <li>New Game+ với độ khó Chaos mode</li>\r\n</ul>', 'http://localhost/gamenews/public/images/uploads/img_69b3d004ed2b3_1773391876.webp', 'Hades II full release ra khỏi Early Access', 'Hades II chính thức ra mắt bản đầy đủ với Act 3 và kết thúc.', 6, 4, 39451, 'published', 0, 0, '2025-08-29 19:00:00', '2026-03-11 06:31:39', '2026-03-13 05:58:51'),
(16, 'Mobile Legends Project NEXT 2025 – 15 tướng được revamp', 'mlbb-project-next-2025-revamp', 'Moonton công bố Project NEXT 2025 với 15 tướng sẽ được làm mới hoàn toàn về skill set và visual.', '<h2>MLBB Project NEXT 2025 – Làm Mới Huyền Thoại</h2>\r\n<p>Moonton tiếp tục chuỗi revamp tướng với Project NEXT 2025, tập trung vào những tướng cổ nhất game.</p>\r\n<h3>Một số tướng sẽ được revamp:</h3>\r\n<ul>\r\n  <li>Layla – ADC cổ nhất được thiết kế lại hoàn toàn</li>\r\n  <li>Balmond – Fighter cổ điển với skill mới</li>\r\n  <li>Clint – Gunslinger nâng cấp visual 4K</li>\r\n  <li>Nana – Support được thêm passive mới</li>\r\n</ul>', 'http://localhost/gamenews/public/images/uploads/img_69b3d11a84d20_1773392154.png', 'MLBB Project NEXT 2025 revamp 15 tướng', 'Mobile Legends Project NEXT 2025 revamp 15 tướng cổ điển.', 5, 3, 47890, 'published', 0, 0, '2025-05-09 20:00:00', '2026-03-11 06:31:39', '2026-03-13 01:55:54'),
(17, 'Fortnite Chapter 6 – Map mới và collab Marvel Spider-Man', 'fortnite-chapter-6-map-spiderman', 'Epic Games khởi động Fortnite Chapter 6 với map hoàn toàn mới theo theme Nhật Bản và Spider-Man Miles Morales.', '<h2>Fortnite Chapter 6 – Bản đồ mới lấy cảm hứng từ Nhật Bản</h2>\r\n\r\n<p>Epic Games đã chính thức khởi động <strong>Fortnite Chapter 6</strong> với một bản đồ hoàn toàn mới cùng nhiều thay đổi lớn về gameplay. Chapter lần này mang đậm phong cách Nhật Bản với các khu vực kiến trúc truyền thống, rừng tre, đền cổ và thành phố hiện đại.</p>\r\n\r\n<p>Thiết kế bản đồ mới không chỉ thay đổi về mặt thẩm mỹ mà còn mang đến nhiều khu vực chiến đấu độc đáo, tạo nên những trận battle royale kịch tính hơn so với các mùa trước.</p>\r\n\r\n<h2>Những điểm mới đáng chú ý</h2>\r\n\r\n<ul>\r\n<li>Bản đồ mới với nhiều biome lấy cảm hứng từ Nhật Bản</li>\r\n<li>Thêm cơ chế di chuyển mới và khu vực chiến đấu độc đáo</li>\r\n<li>Vũ khí và trang bị mới xuất hiện trong Chapter 6</li>\r\n<li>Nhiều sự kiện trong game được cập nhật thường xuyên</li>\r\n</ul>\r\n\r\n<h2>Grapple Blade – Cơ chế di chuyển mới</h2>\r\n\r\n<p>Một trong những trang bị đáng chú ý nhất của Chapter 6 là <strong>Grapple Blade</strong>. Trang bị này cho phép người chơi đu bám vào các bề mặt và di chuyển nhanh qua các khu vực trên bản đồ.</p>\r\n\r\n<p>Cơ chế này giúp gameplay trở nên linh hoạt hơn, đồng thời tạo ra nhiều tình huống giao tranh bất ngờ khi người chơi có thể tiếp cận đối thủ từ nhiều hướng khác nhau.</p>\r\n\r\n<h2>Collab lớn với Marvel – Spider-Man Miles Morales</h2>\r\n\r\n<p>Fortnite tiếp tục duy trì truyền thống hợp tác với các thương hiệu nổi tiếng. Trong Chapter 6, Epic Games đã mang đến sự kiện collab với <strong>Marvel</strong>, trong đó nổi bật nhất là skin <strong>Spider-Man Miles Morales</strong>.</p>\r\n\r\n<p>Người chơi có thể mở khóa skin và nhiều vật phẩm mỹ phẩm khác thông qua battle pass hoặc các sự kiện trong game. Đây được xem là một trong những collab được cộng đồng Fortnite mong chờ nhất.</p>\r\n\r\n<h2>Nhiều collab mới trong tương lai</h2>\r\n\r\n<p>Ngoài Marvel, Epic Games cũng hé lộ khả năng tiếp tục hợp tác với nhiều thương hiệu khác trong các bản cập nhật sắp tới. Một số tin đồn cho rằng các nhân vật anime và game nổi tiếng có thể xuất hiện trong Chapter 6.</p>\r\n\r\n<p>Những sự kiện collab này luôn là yếu tố giúp Fortnite giữ được sức hút mạnh mẽ với cộng đồng game thủ trên toàn thế giới.</p>', 'http://localhost/gamenews/public/images/uploads/img_69b3cf1226d9e_1773391634.jpg', 'Fortnite Chapter 6 map mới Spider-Man', 'Fortnite Chapter 6 map Nhật Bản và collab Marvel Spider-Man.', 3, 3, 65433, 'published', 1, 1, '2025-11-30 19:00:00', '2026-03-11 06:31:39', '2026-03-16 05:41:29'),
(18, 'Apex Legends Season 24 – Legend mới Alter và LMG Nemesis', 'apex-legends-season-24-alter', 'Respawn công bố Season 24 của Apex Legends với Legend mới Alter – có thể đi xuyên tường – và LMG Nemesis.', '<h2>Apex Legends Season 24 – Alter Dimensions</h2>\r\n<p>Alter là Legend độc đáo nhất từ trước đến nay với khả năng mở rift xuyên qua các vật cản.</p>\r\n<h3>Kỹ năng của Alter:</h3>\r\n<ul>\r\n  <li><strong>Passive:</strong> Xem được path của enemy vừa grapple qua</li>\r\n  <li><strong>Tactical:</strong> Mở lối xuyên tường trong 10 giây</li>\r\n  <li><strong>Ultimate:</strong> Dịch chuyển tức thời đến vị trí khác trên map</li>\r\n</ul>\r\n<h3>LMG Nemesis:</h3>\r\n<ul>\r\n  <li>55 damage/viên, 25 đạn/băng</li>\r\n  <li>Cơ chế tích điện – bắn liên tục tăng tốc độ đạn</li>\r\n</ul>', 'http://localhost/gamenews/public/images/uploads/img_69b4024fc512c_1773404751.jpg', 'Apex Legends Season 24 Alter Legend mới', 'Apex Legends Season 24 với Legend Alter và LMG Nemesis.', 3, 3, 48920, 'published', 0, 0, '2025-01-27 20:00:00', '2026-03-11 06:31:39', '2026-03-13 05:25:51'),
(19, 'EA Sports FC 26 – HyperMotion V và AI gameplay hoàn toàn mới', 'ea-sports-fc-26-hypermotion-v', 'EA Sports hé lộ FC 26 với công nghệ HyperMotion V – AI học từ 180 trận đấu thực tế – thay đổi hoàn toàn cảm giác chơi.', '<h2>EA Sports FC 26 – Tương Lai Bóng Đá Số</h2>\r\n<p>FC 26 sử dụng AI thế hệ mới được train từ 180 trận đấu thực tế để tái hiện chuyển động cầu thủ chân thực nhất.</p>\r\n<h3>Nổi bật:</h3>\r\n<ul>\r\n  <li><strong>HyperMotion V:</strong> Mỗi cầu thủ có 2000+ animation riêng biệt</li>\r\n  <li><strong>Rush Mode:</strong> 5v5 mini-game trong Ultimate Team</li>\r\n  <li><strong>FC IQ:</strong> Hệ thống AI đồng đội thông minh hơn</li>\r\n  <li>Ra mắt: 27/9/2025 trên tất cả nền tảng</li>\r\n</ul>', 'http://localhost/gamenews/public/images/uploads/img_69b4028e9f356_1773404814.jpg', 'EA Sports FC 26 HyperMotion V AI mới', 'EA Sports FC 26 với HyperMotion V và AI gameplay hoàn toàn mới.', 3, 2, 58760, 'published', 0, 0, '2025-04-19 20:00:00', '2026-03-11 06:31:39', '2026-03-13 05:26:54'),
(20, 'Overwatch 2 Season 15 – Hệ thống Perks thay đổi toàn bộ meta', 'overwatch-2-season-15-perks', 'Blizzard ra mắt hệ thống Perks trong Season 15 – cho phép nâng cấp kỹ năng hero ngay trong trận – thay đổi hoàn toàn cách chơi.', '<h2>Overwatch 2 Season 15 – Perks Revolution</h2>\r\n<p>Perks là thay đổi gameplay lớn nhất của OW2 từ khi ra mắt. Mỗi hero có 4 Perk có thể chọn trong trận.</p>\r\n<h3>Cách hoạt động:</h3>\r\n<ul>\r\n  <li>Level 2: Chọn Minor Perk (buff nhỏ)</li>\r\n  <li>Level 4: Chọn Major Perk (thay đổi kỹ năng đáng kể)</li>\r\n  <li>Mỗi hero có 4 Perk khác nhau để chọn lựa</li>\r\n</ul>\r\n<p>Ví dụ: Tracer Minor Perk tăng Recall range, Major Perk cho phép dùng Pulse Bomb ngay khi recall.</p>', 'http://localhost/gamenews/public/images/uploads/img_69b402b41e754_1773404852.jpg', 'Overwatch 2 Season 15 Perks system', 'Overwatch 2 Season 15 với hệ thống Perks thay đổi meta.', 3, 4, 43210, 'published', 0, 0, '2025-02-27 19:00:00', '2026-03-11 06:31:39', '2026-03-13 05:27:32'),
(21, 'Review Black Myth: Wukong – Game năm 2024 không thể tranh cãi', 'review-black-myth-wukong-2024', 'Black Myth: Wukong từ studio Game Science đã làm thay đổi cả ngành game với màn debut ngoạn mục. Đây là review toàn diện nhất.', '<h2>Review Black Myth: Wukong – 9/10</h2>\r\n<p>Game Science đã tạo ra điều không tưởng: một studio Trung Quốc nhỏ với AAA game đẳng cấp thế giới.</p>\r\n<h3>Đồ họa – 10/10</h3>\r\n<p>Đẹp nhất năm 2024, không bàn cãi. Unreal Engine 5 với Lumen và Nanite cho ra những cảnh phim không phân biệt được với thực tế.</p>\r\n<h3>Gameplay – 8/10</h3>\r\n<p>72 phép biến hóa độc đáo, hệ thống boss phong phú. Hơi thiếu variety trong combat về cuối game.</p>\r\n<h3>Cốt truyện – 9/10</h3>\r\n<p>Tây Du Ký được kể lại từ góc nhìn hoàn toàn mới. Cảm xúc và bi kịch hơn nguyên tác nhiều.</p>\r\n<h3>Âm nhạc – 10/10</h3>\r\n<p>OST hòa trộn nhạc cụ truyền thống Trung Hoa với orchestra hiện đại – xuất sắc nhất năm.</p>\r\n<h3>Kết luận:</h3>\r\n<p><strong>9/10</strong> – Game năm 2024. Bắt buộc phải chơi nếu bạn yêu thích action RPG.</p>', 'http://localhost/gamenews/public/images/uploads/img_69b3d2831219f_1773392515.jpg', 'Review Black Myth Wukong 9/10 game năm 2024', 'Review Black Myth Wukong – Game năm 2024 với điểm 9/10.', 7, 4, 135686, 'published', 1, 0, '2025-08-24 18:00:00', '2026-03-11 06:31:39', '2026-03-15 09:00:07'),
(22, 'Review Elden Ring: Shadow of the Erdtree – DLC xuất sắc nhất mọi thời đại', 'review-elden-ring-shadow-dlc', 'Shadow of the Erdtree có xứng đáng với mức giá 35 USD? Câu trả lời ngắn gọn: Hoàn toàn xứng đáng.', '<h2>Review Shadow of the Erdtree – 9.5/10</h2>\r\n<p>FromSoftware một lần nữa chứng minh tại sao họ là studio hàng đầu thế giới trong thiết kế game.</p>\r\n<h3>Nội dung – 10/10</h3>\r\n<p>30+ giờ nội dung chính, 10 legacy dungeon, 8 boss chính và hơn 100 vũ khí mới. Nhiều hơn nhiều game full price.</p>\r\n<h3>Boss Design – 10/10</h3>\r\n<p>Messmer the Impaler là boss hay nhất FromSoftware từng tạo ra – cả về lore lẫn gameplay. Bayle the Dread là runner-up xứng đáng.</p>\r\n<h3>Khó khăn:</h3>\r\n<p>DLC khó hơn game chính đáng kể. Cần tìm đủ Scadutree Fragment mới có thể đánh boss được. Một số người thấy đây là điểm trừ.</p>\r\n<h3>Kết luận:</h3>\r\n<p><strong>9.5/10</strong> – DLC tốt nhất mọi thời đại. Giá 35 USD là deal của thế kỷ.</p>', 'http://localhost/gamenews/public/images/uploads/img_69b3d2d6caeb6_1773392598.jpg', 'Review Elden Ring Shadow of the Erdtree 9.5/10', 'Review Shadow of the Erdtree – DLC tốt nhất mọi thời đại.', 7, 2, 98343, 'published', 1, 0, '2025-07-09 19:00:00', '2026-03-11 06:31:39', '2026-03-14 07:15:33'),
(23, 'Review Astro Bot – Platformer hoàn hảo trên PS5', 'review-astro-bot-ps5', 'Astro Bot của Team Asobi là bằng chứng platformer thuần túy vẫn có thể đạt đỉnh cao nghệ thuật. Review 10/10.', '<h2>Review Astro Bot – 10/10</h2>\r\n<p>Tôi hiếm khi chấm điểm tuyệt đối. Astro Bot là một trong số ít game xứng đáng được 10/10.</p>\r\n<h3>Gameplay – 10/10</h3>\r\n<p>Mỗi level có cơ chế mới, không level nào giống level nào. Team Asobi tận dụng DualSense haptic hoàn hảo.</p>\r\n<h3>Level Design – 10/10</h3>\r\n<p>80 level chính + 40 level ẩn, tất cả đều được polish đến từng chi tiết nhỏ nhất.</p>\r\n<h3>Fan Service – 10/10</h3>\r\n<p>Hơn 150 PlayStation character được biến thành Bot collectible. Fan Sony sẽ khóc vì hạnh phúc.</p>\r\n<h3>Kết luận:</h3>\r\n<p><strong>10/10</strong> – Game của năm 2024. Lý do phải sở hữu PS5.</p>', 'http://localhost/gamenews/public/images/uploads/img_69b402dbc1518_1773404891.jpg', 'Review Astro Bot 10/10 PS5 game của năm', 'Review Astro Bot PS5 – Platformer hoàn hảo điểm 10/10.', 9, 4, 72150, 'published', 1, 0, '2025-09-19 20:00:00', '2026-03-11 06:31:39', '2026-03-13 05:28:11'),
(24, 'Review Baldur&#039;s Gate 3 – RPG tốt nhất thập kỷ', 'review-baldurs-gate-3-rpg', 'Larian Studios tạo ra kiệt tác RPG với 100+ giờ nội dung, mọi lựa chọn đều có ý nghĩa và co-op mode xuất sắc.', '<h2>Review Baldur\'s Gate 3 – 9.5/10</h2>\r\n<p>Sau 3 năm Early Access, BG3 ra mắt bản đầy đủ và vượt xa mọi kỳ vọng.</p>\r\n<h3>Nội dung – 10/10</h3>\r\n<p>100+ giờ chơi cho một playthrough đầy đủ, và mỗi lần chơi lại là một trải nghiệm khác biệt nhờ hệ thống lựa chọn cực kỳ sâu.</p>\r\n<h3>Combat – 9/10</h3>\r\n<p>Turn-based combat dựa trên D&D 5e cực kỳ chiến thuật. Đa dạng spell và build không bao giờ chán.</p>\r\n<h3>Nhược điểm:</h3>\r\n<p>Act 3 hơi rushed so với Act 1 và 2. Một số questline bị cắt xén.</p>\r\n<h3>Kết luận:</h3>\r\n<p><strong>9.5/10</strong> – RPG tốt nhất thập kỷ. Nếu chơi 1 game trong đời, hãy chọn BG3.</p>', 'http://localhost/gamenews/public/images/uploads/img_69b403c75bb01_1773405127.jpg', 'Review Baldur Gate 3 9.5/10 RPG tốt nhất', 'Review Baldur Gate 3 – RPG tốt nhất thập kỷ 9.5/10.', 7, 4, 89671, 'published', 1, 0, '2025-01-14 19:00:00', '2026-03-11 06:31:39', '2026-03-13 05:32:07'),
(25, 'Review Genshin Impact 2025 – Vẫn xứng đáng sau 5 năm?', 'review-genshin-impact-2025', 'Genshin Impact sau 5 năm ra mắt – game có còn phù hợp với người mới? Lượng nội dung khổng lồ và câu hỏi gacha có fair?', '<h2>Review Genshin Impact 2025 – 8/10</h2>\r\n<p>5 năm sau ngày ra mắt, Genshin vẫn là gacha game miễn phí tốt nhất thị trường – nhưng cũng ngày càng phức tạp hơn.</p>\r\n<h3>Điểm mạnh:</h3>\r\n<ul>\r\n  <li>Lượng nội dung khổng lồ – hàng trăm giờ hoàn toàn miễn phí</li>\r\n  <li>Đồ họa và âm nhạc top đầu mobile game</li>\r\n  <li>Story arc Natlan được đánh giá hay nhất từ trước đến nay</li>\r\n  <li>F2P friendly hơn so với 2021–2022</li>\r\n</ul>\r\n<h3>Điểm yếu:</h3>\r\n<ul>\r\n  <li>Gacha vẫn là p2w ở mức độ nhất định</li>\r\n  <li>Power creep ngày càng rõ ràng</li>\r\n  <li>Daily grind nhàm chán</li>\r\n</ul>\r\n<h3>Kết luận:</h3>\r\n<p><strong>8/10</strong> – Đáng chơi nếu bạn có patience. F2P hoàn toàn có thể enjoy.</p>', 'http://localhost/gamenews/public/images/uploads/img_69b40332c5679_1773404978.png', 'Review Genshin Impact 2025 sau 5 năm', 'Review Genshin Impact 2025 – Còn đáng chơi sau 5 năm?', 8, 3, 61231, 'published', 0, 0, '2025-10-04 20:00:00', '2026-03-11 06:31:39', '2026-03-13 05:29:38'),
(26, 'Review PUBG Mobile Season 20 – Rondo Map có thực sự tốt?', 'review-pubg-mobile-season-20-rondo', 'Chúng tôi chơi 50 giờ trên Rondo để đưa ra nhận xét khách quan nhất về bản đồ mới nhất của PUBG Mobile.', '<h2>Review PUBG Mobile Season 20 – 7.5/10</h2>\r\n<p>Rondo là bản đồ đẹp nhất trong lịch sử PUBG Mobile nhưng có khá nhiều điểm cần cải thiện.</p>\r\n<h3>Rondo Map – 8/10</h3>\r\n<p>Thành phố trung tâm đậm chất châu Á, loot phân bổ hợp lý. Hot zone thiết kế tốt với nhiều tầng và lối thoát.</p>\r\n<h3>Vũ khí mới – 7/10</h3>\r\n<p>PP-19 Bizon ổn định nhưng không đặc sắc. Cần thêm thời gian để thấy được vị trí trong meta.</p>\r\n<h3>Nhược điểm:</h3>\r\n<ul>\r\n  <li>Endgame zone thường kết thúc ở vùng đất trống, thiếu cover</li>\r\n  <li>Vài building có hitbox không chính xác</li>\r\n</ul>\r\n<h3>Kết luận:</h3>\r\n<p><strong>7.5/10</strong> – Bản đồ đáng chơi, cần thêm patch để hoàn thiện.</p>', 'http://localhost/gamenews/public/images/uploads/img_69b40223ac2b7_1773404707.jpg', 'Review PUBG Mobile Season 20 Rondo Map', 'Review PUBG Mobile Season 20 bản đồ Rondo 7.5/10.', 8, 3, 45670, 'published', 0, 0, '2025-10-31 19:00:00', '2026-03-11 06:31:39', '2026-03-13 05:25:07'),
(27, 'Review Cyberpunk 2077 Phantom Liberty – Chuộc lỗi hoàn hảo', 'review-cyberpunk-2077-phantom-liberty', 'Từ một game bị chê tơi tả khi ra mắt năm 2020, Phantom Liberty DLC đã biến CP2077 thành masterpiece.', '<h2>Review Cyberpunk 2077 Phantom Liberty – 9/10</h2>\r\n<p>Ít game nào có hành trình như Cyberpunk 2077 – từ thảm họa ra mắt đến một trong những RPG tốt nhất thập kỷ.</p>\r\n<h3>Cốt truyện – 9.5/10</h3>\r\n<p>Spy thriller căng thẳng với những twist không thể đoán trước. Solomon Reed (Idris Elba) là NPC hay nhất trong bất kỳ game nào.</p>\r\n<h3>Map mới Dogtown – 9/10</h3>\r\n<p>Dogtown nhỏ hơn Night City nhưng dày đặc nội dung hơn. Thiết kế vertical xuất sắc.</p>\r\n<h3>Kết thúc mới:</h3>\r\n<p>Phantom Liberty thêm vào một ending mới hoàn toàn cho game chính – đây là ending hay nhất trong 4 kết thúc.</p>\r\n<h3>Kết luận:</h3>\r\n<p><strong>9/10</strong> – Nếu bạn bỏ cuộc với CP2077 năm 2020, đã đến lúc quay lại.</p>', 'http://localhost/gamenews/public/images/uploads/img_69b403ec1c96b_1773405164.jpg', 'Review Cyberpunk 2077 Phantom Liberty 9/10', 'Review Cyberpunk 2077 Phantom Liberty – Chuộc lỗi hoàn hảo.', 7, 2, 67890, 'published', 0, 0, '2025-03-09 19:00:00', '2026-03-11 06:31:39', '2026-03-13 05:32:44'),
(28, 'Review Hades II Early Access – Sequel vượt trội bản gốc', 'review-hades-2-early-access', 'Hades II Early Access ra mắt với điểm Overwhelmingly Positive ngay từ ngày đầu. Supergiant đã làm được điều không thể.', '<h2>Review Hades II Early Access – 9/10</h2>\r\n<p>Early Access mà tốt hơn bản full của nhiều game khác – đó là Hades II.</p>\r\n<h3>Điểm mạnh:</h3>\r\n<ul>\r\n  <li>Nhân vật Melinoë đa dạng hơn Zagreus trong cách build</li>\r\n  <li>6 weapon type với Aspect system sâu hơn nhiều</li>\r\n  <li>Arcana system thay thế Mirror of Night – linh hoạt hơn</li>\r\n  <li>Art style và nhạc nền vượt trội bản gốc</li>\r\n</ul>\r\n<h3>Lưu ý:</h3>\r\n<p>Vẫn là Early Access – Act 3 chưa có. Story chưa hoàn chỉnh. Nhưng đã có 20+ giờ nội dung chất lượng.</p>\r\n<h3>Kết luận:</h3>\r\n<p><strong>9/10</strong> – Roguelite tốt nhất 2024 kể cả khi chưa hoàn chỉnh.</p>', 'http://localhost/gamenews/public/images/uploads/img_69b404376f3d3_1773405239.png', 'Review Hades II Early Access 9/10', 'Review Hades II Early Access – Sequel vượt trội bản gốc.', 7, 4, 35600, 'published', 0, 0, '2025-04-30 19:00:00', '2026-03-11 06:31:39', '2026-03-13 05:33:59'),
(29, 'Review Liên Quân Mobile 2025 – Có nên quay lại chơi?', 'review-lien-quan-mobile-2025', 'Liên Quân Mobile sau nhiều năm cải tiến – matchmaking tốt hơn, anti-cheat mạnh hơn. Review toàn diện 2025.', '<h2>Review Liên Quân Mobile 2025 – 7/10</h2>\r\n<p>Liên Quân 2025 là phiên bản tốt nhất từ trước đến nay nhưng vẫn còn nhiều vấn đề dai dẳng.</p>\r\n<h3>Cải thiện đáng kể:</h3>\r\n<ul>\r\n  <li>Matchmaking: Ít toxic player hơn nhờ behavior scoring system</li>\r\n  <li>Anti-cheat: Giảm 80% cheat so với 2023</li>\r\n  <li>Đồ họa: Hỗ trợ 120fps trên iPhone 15 Pro và flagship Android</li>\r\n</ul>\r\n<h3>Vẫn còn vấn đề:</h3>\r\n<ul>\r\n  <li>P2W vẫn hiện diện ở một số tướng mới</li>\r\n  <li>Server VN vẫn bị lag trong giờ cao điểm</li>\r\n</ul>\r\n<h3>Kết luận:</h3>\r\n<p><strong>7/10</strong> – MOBA mobile tốt nhất VN. Đáng chơi nếu bạn thích thể loại này.</p>', 'http://localhost/gamenews/public/images/uploads/img_69b40359ceaf5_1773405017.webp', 'Review Liên Quân Mobile 2025', 'Review Liên Quân Mobile 2025 – Có nên quay lại chơi?', 8, 3, 52890, 'published', 0, 0, '2025-06-24 20:00:00', '2026-03-11 06:31:39', '2026-03-13 05:30:17'),
(30, 'Review Minecraft 1.22 Garden Awakens – Bản cập nhật hay nhất từ 1.18', 'review-minecraft-122-garden-awakens', 'Garden Awakens mang đến Pale Garden và Creaking – đây có phải bản cập nhật hay nhất kể từ Caves &amp; Cliffs?', '<h2>Review Minecraft 1.22 Garden Awakens – 8/10</h2>\r\n<p>Mojang tiếp tục chuỗi cập nhật chất lượng với Garden Awakens – sáng tạo và đáng sợ theo cách chưa từng có.</p>\r\n<h3>Pale Garden – 9/10</h3>\r\n<p>Biome đẹp và ám ảnh nhất trong lịch sử Minecraft. Màu trắng xám kết hợp sương mù tạo nên atmosphere rùng rợn.</p>\r\n<h3>Creaking – 10/10</h3>\r\n<p>Cơ chế \"chỉ di chuyển khi không nhìn\" là sáng tạo nhất từ trước đến nay. Đáng sợ hơn Enderman rất nhiều.</p>\r\n<h3>Nhược điểm:</h3>\r\n<p>Lượng block và item mới hơi ít so với các bản cập nhật trước. Cần thêm nội dung cho Pale Garden.</p>\r\n<h3>Kết luận:</h3>\r\n<p><strong>8/10</strong> – Bản cập nhật sáng tạo và đáng chơi.</p>', 'http://localhost/gamenews/public/images/uploads/img_69b40456e4c47_1773405270.webp', 'Review Minecraft 1.22 Garden Awakens 8/10', 'Review Minecraft 1.22 Garden Awakens – Sáng tạo nhất từ 1.18.', 7, 2, 38762, 'published', 0, 0, '2025-10-09 20:00:00', '2026-03-11 06:31:39', '2026-03-15 09:00:01'),
(31, 'Review Stardew Valley 1.6 – Indie hoàn hảo nhất mọi thời đại', 'review-stardew-valley-1-6', 'ConcernedApe một mình tạo ra thứ mà studio AAA không làm được. Stardew Valley 1.6 là bản cập nhật hoàn hảo.', '<h2>Review Stardew Valley 1.6 – 10/10</h2>\r\n<p>Không có gì để nói thêm – Stardew Valley 1.6 là bản cập nhật hoàn hảo của một game đã hoàn hảo.</p>\r\n<h3>Nội dung mới 1.6:</h3>\r\n<ul>\r\n  <li>Bookshelves – sưu tập sách tăng skill</li>\r\n  <li>Mastery system – endgame mới sau max level</li>\r\n  <li>Trousersnake Challenge – farm challenge mode</li>\r\n  <li>Hàng trăm đối thoại mới cho NPC</li>\r\n  <li>Hỗ trợ multiplayer lên đến 8 người</li>\r\n</ul>\r\n<h3>Lý do 10/10:</h3>\r\n<p>ConcernedApe tạo ra game này một mình. 1.6 là bản update miễn phí. Và vẫn là một trong những game tốt nhất mọi thời đại.</p>\r\n<h3>Kết luận:</h3>\r\n<p><strong>10/10</strong> – Mua game, chơi game, yêu thương game này.</p>', 'http://localhost/gamenews/public/images/uploads/img_69b404779dfde_1773405303.png', 'Review Stardew Valley 1.6 10/10 indie hoàn hảo', 'Review Stardew Valley 1.6 – Indie hoàn hảo nhất mọi thời đại.', 7, 4, 41230, 'published', 0, 0, '2025-04-19 19:00:00', '2026-03-11 06:31:39', '2026-03-13 05:35:03'),
(32, 'Review Valorant 2025 – FPS tactical tốt nhất PC hiện tại?', 'review-valorant-2025-fps', 'Sau 5 Episode, Valorant có còn giữ được vị trí FPS PC hàng đầu? Review toàn diện sau 4 năm ra mắt.', '<h2>Review Valorant 2025 – 8.5/10</h2>\r\n<p>4 năm tuổi, Valorant vẫn là FPS tactical tốt nhất PC về mặt competitive.</p>\r\n<h3>Gameplay – 9/10</h3>\r\n<p>Gunplay vẫn là tốt nhất trong thể loại. Balance agent được cải thiện đáng kể so với 2021–2022.</p>\r\n<h3>Content – 8/10</h3>\r\n<p>30 Agent đa dạng với role rõ ràng. 11 map chất lượng cao. Esports scene phát triển mạnh.</p>\r\n<h3>Nhược điểm:</h3>\r\n<ul>\r\n  <li>Toxicity vẫn là vấn đề lớn ở VN server</li>\r\n  <li>Cosmetics quá đắt (skin bundle 70 USD)</li>\r\n</ul>\r\n<h3>Kết luận:</h3>\r\n<p><strong>8.5/10</strong> – Vẫn là chuẩn mực FPS tactical. Miễn phí = không có lý do không thử.</p>', 'http://localhost/gamenews/public/images/uploads/img_69b3d309535a8_1773392649.webp', 'Review Valorant 2025 FPS tactical 8.5/10', 'Review Valorant 2025 – FPS tactical tốt nhất PC hiện tại.', 7, 3, 58902, 'published', 0, 0, '2025-11-04 20:00:00', '2026-03-11 06:31:39', '2026-03-13 05:56:00'),
(33, 'Review Diablo IV 2025 – Đã cứu vãn được chưa sau 1 năm?', 'review-diablo-4-2025-sau-1-nam', 'Diablo IV ra mắt gây thất vọng năm 2023. Sau 1 năm update liên tục, game có trở nên tốt hơn thực sự không?', '<h2>Review Diablo IV 2025 – 7.5/10</h2>\r\n<p>Blizzard đã làm việc chăm chỉ và kết quả là Diablo IV 2025 tốt hơn 2023 rất nhiều – nhưng vẫn chưa đến mức masterpiece.</p>\r\n<h3>Cải thiện lớn:</h3>\r\n<ul>\r\n  <li>Season 4 Loot Reborn: Hệ thống loot được thiết kế lại hoàn toàn</li>\r\n  <li>Endgame phong phú hơn với Pit và Tormented Boss</li>\r\n  <li>Balance class tốt hơn – mọi class đều viable</li>\r\n</ul>\r\n<h3>Vẫn còn thiếu:</h3>\r\n<ul>\r\n  <li>Cốt truyện chính vẫn nhạt so với D2</li>\r\n  <li>Battle Pass thiếu value</li>\r\n</ul>\r\n<h3>Kết luận:</h3>\r\n<p><strong>7.5/10</strong> – Đáng chơi nếu bạn thích ARPG, nhưng chờ sale.</p>', 'http://localhost/gamenews/public/images/uploads/img_69b4049b64a98_1773405339.png', 'Review Diablo IV 2025 sau 1 năm 7.5/10', 'Review Diablo IV 2025 – Đã cứu vãn được chưa sau 1 năm?', 7, 4, 47800, 'published', 0, 0, '2025-06-19 19:00:00', '2026-03-11 06:31:39', '2026-03-13 05:35:39');
INSERT INTO `articles` (`article_id`, `title`, `slug`, `summary`, `content`, `thumbnail`, `meta_title`, `meta_description`, `category_id`, `author_id`, `view_count`, `status`, `is_featured`, `is_breaking`, `published_at`, `created_at`, `updated_at`) VALUES
(34, 'Review Tekken 8 – Fighting game đỉnh cao không thể bỏ lỡ', 'review-tekken-8-fighting', 'Tekken 8 là fighting game tốt nhất năm 2024 với Arcade Quest story mode xuất sắc và gameplay depth cực cao.', '<h2>Review Tekken 8 – 9/10</h2>\r\n<p>Bandai Namco đã tạo ra Tekken tốt nhất từ trước đến nay.</p>\r\n<h3>Story Mode – 9/10</h3>\r\n<p>The Dark Awakens là story mode fighting game hay nhất từng được làm. Mỗi character có arc riêng đầy đủ.</p>\r\n<h3>Gameplay – 9.5/10</h3>\r\n<p>Heat system mới tạo ra lớp depth chiến thuật mà các Tekken cũ thiếu. Beginner friendly hơn nhưng vẫn cao deepness cho pro.</p>\r\n<h3>Online – 8/10</h3>\r\n<p>Rollback netcode chuẩn, matching fair. Chỉ thiếu cross-play giữa console và PC.</p>\r\n<h3>Kết luận:</h3>\r\n<p><strong>9/10</strong> – Fighting game of the year 2024. Xứng đáng với cái tên King of Iron Fist.</p>', 'http://localhost/gamenews/public/images/uploads/img_69b404b4ddf82_1773405364.webp', 'Review Tekken 8 9/10 fighting game', 'Review Tekken 8 – Fighting game đỉnh cao 9/10.', 7, 2, 33451, 'published', 0, 0, '2025-02-24 20:00:00', '2026-03-11 06:31:39', '2026-03-13 05:36:04'),
(35, 'Review Hollow Knight – Tại sao indie 2017 này vẫn là must-play 2025?', 'review-hollow-knight-must-play-2025', 'Nhìn lại Hollow Knight năm 2025 – tại sao game 8 năm tuổi vẫn là metroidvania hay nhất từng được tạo ra?', '<h2>Review Hollow Knight – 10/10 (2025)</h2>\r\n<p>8 năm trôi qua, Hollow Knight vẫn chưa có đối thủ thực sự trong thể loại metroidvania.</p>\r\n<h3>Tại sao vẫn hay năm 2025:</h3>\r\n<ul>\r\n  <li><strong>World building:</strong> Hallownest là thế giới game được xây dựng công phu nhất từng có trong indie game</li>\r\n  <li><strong>Combat:</strong> Đơn giản để học, vô hạn để master – boss cuối vẫn thách thức pro player</li>\r\n  <li><strong>Âm nhạc:</strong> Christopher Larkin tạo ra OST không thể quên</li>\r\n  <li><strong>Giá:</strong> 150k VND – deal tốt nhất trong gaming</li>\r\n</ul>\r\n<h3>Lý do chơi 2025:</h3>\r\n<p>Silksong vẫn chưa ra. Đây là cách chuẩn bị tốt nhất và cũng là cách tận hưởng masterpiece.</p>\r\n<h3>Kết luận:</h3>\r\n<p><strong>10/10</strong> – Bắt buộc phải chơi trước khi Silksong ra mắt.</p>', 'http://localhost/gamenews/public/images/uploads/img_69b4050c9a864_1773405452.jpg', 'Review Hollow Knight 10/10 must-play 2025', 'Review Hollow Knight – Tại sao vẫn là must-play năm 2025.', 7, 2, 29450, 'published', 0, 0, '2025-07-14 20:00:00', '2026-03-11 06:31:39', '2026-03-13 05:37:32'),
(36, 'Review Mobile Legends 2025 – MOBA mobile vua Đông Nam Á', 'review-mobile-legends-2025-sea', 'MLBB vẫn là MOBA mobile số 1 Đông Nam Á sau nhiều năm. Review toàn diện 2025: gameplay, meta và vấn đề P2W.', '<h2>Review Mobile Legends 2025 – 7/10</h2>\r\n<p>Moonton tiếp tục duy trì vị trí thống trị MOBA mobile ĐNA nhưng game vẫn còn những vấn đề khó chịu.</p>\r\n<h3>Điểm mạnh:</h3>\r\n<ul>\r\n  <li>Gameplay nhanh (15–18 phút/trận) phù hợp mobile</li>\r\n  <li>120+ hero đa dạng, meta thay đổi thường xuyên</li>\r\n  <li>Esports scene mạnh (MPL)</li>\r\n</ul>\r\n<h3>Điểm yếu:</h3>\r\n<ul>\r\n  <li>P2W vẫn hiện diện với hero mới OP</li>\r\n  <li>Matchmaking ghép đội không đồng đều</li>\r\n  <li>Skin quá đắt</li>\r\n</ul>\r\n<h3>Kết luận:</h3>\r\n<p><strong>7/10</strong> – Vẫn là best MOBA mobile nhưng cần cải thiện nhiều thứ.</p>', 'http://localhost/gamenews/public/images/uploads/img_69b4041433098_1773405204.webp', 'Review Mobile Legends 2025 MOBA mobile', 'Review Mobile Legends 2025 – MOBA mobile số 1 Đông Nam Á.', 8, 3, 43560, 'published', 0, 0, '2025-08-29 19:00:00', '2026-03-11 06:31:39', '2026-03-13 05:33:24'),
(37, 'Review EA Sports FC 25 – Có đáng mua hay chờ FC 26?', 'review-ea-sports-fc-25-dang-mua', 'EA Sports FC 25 với Rush mode mới và FC IQ system. Có đáng bỏ 1.5 triệu mua hay chờ FC 26 sang năm?', '<h2>Review EA Sports FC 25 – 7/10</h2>\r\n<p>FC 25 là bước đi nhỏ so với FC 24, không phải bước nhảy vọt.</p>\r\n<h3>Rush Mode – 8/10</h3>\r\n<p>5v5 format mới trong Ultimate Team thú vị và tươi mới. Cách kiếm coin nhanh hơn và ít toxic hơn Rivals.</p>\r\n<h3>FC IQ – 7/10</h3>\r\n<p>AI đồng đội thông minh hơn trong positioning. Nhưng cần thêm thời gian để thực sự ảnh hưởng đến gameplay pro.</p>\r\n<h3>Vấn đề:</h3>\r\n<ul>\r\n  <li>Ultimate Team vẫn P2W nặng</li>\r\n  <li>Career Mode không có gì mới đáng kể</li>\r\n</ul>\r\n<h3>Kết luận:</h3>\r\n<p><strong>7/10</strong> – Nếu bạn đã có FC 24, hãy chờ sale hoặc FC 26.</p>', 'http://localhost/gamenews/public/images/uploads/img_69b4053b4ecc3_1773405499.jpg', 'Review EA Sports FC 25 có đáng mua', 'Review EA Sports FC 25 – Có đáng mua hay chờ FC 26?', 7, 2, 38901, 'published', 0, 0, '2025-09-24 20:00:00', '2026-03-11 06:31:39', '2026-03-15 09:00:04'),
(38, 'Review Nintendo Switch – Vẫn đáng mua năm 2025 trước khi Switch 2 ra mắt?', 'review-nintendo-switch-1-2025', 'Switch đời đầu giảm giá còn 6 triệu. Với Switch 2 sắp ra mắt, có nên mua Switch 1 không?', '<h2>Review Nintendo Switch 2025 – Có Nên Mua?</h2>\r\n<p>Câu trả lời phụ thuộc vào nhu cầu của bạn – nhưng đây là phân tích trung thực nhất.</p>\r\n<h3>Lý do NÊN mua Switch 1:</h3>\r\n<ul>\r\n  <li>Game library: 5000+ game, nhiều exclusive kiệt tác</li>\r\n  <li>Giá hiện tại: 6 triệu VND – rẻ nhất từ trước đến nay</li>\r\n  <li>Portable gaming không gì sánh bằng</li>\r\n  <li>Switch 2 tương thích ngược – library vẫn dùng được</li>\r\n</ul>\r\n<h3>Lý do KHÔNG NÊN:</h3>\r\n<ul>\r\n  <li>Switch 2 ra mắt 2025 – đợi thêm vài tháng đáng hơn</li>\r\n  <li>Joy-Con drift vẫn là vấn đề</li>\r\n</ul>\r\n<h3>Kết luận:</h3>\r\n<p>Nếu ngân sách eo hẹp: mua Switch 1. Nếu có thể chờ: đợi Switch 2.</p>', 'http://localhost/gamenews/public/images/uploads/img_69b4030032254_1773404928.webp', 'Review Nintendo Switch 2025 có nên mua', 'Review Nintendo Switch 2025 – Có nên mua trước khi Switch 2 ra?', 9, 4, 45601, 'published', 0, 0, '2025-03-14 19:00:00', '2026-03-11 06:31:39', '2026-03-15 09:01:43'),
(39, 'Review Apex Legends 2025 – Battle Royale đang dần mất hút', 'review-apex-legends-2025-state', 'Apex Legends đang mất dần người chơi dù gameplay vẫn xuất sắc. Phân tích những gì đã sai với Respawn.', '<h2>Review Apex Legends 2025 – 7/10</h2>\r\n<p>Apex vẫn là battle royale với gameplay tốt nhất – nhưng Respawn đang tự bắn vào chân mình.</p>\r\n<h3>Gameplay vẫn 9/10:</h3>\r\n<p>Movement system không game nào bắt kịp. Legend kit phong phú và unique. Gunplay đỉnh nhất BR genre.</p>\r\n<h3>Vấn đề ngày càng tệ:</h3>\r\n<ul>\r\n  <li>Monetization: Skin 70 USD là bình thường, battle pass giá tăng liên tục</li>\r\n  <li>Server: Ddos và cheater vẫn chưa được xử lý</li>\r\n  <li>Ranked: System thay đổi quá nhiều gây confuse</li>\r\n</ul>\r\n<h3>Kết luận:</h3>\r\n<p><strong>7/10</strong> – Gameplay tốt nhất BR nhưng publisher đang giết chết game.</p>', 'http://localhost/gamenews/public/images/uploads/img_69b40551b9860_1773405521.jpg', 'Review Apex Legends 2025 state 7/10', 'Review Apex Legends 2025 – Battle Royale dần mất hút.', 7, 3, 41231, 'published', 0, 0, '2025-03-24 19:00:00', '2026-03-11 06:31:39', '2026-03-13 05:38:41'),
(40, 'Review Overwatch 2 2025 – Perks System có cứu được game không?', 'review-overwatch-2-2025-perks', 'Overwatch 2 thêm hệ thống Perks trong Season 15. Đây có phải thay đổi cần thiết hay chỉ là band-aid fix?', '<h2>Review Overwatch 2 2025 – 6.5/10</h2>\r\n<p>Perks system là thay đổi tích cực nhất OW2 từ khi ra mắt – nhưng vẫn còn quá nhiều vấn đề nền tảng.</p>\r\n<h3>Perks System – 8/10</h3>\r\n<p>Mang lại chiều sâu chiến thuật và tăng replayability đáng kể. Đúng hướng đi.</p>\r\n<h3>Vẫn còn nhiều vấn đề:</h3>\r\n<ul>\r\n  <li>Thiếu identity – không biết muốn là OW1 hay game mới</li>\r\n  <li>Hero pool giống OW1 quá nhiều, thiếu hero thực sự mới</li>\r\n  <li>PvE promise vẫn chưa được thực hiện</li>\r\n  <li>Community trust đã mất từ lâu</li>\r\n</ul>\r\n<h3>Kết luận:</h3>\r\n<p><strong>6.5/10</strong> – Cải thiện nhưng chưa đủ. Cần thêm 2–3 season nữa để thực sự đánh giá được.</p>', 'http://localhost/gamenews/public/images/uploads/img_69b4068db4275_1773405837.jpg', 'Review Overwatch 2 2025 Perks system 6.5/10', 'Review Overwatch 2 2025 – Perks System có cứu được game không?', 7, 4, 35780, 'published', 0, 0, '2025-04-09 20:00:00', '2026-03-11 06:31:39', '2026-03-13 05:43:57'),
(41, 'Đánh Giá Elden Ring: Shadow of the Erdtree – Kiệt Tác Mở Rộng Hoàn Hảo Cho Huyền Thoại Souls-like', 'elden-ring-shadow-erdtree-review', 'FromSoftware quay trở lại với một bản mở rộng đồ sộ, tham vọng và đầy tính thử thách cho Elden Ring, bổ sung hàng chục giờ nội dung mới, hệ thống build sâu hơn và những trận boss có thể đi vào lịch sử làng game. Đây là DLC mà bất kỳ fan Souls-like nào cũng không thể bỏ lỡ.', '<h2>Lời Mở Đầu</h2>\r\n<p>Khi Elden Ring ra mắt vào đầu năm 2022, cộng đồng game thủ gần như nổ tung. Tựa game đã kết hợp thành công thế giới mở tự do khám phá với độ khó đậm chất FromSoftware, tạo ra một cột mốc mới cho thể loại action RPG. Hơn hai năm sau, <strong>Shadow of the Erdtree</strong> xuất hiện không chỉ như một bản DLC bổ sung nội dung đơn thuần, mà giống một chương hậu truyện đầy tham vọng, được thiết kế cho những người đã thật sự hiểu và yêu Lands Between.</p>\r\n<p>Điểm ấn tượng nhất là cảm giác <strong>\"đây vẫn là Elden Ring, nhưng tinh lọc và giàu chiều sâu hơn\"</strong>. Từ pacing, cách bố trí kẻ địch, cho đến nhịp điệu khám phá – mọi thứ đều cho thấy đội ngũ thiết kế đã lắng nghe phản hồi của cộng đồng, đồng thời vẫn giữ vững bản sắc không khoan nhượng của mình.</p>\r\n \r\n<h2>Thế Giới Mới: Land of Shadow</h2>\r\n<p>Shadow of the Erdtree đưa bạn đến <strong>Land of Shadow</strong> – vùng đất bị bóng cây Erdtree nuốt chửng, nơi những chương đen tối nhất trong lịch sử thế giới này bị che giấu. Đây không phải là một khu vực phụ nhỏ được gắn vào bản đồ cũ; nó là một lục địa hoàn toàn mới với cấu trúc, logic địa lý và mạch khám phá riêng, ước tính chiếm khoảng một nửa quy mô thế giới gốc.</p>\r\n<p>Mỗi vùng trong Land of Shadow đều có chủ đề rõ ràng: đồng hoang cháy xém bởi chiến tranh, thành trì mục nát của những tín đồ cuồng tín, vùng đầm lầy bị ma thuật vặn vẹo… Không có khu vực nào chỉ tồn tại cho có. Bạn luôn tìm thấy dungeon ẩn, con đường tắt, item quan trọng hoặc một mẩu lore được sắp đặt có chủ đích. Cảm giác <strong>\"quẹo đại vào đây xem có gì\"</strong> mà Elden Ring từng làm rất tốt nay tiếp tục được nâng cấp, với mật độ nội dung dày đặc nhưng hiếm khi gây ngộp.</p>\r\n<p>Điểm đáng khen nữa là cách FromSoftware xử lý chiều cao và không gian ba chiều. Nhiều khu vực được xếp tầng, chồng lớp lên nhau theo nghĩa đen, buộc bạn phải quan sát kỹ minimap trong đầu, ghi nhớ những cây cầu gãy, vách núi khả nghi hay mái nhà có thể nhảy sang. Land of Shadow là minh chứng cho việc studio đã hoàn toàn làm chủ thiết kế thế giới mở của riêng mình.</p>\r\n \r\n<h2>Hệ Thống Chiến Đấu Được Nâng Cấp</h2>\r\n<p>DLC giới thiệu <strong>nhiều class vũ khí mới</strong> – từ kiếm đôi linh hoạt, côn dài, cho tới những loại vũ khí \"dị\" như thanh kiếm dùng để thi triển thuật máu. Mỗi loại đều có animation và moveset riêng, không hề cho cảm giác tận dụng lại tài nguyên cũ. Kể cả khi bạn đã chán build bleed, strength hay faith trong game gốc, Shadow of the Erdtree vẫn đủ sức khiến bạn muốn lập nhân vật mới chỉ để thử nghiệm lại từ đầu.</p>\r\n<p>Hệ thống <strong>Scadutree Blessing</strong> và <strong>Revered Spirit Ash Blessing</strong> là hai lớp tiến trình song song được thêm vào, cho phép tăng sức mạnh tấn công/phòng thủ của nhân vật và spirit summon khi ở trong Land of Shadow. Đây là một quyết định cực kỳ thông minh: DLC có thể đẩy độ khó lên rất cao, nhưng người chơi cũng luôn có con đường \"overlevel\" hợp lệ thông qua khám phá thay vì chỉ grind rune.</p>\r\n<p>Bên cạnh đó, hàng loạt <strong>Ashes of War, phép thuật và incantation mới</strong> đẩy tính sáng tạo build lên một nấc mới. Từ những chiêu thức biến bạn thành cơn lốc lửa, cho đến khả năng triệu hồi lưỡi kiếm vàng từ trên trời rơi xuống, mỗi skill mới đều mang lại cảm giác \"đã tay\" mà vẫn giữ được tính cân bằng tương đối trong bối cảnh endgame.</p>\r\n \r\n<h2>Những Trận Boss Đáng Nhớ</h2>\r\n<p>Không có DLC nào của FromSoftware mà không được đo bằng chất lượng boss, và Shadow of the Erdtree gần như đặt ra chuẩn mới. Số lượng boss chính và phụ rất dồi dào, nhưng quan trọng hơn là <strong>tỷ lệ boss \"chất lượng cao\"</strong> cực kỳ ấn tượng. Hầu như không có trận đấu nào cho cảm giác filler.</p>\r\n<p><strong>Messmer the Impaler</strong> là đại diện tiêu biểu cho triết lý thiết kế boss mới của FromSoftware: đẹp, ác liệt, rõ ràng trong telegraph nhưng vẫn đủ nhanh để bạn phải tập trung 100%. Những pha chuyển phase kết hợp hiệu ứng hình ảnh, âm nhạc và lore khiến trận đấu này vừa là thử thách kỹ năng, vừa là cao trào cảm xúc.</p>\r\n<p>Các boss phụ cũng được đầu tư kỹ lưỡng. Nhiều encounter tận dụng địa hình dọc, buộc bạn vừa né đòn vừa xử lý platforming; số khác yêu cầu bạn đọc pattern cực chuẩn vì chỉ cần dính một combo là bay nửa thanh máu, kể cả khi đã tối ưu blessing. Một vài trận boss rõ ràng được thiết kế dành riêng cho co-op hoặc build triệu hồi spirit, tạo ra cảm giác phối hợp thú vị hiếm thấy trong các bản Souls trước.</p>\r\n \r\n<h2>Câu Chuyện, Nhân Vật Và Lore</h2>\r\n<p>Shadow of the Erdtree tập trung mạnh vào <strong>hành trình của Miquella</strong> – nhân vật từng chỉ xuất hiện trong những mảnh ghép rời rạc của game gốc. Lần này, FromSoftware cho phép bạn đi theo dấu chân của Miquella qua từng vùng đất, gặp gỡ những tín đồ, kẻ thù và nạn nhân của anh ta. Cách kể chuyện vẫn cực kỳ \"FromSoftware\": không có cutscene dài dòng giải thích mọi thứ, thay vào đó là những câu thoại ngập ẩn dụ, item description đầy gợi mở và môi trường chứa đựng vô số chi tiết nhỏ.</p>\r\n<p>Điều khác biệt là <strong>mạch cảm xúc được đẩy lên rõ rệt</strong>. Nhiều NPC trong DLC có tuyến quest hoàn chỉnh, với kết cục vừa đẹp vừa đắng. Bạn sẽ chứng kiến những nhóm chiến binh tranh đấu vì lý tưởng đối nghịch, những kẻ sẵn sàng tự hủy hoại bản thân để đi theo bước chân Miquella, và cả những con người chỉ đơn giản bị cuốn vào vòng xoáy của thần thánh và chiến tranh.</p>\r\n<p>Đối với những fan lore hardcore, Shadow of the Erdtree là một bữa tiệc: vô số câu hỏi từ game gốc được gợi ý câu trả lời, nhưng FromSoftware vẫn khéo léo giữ lại đủ khoảng trống để cộng đồng tiếp tục tranh luận và phân tích nhiều năm nữa.</p>\r\n \r\n<h2>Đồ Họa, Art Direction Và Âm Thanh</h2>\r\n<p>Về mặt kỹ thuật thuần túy, engine của Elden Ring không đột phá so với thời điểm ra mắt. Tuy nhiên, <strong>art direction</strong> trong Shadow of the Erdtree đạt đến tầm đáng kinh ngạc. Những cánh đồng phủ tro, tường thành đổ nát ngập ánh hoàng hôn, hay thánh địa ẩn sâu trong lòng đất với kiến trúc xoắn ốc… đều tạo nên những khung hình khiến bạn phải dừng lại chỉ để bật Photo Mode chụp vài tấm.</p>\r\n<p>Hiệu năng trên console thế hệ mới ổn định hơn so với bản gốc trong ngày đầu phát hành, đặc biệt ở chế độ Performance. Trên PC, nếu bạn có cấu hình tương đương RTX 3060Ti trở lên, việc duy trì 60 FPS ở thiết lập cao là hoàn toàn khả thi sau một vài bản vá tối ưu.</p>\r\n<p>Âm nhạc tiếp tục là điểm cộng lớn. Từ những bản nhạc nền trầm buồn khi lang thang trong những cánh đồng hoang vắng, cho tới dàn hợp xướng căng như dây đàn trong các trận boss, soundtrack của DLC xứng đáng có vị trí riêng trong playlist của bất kỳ fan game nào. Hiệu ứng âm thanh khi vũ khí va chạm giáp trụ, tiếng gầm của quái vật hay những tràng niệm chú đều góp phần khiến thế giới này trở nên sống động và nặng tính ám ảnh.</p>\r\n \r\n<h2>Thời Lượng Chơi Và Độ Khó</h2>\r\n<p>Với người chơi có kinh nghiệm, tập trung thẳng vào mạch nhiệm vụ chính, bạn vẫn cần khoảng <strong>25–30 giờ</strong> để hoàn tất DLC. Nhưng nếu chọn cách khám phá \"đúng chuẩn Elden Ring\" – nghĩa là rẽ vào mọi ngõ ngách, săn mọi dungeon, làm trọn quest NPC và thử nghiệm build – con số này dễ dàng leo lên <strong>50 giờ</strong> hoặc hơn.</p>\r\n<p>Độ khó là chủ đề gây tranh luận nhiều nhất. <strong>Shadow of the Erdtree được thiết kế rõ ràng cho endgame</strong>: game gần như mặc định rằng bạn đã nắm rất vững combat cơ bản, hiểu rõ invincibility frame của roll/dash và biết cách tối ưu build. Một số spike độ khó ở late game có thể khiến người chơi casual nản lòng, nhưng đối với cộng đồng fan lâu năm, đây lại là \"món chính\" họ chờ đợi.</p>\r\n<p>May mắn là hệ thống blessing mới, cùng với Spirit Ash mạnh mẽ hơn, cho phép bạn tự điều chỉnh đường cong khó khăn. Nếu thấy một boss quá khắc nghiệt, bạn luôn có thể quay ra world map, hoàn thành thêm vài dungeon, nâng cấp blessing và quay lại \"phục thù\".</p>\r\n \r\n<h2>Ai Nên Mua Shadow of the Erdtree?</h2>\r\n<p>Nếu bạn là người chơi đã từng dành hàng chục, thậm chí hàng trăm giờ ở Lands Between, câu trả lời rất đơn giản: <strong>đây là DLC dành cho bạn</strong>. Shadow of the Erdtree mang lại cảm giác trở về một thế giới quen thuộc nhưng với những câu chuyện, thử thách và bí ẩn hoàn toàn mới. Nó cũng là cơ hội tuyệt vời để quay lại nhân vật cũ, hoàn thiện build dang dở hoặc thử những phong cách chơi táo bạo hơn.</p>\r\n<p>Ngược lại, nếu bạn vừa mới chạm tay vào Elden Ring hoặc vẫn đang chật vật với những boss đầu game, DLC này không phải là \"lối tắt\" giúp bạn vượt khó. Nó được thiết kế như một thử thách hậu truyện. Lời khuyên chân thành là hãy hoàn thành phần lớn nội dung game gốc trước khi bước vào Land of Shadow – bạn sẽ trân trọng DLC hơn rất nhiều.</p>\r\n \r\n<h2>Đánh Giá Tổng Kết</h2>\r\n<p><strong>Shadow of the Erdtree</strong> là minh chứng rõ ràng rằng FromSoftware không chỉ biết cách tạo ra kiệt tác, mà còn biết cách mở rộng chúng một cách có ý nghĩa. DLC này hội tụ những gì tinh túy nhất của Elden Ring: khám phá dày đặc, combat có chiều sâu, boss fight đáng nhớ và một thế giới u ám nhưng đầy sức cuốn hút. Nó không cố gắng làm hài lòng tất cả mọi người, nhưng với đối tượng mục tiêu – fan Souls-like – đây gần như là gói nội dung hoàn hảo.</p>\r\n<p>Nếu phải chấm điểm, chúng tôi sẽ dành cho Shadow of the Erdtree <strong>9.8/10</strong>: một bản mở rộng xuất sắc, xứng đáng được nhắc đến trong danh sách những DLC vĩ đại nhất lịch sử game.</p>\r\n \r\n<h2>Ưu Điểm và Nhược Điểm</h2>\r\n<ul>\r\n<li><strong>Ưu điểm:</strong> Thế giới Land of Shadow được thiết kế chặt chẽ, dày đặc nội dung; hệ thống vũ khí, phép thuật và blessing mở rộng chiều sâu build; boss fight ấn tượng, vừa khốc liệt vừa công bằng; art direction và soundtrack đỉnh cao; thời lượng chơi cực lớn cho một DLC.</li>\r\n<li><strong>Nhược điểm:</strong> Độ khó cao, đặc biệt ở late game, có thể khiến người chơi casual nản; yêu cầu đã hoàn thành phần lớn nội dung game gốc để thật sự tận hưởng; hiệu năng trên một số cấu hình PC tầm trung vẫn cần thêm vài bản vá tối ưu.</li>\r\n</ul>', 'http://localhost/gamenews/public/images/uploads/img_69b462c55c86c_1773429445.jpg', '', '', 1, 1, 15427, 'published', 1, 0, '2026-03-11 19:13:47', '2026-03-13 19:13:47', '2026-03-15 17:07:36'),
(42, 'GTA VI Chính Thức Xác Nhận Ngày Ra Mắt – Tất Tần Tật Những Gì Chúng Ta Biết', 'gta-vi-everything-we-know', 'Rockstar Games chính thức công bố ngày phát hành cho tựa game được mong chờ nhất lịch sử. Từ nhân vật nữ chính Lucia cho đến bản đồ lấy cảm hứng từ Florida, đây là mọi thứ bạn cần biết.', '<h2>Thông Báo Chính Thức Từ Rockstar Games</h2>\r\n<p>Sau gần một thập kỷ chờ đợi, vô số tin đồn, hình ảnh rò rỉ, và một trong những trailer được xem nhiều nhất trong lịch sử giải trí, Rockstar Games cuối cùng đã chính thức đóng dấu ngày phát hành lên lịch: <strong>Grand Theft Auto VI sẽ ra mắt vào ngày 26 tháng 5 năm 2026</strong>.</p>\r\n<p>Thông báo được đưa ra thông qua các kênh chính thức của Rockstar và cuộc họp báo cáo tài chính quý của công ty mẹ Take-Two Interactive. Trong vòng vài giờ, tin tức trở thành xu hướng toàn cầu trên mọi nền tảng mạng xã hội lớn, với hàng triệu fan hâm mộ ăn mừng sự kiện mà nhiều người gọi là vụ ra mắt game lớn nhất kể từ khi GTA V ban đầu ra mắt vào năm 2013.</p>\r\n\r\n<h2>Bối Cảnh: Bang Leonida – Nước Mỹ Rực Nắng</h2>\r\n<p>GTA VI lấy bối cảnh tại bang <strong>Leonida</strong> – một vùng đất hư cấu lấy cảm hứng sâu sắc từ <strong>Florida và khu vực đại đô thị Miami</strong> trong đời thực. Từ những con phố rực neon của trung tâm Vice City được tái hiện cho đến vùng đầm lầy hoang dã lấy cảm hứng từ Everglades, Leonida được thiết kế để trở thành một hệ sinh thái sống động, thở theo nhịp thời gian thực.</p>\r\n<p>Bản đồ của GTA VI được cho là <strong>lớn hơn đáng kể</strong> so với Los Santos và Blaine County của GTA V cộng lại. Thế giới game bao gồm nhiều vùng sinh thái đa dạng – từ các trung tâm đô thị sầm uất, bãi biển xa hoa, đến vùng nông thôn hoang sơ, đầm lầy dày đặc, và mọi thứ ở giữa. Nhiều nguồn tin đáng tin cậy cho thấy bản đồ có thể được mở rộng sau khi ra mắt thông qua các bản cập nhật, chiến lược mà Rockstar đã áp dụng thành công với GTA Online.</p>\r\n<p>Rockstar nhấn mạnh rằng thế giới game sẽ có mức độ chi tiết môi trường chưa từng thấy, hệ thống thời tiết động ảnh hưởng đến gameplay, và dân cư NPC được điều khiển bởi AI tiên tiến phản ứng với người chơi và với nhau một cách cực kỳ chân thực.</p>\r\n\r\n<h2>Lucia – Nữ Chính Đầu Tiên Trong Lịch Sử GTA</h2>\r\n<p>Quyết định táo bạo nhất mà Rockstar đưa ra với GTA VI chính là giới thiệu <strong>Lucia</strong> – nhân vật nữ chính đầu tiên trong lịch sử series Grand Theft Auto. Được mô tả là một phụ nữ trẻ gốc Latin bị cuốn vào thế giới ngầm tội phạm của Leonida, câu chuyện của Lucia dường như lấy cảm hứng từ cặp đôi tội phạm huyền thoại Bonnie and Clyde.</p>\r\n<p>Các đoạn trailer đã cho thấy Lucia trong nhiều tình huống căng thẳng – từ những cuộc rượt đuổi tốc độ cao xuyên qua các hành lang neon của Vice City cho đến những cuộc đối đầu đầy kịch tính trong những căn phòng tối. Rockstar có truyền thống tạo ra những nhân vật chính phức tạp, mơ hồ về đạo đức – từ CJ trong San Andreas đến Arthur Morgan trong Red Dead Redemption 2 – và mọi dấu hiệu cho thấy Lucia sẽ là nhân vật tinh tế nhất của họ.</p>\r\n<p>Cấu trúc hai nhân vật chính được gợi ý trong trailer cho thấy người chơi sẽ trải nghiệm câu chuyện từ nhiều góc nhìn – cơ chế đã cực kỳ thành công trong hệ thống ba nhân vật của GTA V. Lần này, hành trình cá nhân của Lucia sẽ đóng vai trò là trụ cột cảm xúc của toàn bộ câu chuyện.</p>\r\n\r\n<h2>Đồ Họa Thế Hệ Mới – Không Thỏa Hiệp</h2>\r\n<p>GTA VI được xây dựng <strong>độc quyền cho phần cứng thế hệ hiện tại</strong> – PlayStation 5 và Xbox Series X|S – không có phiên bản cho máy đời cũ. Quyết định này cho phép Rockstar đẩy giới hạn kỹ thuật của game thế giới mở lên tầm chưa từng có.</p>\r\n<p>Từ những gì đã được công bố, chất lượng hình ảnh thực sự đáng kinh ngạc. Game sử dụng <strong>hệ thống ray tracing tiên tiến</strong> tạo ra ánh sáng chân thực, model nhân vật cực kỳ chi tiết với hoạt ảnh khuôn mặt sống động, và rendering môi trường làm mờ ranh giới giữa game và thực tế. Phản chiếu nước chính xác về mặt vật lý, thảm thực vật đung đưa tự nhiên trong gió, và chu kỳ ngày đêm tạo ra những tâm trạng hoàn toàn khác nhau trên khắp cảnh quan Leonida.</p>\r\n<p>Rockstar sử dụng phiên bản nâng cấp mạnh mẽ của <strong>RAGE engine</strong> – công nghệ độc quyền đằng sau GTA V và Red Dead Redemption 2 – với các pipeline rendering mới, mô phỏng vật lý, và hệ thống AI được thiết kế riêng để tận dụng tốc độ SSD và sức mạnh xử lý của console thế hệ mới.</p>\r\n\r\n<h2>Tương Lai Của GTA Online</h2>\r\n<p>Một trong những câu hỏi lớn nhất xoay quanh GTA VI là tương lai của <strong>GTA Online</strong> – nền tảng multiplayer đã tạo ra hàng tỷ đô la doanh thu kể từ khi ra mắt năm 2013. Rockstar xác nhận GTA VI sẽ bao gồm trải nghiệm online riêng, dù chi tiết cụ thể vẫn còn được giữ kín.</p>\r\n<p>Điều chúng ta biết là GTA Online mới sẽ được xây dựng từ đầu để tận dụng khả năng next-gen. Kỳ vọng số lượng người chơi lớn hơn, chuyển đổi liền mạch giữa các hoạt động, và một thế giới phát triển thay đổi theo thời gian với các bản cập nhật nội dung thường xuyên. GTA Online hiện tại dự kiến tiếp tục hoạt động song song với trải nghiệm mới, ít nhất trong giai đoạn chuyển tiếp.</p>\r\n\r\n<h2>Phản Ứng Của Cộng Đồng</h2>\r\n<p>Phản ứng của cộng đồng game thủ với ngày phát hành chính thức thực sự bùng nổ. Trong vòng vài phút sau thông báo, #GTAVI trending toàn cầu trên X (Twitter), với các bộ đếm ngược, meme, và thread thảo luận tràn ngập mọi ngóc ngách internet.</p>\r\n<p>Forum và subreddit game bùng nổ với sự phấn khích, dù phản ứng không phải không có lo ngại. Một số fan bày tỏ lo lắng về việc chưa có ngày phát hành PC được xác nhận, trong khi những người khác tranh luận liệu game có thể thực sự đáp ứng kỳ vọng khổng lồ đã tích lũy hơn một thập kỷ hay không.</p>\r\n\r\n<h2>Kết Luận</h2>\r\n<p>Với ngày <strong>26 tháng 5 năm 2026</strong> giờ đây được khoanh tròn trên lịch toàn thế giới, cuộc đếm ngược đã chính thức bắt đầu. GTA VI không chỉ là một tựa game – nó là một sự kiện văn hóa, một vitrình công nghệ, và có khả năng là sản phẩm giải trí định nghĩa cả thập kỷ. Dù bạn là fan lâu năm đã lớn lên cùng Liberty City hay là người mới bị cuốn hút bởi lời hứa về những con phố tắm nắng của Leonida, một điều chắc chắn: Rockstar Games đang chuẩn bị mang đến trải nghiệm không giống bất cứ thứ gì ngành công nghiệp từng chứng kiến.</p>', 'http://localhost/gamenews/public/images/uploads/img_69b59c4e026e4_1773509710.webp', '', '', 2, 1, 88239, 'published', 1, 1, '2026-03-12 19:13:47', '2026-03-13 19:13:47', '2026-03-15 19:18:36'),
(43, 'Top Card Đồ Họa Gaming Giá Rẻ Đáng Mua Nhất 2025 – Hướng Dẫn Mua Sắm Chi Tiết', 'best-budget-gaming-gpus-2025', 'Bạn không cần phải chi cả gia tài để chơi game hiện đại ở mức khung hình ổn định. Đây là danh sách card đồ họa giá rẻ đáng mua nhất năm 2025.', '<h2>Lời Mở Đầu</h2>\r\n<p>Thị trường card đồ họa năm 2025 đang trải qua giai đoạn cạnh tranh khốc liệt nhất trong lịch sử. Với việc cả NVIDIA, AMD, và Intel đều tung ra các sản phẩm tầm trung và giá rẻ mới, người tiêu dùng có nhiều lựa chọn hơn bao giờ hết. Nhưng nhiều lựa chọn cũng đồng nghĩa với nhiều sự bối rối. Bài viết này sẽ giúp bạn tìm được chiếc card đồ họa phù hợp nhất với ngân sách và nhu cầu gaming của mình.</p>\r\n\r\n<h2>Tiêu Chí Đánh Giá</h2>\r\n<p>Trước khi đi vào danh sách cụ thể, hãy hiểu rõ các tiêu chí mà chúng tôi sử dụng để đánh giá:</p>\r\n<ul>\r\n<li><strong>Hiệu năng gaming ở 1080p:</strong> Đây là độ phân giải mục tiêu chính cho phân khúc giá rẻ</li>\r\n<li><strong>Giá trị đồng tiền (Price/Performance):</strong> FPS bạn nhận được trên mỗi đồng chi ra</li>\r\n<li><strong>VRAM:</strong> Lượng bộ nhớ video – tối thiểu 8GB cho gaming hiện đại</li>\r\n<li><strong>Tiêu thụ điện:</strong> Card giá rẻ nên tiết kiệm điện, không yêu cầu PSU quá lớn</li>\r\n<li><strong>Phần mềm và driver:</strong> Độ ổn định và tính năng đi kèm</li>\r\n</ul>\r\n\r\n<h2>1. AMD Radeon RX 7600 XT – Vua Giá Rẻ 2025</h2>\r\n<p>Đứng đầu danh sách của chúng tôi chính là <strong>AMD Radeon RX 7600 XT</strong> – chiếc card đồ họa mang lại giá trị tốt nhất trong phân khúc dưới 300 USD. Với <strong>16GB VRAM GDDR6</strong>, đây là lượng bộ nhớ video khổng lồ cho một chiếc card ở mức giá này, đảm bảo bạn không phải lo lắng về việc hết VRAM khi chơi các tựa game hiện đại với texture chất lượng cao.</p>\r\n<p>Trong các bài test gaming của chúng tôi, RX 7600 XT đạt trung bình <strong>75-90 FPS</strong> ở các tựa game AAA mới nhất tại 1080p Ultra. Ở những game nhẹ hơn hoặc khi giảm xuống High settings, con số này dễ dàng vượt mốc 100 FPS. Card tiêu thụ khoảng <strong>150W TDP</strong>, nghĩa là một PSU 550W chất lượng tốt là đủ để vận hành toàn hệ thống.</p>\r\n<p>Phần mềm AMD Adrenalin mang đến các tính năng hữu ích như FSR 3.1 (upscaling AI), Anti-Lag 2 (giảm input lag), và Radeon Chill (tiết kiệm điện). Đây là lựa chọn số 1 của chúng tôi cho gaming 1080p.</p>\r\n\r\n<h2>2. NVIDIA GeForce RTX 4060 – Lựa Chọn An Toàn</h2>\r\n<p>Nếu bạn ưu tiên hệ sinh thái phần mềm và tính năng ray tracing, <strong>RTX 4060</strong> vẫn là lựa chọn vô cùng hấp dẫn. Với kiến trúc Ada Lovelace và <strong>8GB VRAM GDDR6</strong>, card mang đến hiệu năng gaming 1080p tuyệt vời cùng với bộ tính năng đầy đủ của NVIDIA.</p>\r\n<p><strong>DLSS 3.5</strong> là vũ khí bí mật của RTX 4060 – công nghệ upscaling AI của NVIDIA hiện là tốt nhất trên thị trường, giúp tăng FPS đáng kể trong hàng trăm tựa game được hỗ trợ mà gần như không mất chất lượng hình ảnh. Frame Generation có thể gần như nhân đôi FPS trong các game hỗ trợ, biến RTX 4060 thành đối thủ cạnh tranh ngay cả với các card đắt tiền hơn.</p>\r\n<p>Điểm trừ duy nhất là <strong>8GB VRAM</strong> có thể hơi eo hẹp cho một số tựa game trong tương lai. Tuy nhiên, ở thời điểm hiện tại và trong 1-2 năm tới, đây vẫn là đủ cho gaming 1080p.</p>\r\n\r\n<h2>3. Intel Arc B580 – Ngựa Ô Đáng Gờm</h2>\r\n<p>Intel tiếp tục gây bất ngờ với <strong>Arc B580</strong> – chiếc card đồ họa thế hệ Battlemage đã thực sự chứng minh rằng Intel là đối thủ nghiêm túc trong thị trường GPU. Với <strong>12GB VRAM GDDR6</strong> và mức giá chỉ khoảng 250 USD, đây có thể là chiếc card có giá trị tốt nhất trong toàn bộ danh sách.</p>\r\n<p>Hiệu năng của B580 đã cải thiện <strong>vượt bậc</strong> so với thế hệ Alchemist đầu tiên. Driver Intel đã trưởng thành đáng kể, và hầu hết các vấn đề tương thích ban đầu đã được khắc phục. Trong các game DX12 và Vulkan, B580 cạnh tranh trực tiếp với RX 7600 XT ở nhiều tựa game.</p>\r\n<p>Tuy nhiên, hiệu năng trong các game DX11 cũ vẫn là điểm yếu. Nếu bạn chủ yếu chơi các game mới, B580 là lựa chọn tuyệt vời. Nếu bạn chơi nhiều game cũ, hãy cân nhắc AMD hoặc NVIDIA.</p>\r\n\r\n<h2>4. AMD Radeon RX 7600 – Giá Rẻ Nhất Đáng Mua</h2>\r\n<p>Nếu ngân sách thực sự eo hẹp dưới 250 USD, <strong>RX 7600</strong> (bản thường, không phải XT) vẫn là một lựa chọn hoàn toàn hợp lý. Với <strong>8GB VRAM</strong> và hiệu năng đủ để chơi hầu hết game AAA ở 1080p Medium-High settings với 60+ FPS, đây là điểm vào lý tưởng cho người mới build PC gaming.</p>\r\n\r\n<h2>Các Card Nên Tránh</h2>\r\n<p>Trong phân khúc giá rẻ, có một số sản phẩm bạn nên <strong>tuyệt đối tránh</strong>:</p>\r\n<ul>\r\n<li><strong>Card đồ họa cũ không có VRAM đủ:</strong> Bất kỳ card nào dưới 6GB VRAM đều không nên mua mới trong năm 2025</li>\r\n<li><strong>Card mining đã qua sử dụng:</strong> Dù giá rẻ, tuổi thọ và hiệu năng không đảm bảo</li>\r\n<li><strong>GT/GTX series đời cũ:</strong> Rất nhiều cửa hàng vẫn bán GTX 1650, GTX 1050 Ti với giá không hợp lý</li>\r\n</ul>\r\n\r\n<h2>Kết Luận</h2>\r\n<p>Năm 2025 là thời điểm tuyệt vời để mua card đồ họa giá rẻ. Cạnh tranh ba bên giữa AMD, NVIDIA, và Intel đã đẩy giá xuống và hiệu năng lên. <strong>RX 7600 XT</strong> là khuyến nghị hàng đầu của chúng tôi nhờ 16GB VRAM và hiệu năng xuất sắc. <strong>RTX 4060</strong> phù hợp nếu bạn cần DLSS và ray tracing. <strong>Arc B580</strong> là lựa chọn giá trị bất ngờ từ Intel. Dù bạn chọn card nào trong danh sách này, đều đảm bảo trải nghiệm gaming 1080p mượt mà cho nhiều năm tới.</p>', 'http://localhost/gamenews/public/images/uploads/img_69b46355b574a_1773429589.jpg', '', '', 6, 2, 9873, 'published', 0, 0, '2026-03-10 19:13:47', '2026-03-13 19:13:47', '2026-03-15 17:07:39'),
(44, 'Black Myth: Wukong Tung Bản Cập Nhật Khổng Lồ – New Game+, Photo Mode Và Nhiều Hơn Nữa', 'black-myth-wukong-new-update', 'Game Science bất ngờ phát hành bản patch lớn bổ sung chế độ New Game+, Photo Mode, cải thiện hiệu năng đáng kể và nhiều nội dung mới. Tôn Ngộ Không trở lại mạnh mẽ hơn bao giờ hết.', '<h2>Tin Nóng: Bản Cập Nhật Bất Ngờ</h2>\r\n<p>Trong một động thái bất ngờ giữa đêm, <strong>Game Science</strong> đã phát hành bản cập nhật lớn nhất từ trước đến nay cho Black Myth: Wukong – tựa game hành động RPG đình đám lấy cảm hứng từ Tây Du Ký. Bản cập nhật mang đến hàng loạt tính năng được fan mong chờ, đứng đầu là chế độ <strong>New Game+</strong> và <strong>Photo Mode</strong>, cùng với vô số cải thiện về hiệu năng và chất lượng cuộc sống.</p>\r\n<p>Black Myth: Wukong đã là một hiện tượng khi ra mắt, trở thành tựa game Trung Quốc đầu tiên đạt <strong>hơn 20 triệu bản</strong> bán ra toàn cầu và thiết lập kỷ lục người chơi đồng thời trên Steam. Với bản cập nhật này, Game Science chứng minh cam kết hỗ trợ dài hạn cho cộng đồng.</p>\r\n\r\n<h2>New Game+ – Hành Trình Mới, Thử Thách Mới</h2>\r\n<p>Tính năng được mong chờ nhất cuối cùng đã có mặt. <strong>New Game+</strong> cho phép người chơi bắt đầu lại cuộc hành trình với toàn bộ vũ khí, kỹ năng, và trang bị đã thu thập được. Tuy nhiên, đừng nghĩ rằng điều này sẽ khiến game trở nên dễ dàng – kẻ thù và boss được nâng cấp đáng kể về cả sức mạnh lẫn AI.</p>\r\n<p>Game Science đã thiết kế <strong>3 cấp độ New Game+</strong> (NG+, NG++, NG+++), mỗi cấp độ tăng thêm độ khó vượt xa bản gốc. Ở NG+++, các boss có thêm combo mới, phase bổ sung, và HP gấp nhiều lần. Đây thực sự là phần thưởng dành cho những game thủ hardcore muốn thử thách giới hạn kỹ năng.</p>\r\n<p>Đặc biệt, NG+ mở khóa <strong>một số cuộc chiến boss bí mật</strong> không có trong lần chơi đầu tiên. Chúng tôi không muốn spoil, nhưng có thể nói rằng một trong những boss mới này chắc chắn sẽ khiến cộng đồng dậy sóng.</p>\r\n\r\n<h2>Photo Mode – Nghệ Thuật Trong Từng Khung Hình</h2>\r\n<p>Với đồ họa tuyệt đẹp vốn đã là điểm mạnh lớn nhất của Black Myth: Wukong, việc bổ sung <strong>Photo Mode</strong> là điều hoàn toàn hợp lý. Và Game Science đã không làm nửa vời – đây là một trong những Photo Mode toàn diện nhất từng được tích hợp vào game.</p>\r\n<p>Photo Mode cho phép người chơi:</p>\r\n<ul>\r\n<li>Tạm dừng game tại bất kỳ thời điểm nào, kể cả giữa trận boss fight</li>\r\n<li>Di chuyển camera tự do trong phạm vi rộng</li>\r\n<li>Điều chỉnh DOF (độ mờ hậu cảnh), ánh sáng, và bộ lọc màu</li>\r\n<li>Thay đổi biểu cảm và pose của Ngộ Không</li>\r\n<li>Thêm khung viền và logo tùy chỉnh</li>\r\n<li>Xuất ảnh ở độ phân giải lên đến 8K</li>\r\n</ul>\r\n<p>Chỉ trong vài giờ sau khi cập nhật, cộng đồng đã tràn ngập những bức ảnh tuyệt đẹp từ mọi ngóc ngách của thế giới game. Từ những cảnh chiến đấu hoành tráng đến những khoảnh khắc yên bình giữa thiên nhiên, Photo Mode biến mỗi người chơi thành một nhiếp ảnh gia.</p>\r\n\r\n<h2>Cải Thiện Hiệu Năng Toàn Diện</h2>\r\n<p>Một trong những phàn nàn lớn nhất khi game ra mắt là <strong>hiệu năng không ổn định</strong>, đặc biệt trên PC. Bản cập nhật này giải quyết vấn đề một cách triệt để:</p>\r\n<ul>\r\n<li><strong>Tăng 15-25% FPS</strong> trung bình trên hầu hết cấu hình PC</li>\r\n<li>Giảm đáng kể hiện tượng <strong>stutter và micro-stutter</strong></li>\r\n<li>Tối ưu VRAM usage, giúp các card 8GB hoạt động mượt mà hơn nhiều</li>\r\n<li>Ray tracing được tối ưu với chất lượng phản chiếu cải thiện</li>\r\n<li><strong>PS5 Performance Mode</strong> giờ đây ổn định ở 60 FPS trong hầu hết mọi tình huống</li>\r\n<li>Giảm thời gian loading trên cả console lẫn PC</li>\r\n</ul>\r\n<p>Chúng tôi đã test lại trên RTX 4070 ở 1440p Ultra và ghi nhận <strong>mức tăng FPS trung bình 20%</strong>. Đây là cải thiện cực kỳ đáng kể, biến trải nghiệm chơi trở nên mượt mà hơn rất nhiều.</p>\r\n\r\n<h2>Cân Bằng Gameplay và Sửa Lỗi</h2>\r\n<p>Ngoài các tính năng lớn, bản cập nhật còn bao gồm <strong>hàng trăm bản sửa lỗi</strong> và điều chỉnh cân bằng:</p>\r\n<ul>\r\n<li>Một số boss được điều chỉnh hitbox cho công bằng hơn</li>\r\n<li>Các kỹ năng ít được sử dụng được buff để tạo đa dạng build</li>\r\n<li>Thêm các điểm lưu checkpoint ở một số khu vực khó</li>\r\n<li>Sửa lỗi camera trong các không gian hẹp</li>\r\n<li>Cải thiện AI đồng đội trong các section có NPC hỗ trợ</li>\r\n</ul>\r\n\r\n<h2>Tương Lai Của Black Myth</h2>\r\n<p>Game Science cũng nhân dịp này tiết lộ một chút về <strong>kế hoạch tương lai</strong>. Studio xác nhận rằng một <strong>DLC mở rộng</strong> đang được phát triển, dù chưa công bố thời điểm phát hành. Ngoài ra, có tin đồn về một dự án hoàn toàn mới từ Game Science – có khả năng vẫn dựa trên thần thoại Trung Hoa nhưng với bối cảnh và gameplay khác biệt.</p>\r\n<p>Với doanh thu ước tính hơn <strong>1 tỷ USD</strong>, Game Science giờ đây có nguồn lực khổng lồ để theo đuổi tham vọng. Sự thành công của Black Myth: Wukong không chỉ là chiến thắng cho studio mà còn cho toàn bộ ngành game Trung Quốc, chứng minh rằng các studio châu Á hoàn toàn có thể tạo ra những tựa game AAA đẳng cấp thế giới.</p>\r\n\r\n<h2>Kết Luận</h2>\r\n<p>Bản cập nhật này là minh chứng cho cam kết của Game Science với cộng đồng. New Game+ mang đến lý do hoàn hảo để quay lại hành trình, Photo Mode phục vụ khát khao sáng tạo, và cải thiện hiệu năng giải quyết phàn nàn lớn nhất. Nếu bạn đã hoàn thành game và để nó nằm đó, đây chính là thời điểm hoàn hảo để đón Ngộ Không trở lại. Và nếu bạn chưa chơi, giờ là lúc tốt nhất để bắt đầu.</p>', 'http://localhost/gamenews/public/images/uploads/img_69b463c045fd8_1773429696.jpg', '', '', 2, 2, 32115, 'published', 0, 1, '2026-03-13 15:13:47', '2026-03-13 19:13:47', '2026-03-19 14:57:56'),
(45, 'Hướng Dẫn Đánh Tất Cả Boss Trong Hollow Knight – Chiến Thuật Chi Tiết Từ A Đến Z', 'hollow-knight-boss-guide-complete', 'Đang chật vật với những boss tàn nhẫn trong Hollow Knight? Hướng dẫn toàn diện của chúng tôi bao phủ mọi boss trong game với chiến thuật chi tiết, charm phù hợp và mẹo hữu ích.', '<h2>Lời Mở Đầu</h2>\r\n<p>Hollow Knight của Team Cherry là một trong những tựa game Metroidvania hay nhất từng được tạo ra. Với thế giới rộng lớn, gameplay chiến đấu sâu sắc, và hệ thống boss fight được thiết kế tỉ mỉ, game đã chinh phục hàng triệu người chơi trên toàn thế giới. Tuy nhiên, cũng chính những trận boss fight này là nguyên nhân khiến vô số game thủ phải đập bàn phím, ném tay cầm, và thề sẽ không bao giờ chơi lại – trước khi quay lại thử thêm \"một lần nữa\" vài phút sau.</p>\r\n<p>Hướng dẫn này sẽ giúp bạn vượt qua <strong>mọi boss</strong> trong Hollow Knight, từ những boss đầu game dễ nhất đến Absolute Radiance – boss khó nhất game. Mỗi boss sẽ được phân tích chi tiết về: attack pattern, chiến thuật tối ưu, Charm setup khuyến nghị, và những mẹo ít ai biết.</p>\r\n\r\n<h2>Nguyên Tắc Vàng Áp Dụng Cho Mọi Boss</h2>\r\n<p>Trước khi đi vào từng boss cụ thể, hãy nắm vững những nguyên tắc chiến đấu phổ quát sau:</p>\r\n<ul>\r\n<li><strong>Kiên nhẫn là then chốt:</strong> Hollow Knight thưởng cho sự kiên nhẫn. Đừng cố tấn công liên tục – hãy quan sát, tránh né, và chỉ tấn công khi an toàn. Mỗi boss đều có khoảng trống sau các combo – đó là cơ hội của bạn</li>\r\n<li><strong>Học attack pattern:</strong> Mỗi boss có một bộ tấn công cố định. Sau 5-10 lần chết, bạn sẽ bắt đầu nhận ra rhythm. Đây không phải thất bại – đây là quá trình học</li>\r\n<li><strong>Heal thông minh:</strong> Focus để hồi máu cần thời gian. Chỉ heal khi boss ở xa hoặc vừa kết thúc combo dài. Quick Focus charm giúp giảm thời gian heal đáng kể</li>\r\n<li><strong>Pogo Bounce:</strong> Kỹ thuật nhảy lên đầu boss bằng downward slash (nhấn attack + down) là vô cùng hữu ích. Nó vừa gây damage, vừa giữ bạn trên không tránh các đòn ở mặt đất</li>\r\n<li><strong>Shadow Dash là lifesaver:</strong> Ability Shade Cloak cho phép dash xuyên qua kẻ thù và đạn. Nếu bạn chưa có, hãy ưu tiên tìm nó tại Abyss</li>\r\n</ul>\r\n\r\n<h2>Boss Đầu Game – Greenpath & Crossroads</h2>\r\n\r\n<h3>False Knight (Forgotten Crossroads)</h3>\r\n<p><strong>Độ khó: 2/10</strong> – Boss đầu tiên và là bài học nhập môn. False Knight có 3 đòn chính: đập búa xuống đất, đập từ hai bên, và nhảy slam. Cả ba đều có animation dễ nhận biết. Chiến thuật đơn giản nhất: đứng ở khoảng cách vừa đủ, tránh đòn búa, rồi dash vào tấn công 2-3 nhát. Khi nó choáng (lộ ra maggot bên trong), tập trung damage vào đầu.</p>\r\n\r\n<h3>Hornet Protector (Greenpath)</h3>\r\n<p><strong>Độ khó: 4/10</strong> – Trận boss thực sự đầu tiên và là bức tường đầu tiên với nhiều người chơi mới. Hornet nhanh, linh hoạt, và có thể di chuyển khắp arena. Cô ấy có 4 đòn chính: lao đâm ngang, ném kim xoay, tấn công từ trên không, và combo ba đòn. Mẹo quan trọng nhất: <strong>sau mỗi combo 3 đòn, Hornet sẽ dừng lại vài giây để thu hồi kim sợi</strong>. Đây là cửa sổ tấn công lớn nhất. Hãy kiên nhẫn chờ đến moment này thay vì cố tấn công giữa chừng.</p>\r\n\r\n<h2>Boss Trung Game – City of Tears & Crystal Peak</h2>\r\n\r\n<h3>Soul Master (Soul Sanctum)</h3>\r\n<p><strong>Độ khó: 5/10</strong> – Boss gây frustration hàng đầu cho người chơi mới vì có <strong>hai phase với thanh máu đầy đủ</strong>. Phase 1: Soul Master bay lượn và bắn cầu năng lượng. Đứng ở một góc arena, dash qua khi cầu bay tới, tấn công 1-2 nhát khi hắn hạ xuống. Phase 2 (fake death): hắn quay lại hung hãn hơn với đòn slam liên tục. Ở đây, pogo bounce cực kỳ hiệu quả – nhảy lên đầu hắn sau mỗi slam.</p>\r\n\r\n<h3>Crystal Guardian (Crystal Peak)</h3>\r\n<p><strong>Độ khó: 3/10</strong> – Boss tưởng khó nhưng thực ra khá đơn giản nếu biết chiến thuật. Hắn bắn laser ngang – chỉ cần nhảy qua. Khi hắn bắn laser từ trên không, dash sang bên. Liên tục tấn công ở khoảng gần và nhảy tránh laser. Trận này kết thúc nhanh.</p>\r\n\r\n<h2>Boss Khó – Deepnest & Kingdom\'s Edge</h2>\r\n\r\n<h3>Nosk (Deepnest)</h3>\r\n<p><strong>Độ khó: 4/10</strong> – Boss giả dạng chính nhân vật của bạn, creepy nhất game. Nosk có pattern đơn giản nhưng gây damage lớn. Đứng ở giữa arena, khi Nosk lao qua – nhảy lên và pogo. Khi hắn lên trần nhà nhỏ acid – chạy ra xa. Lặp lại cho đến khi thắng.</p>\r\n\r\n<h3>Hornet Sentinel (Kingdom\'s Edge)</h3>\r\n<p><strong>Độ khó: 6/10</strong> – Phiên bản nâng cấp mạnh mẽ của Hornet. Cô ấy nhanh hơn, có thêm bẫy gai, và combo dài hơn. Charm setup khuyến nghị: <strong>Quick Focus + Shaman Stone + Unbreakable Strength</strong>. Chiến thuật tương tự lần gặp đầu nhưng cần phản xạ nhanh hơn nhiều. Dash xuyên qua các đòn bằng Shade Cloak, tấn công sau combo, heal khi cô ấy đặt bẫy.</p>\r\n\r\n<h2>End Game – Những Boss Đáng Sợ Nhất</h2>\r\n\r\n<h3>Nightmare King Grimm</h3>\r\n<p><strong>Độ khó: 9/10</strong> – Một trong những boss khó nhất game. Mọi đòn đều cực nhanh và gây damage lớn. Điểm then chốt: <strong>mỗi đòn của NKG có chính xác 1 cách tránh tối ưu</strong>. Ví dụ: đòn Fire Bats – nhảy qua bóng đầu tiên, dash qua bóng thứ hai; đòn Uppercut – dash lùi; đòn Dive – nhảy lên rồi shadow dash qua. Luyện cho đến khi phản xạ với từng đòn trở thành tự động.</p>\r\n\r\n<h3>Absolute Radiance (Pantheon of Hallownest)</h3>\r\n<p><strong>Độ khó: 10/10</strong> – Boss cuối cùng, khó nhất game. Yêu cầu đánh qua toàn bộ Pantheon 5 (42 boss) không checkpoint. Chiến thuật cần cả một bài viết riêng, nhưng nguyên tắc cốt lõi: platform skill phải hoàn hảo, luôn ưu tiên né tránh trước tấn công, và sử dụng Abyss Shriek spell gây damage khổng lồ trong các cửa sổ an toàn.</p>\r\n\r\n<h2>Charm Setup Khuyến Nghị</h2>\r\n<ul>\r\n<li><strong>Boss nhanh:</strong> Quick Slash + Unbreakable Strength + Mark of Pride + Quick Focus</li>\r\n<li><strong>Boss tanky:</strong> Shaman Stone + Spell Twister + Soul Eater + Quick Focus</li>\r\n<li><strong>Tập luyện:</strong> Hive Blood + Deep Focus + Grubsong + Quick Focus (tự heal theo thời gian)</li>\r\n</ul>\r\n\r\n<h2>Lời Kết</h2>\r\n<p>Hollow Knight là một tựa game thưởng cho sự kiên trì. Mỗi boss tưởng chừng bất khả chiến bại sẽ dần trở nên dễ đọc khi bạn học được pattern. Đừng nản lòng – mỗi lần chết đều là một bài học. Và cảm giác hạ gục được một boss đã khiến bạn chật vật hàng chục lần? Không có gì trong gaming có thể sánh bằng. Chúc bạn may mắn trên hành trình khám phá Hallownest!</p>', 'http://localhost/gamenews/public/images/uploads/img_69b4633c3a26d_1773429564.png', '', '', 4, 2, 7653, 'published', 1, 0, '2026-03-08 19:13:47', '2026-03-13 19:13:47', '2026-03-15 17:07:43');
INSERT INTO `articles` (`article_id`, `title`, `slug`, `summary`, `content`, `thumbnail`, `meta_title`, `meta_description`, `category_id`, `author_id`, `view_count`, `status`, `is_featured`, `is_breaking`, `published_at`, `created_at`, `updated_at`) VALUES
(46, 'Resident Evil Requiem Review – Sự Trở Lại Đầy Ám Ảnh Của Dòng Game Kinh Dị Huyền Thoại', 'resident-evil-requiem-review-s-tr-l-i-y-m-nh-c-a-d-ng-game-kinh-d-huy-n-tho-i', 'Resident Evil Requiem đánh dấu sự trở lại đầy ấn tượng của dòng game kinh dị sinh tồn huyền thoại của Capcom. Với cốt truyện u ám, gameplay căng thẳng và nền đồ họa thế hệ mới, trò chơi mang lại trải nghiệm kinh dị chân thực và hấp dẫn cho cả fan lâu năm lẫn người chơi mới.', '<h2>Resident Evil Requiem Review – Sự Trở Lại Đầy Ám Ảnh Của Dòng Game Kinh Dị Huyền Thoại</h2>\r\n\r\n<p>Trong suốt gần ba thập kỷ tồn tại, dòng game Resident Evil đã trở thành biểu tượng của thể loại kinh dị sinh tồn trong thế giới game. Từ những hành lang lạnh lẽo của biệt thự Spencer cho đến những thành phố bị tàn phá bởi virus sinh học, series này luôn mang lại cho người chơi cảm giác căng thẳng và hồi hộp đặc trưng.</p>\r\n\r\n<p>Với <strong>Resident Evil Requiem</strong>, Capcom tiếp tục mở rộng vũ trụ Resident Evil bằng một câu chuyện mới đầy bí ẩn và u ám. Ra mắt vào ngày <strong>27/02/2026</strong>, trò chơi nhanh chóng nhận được sự chú ý lớn từ cộng đồng game thủ nhờ đồ họa ấn tượng, gameplay cải tiến và bầu không khí kinh dị đặc trưng.</p>\r\n\r\n<p>Resident Evil Requiem không chỉ là một phần tiếp theo đơn thuần mà còn là một bước tiến lớn trong cách Capcom xây dựng trải nghiệm kinh dị hiện đại.</p>\r\n\r\n<h2>Một câu chuyện đen tối và đầy bí ẩn</h2>\r\n\r\n<p>Cốt truyện của Resident Evil Requiem tiếp tục khai thác hậu quả của những thí nghiệm sinh học nguy hiểm – yếu tố cốt lõi đã làm nên thương hiệu Resident Evil trong suốt nhiều năm qua.</p>\r\n\r\n<p>Trò chơi đưa người chơi đến một khu vực bị cô lập sau một sự cố sinh học nghiêm trọng. Những dấu hiệu của thảm họa xuất hiện khắp nơi: các cơ sở nghiên cứu bỏ hoang, những thị trấn bị phong tỏa và những sinh vật đột biến lang thang trong bóng tối.</p>\r\n\r\n<p>Trong hành trình khám phá, người chơi dần phát hiện ra những bí mật liên quan đến các tập đoàn nghiên cứu sinh học, những thí nghiệm thất bại và những âm mưu đen tối chưa từng được tiết lộ.</p>\r\n\r\n<p>Capcom đã rất khéo léo trong việc xây dựng cốt truyện, khi vừa giữ được phong cách quen thuộc của Resident Evil vừa bổ sung nhiều yếu tố mới để khiến câu chuyện trở nên hấp dẫn hơn.</p>\r\n\r\n<h2>Gameplay sinh tồn căng thẳng đúng chất Resident Evil</h2>\r\n\r\n<p>Một trong những điểm mạnh nhất của Resident Evil Requiem chính là gameplay sinh tồn mang tính thử thách cao. Trò chơi buộc người chơi phải cân nhắc kỹ lưỡng từng hành động, từ việc sử dụng đạn dược cho đến cách di chuyển trong môi trường nguy hiểm.</p>\r\n\r\n<p>Tài nguyên trong game khá hạn chế, khiến mỗi viên đạn trở nên quý giá. Người chơi sẽ thường xuyên phải lựa chọn giữa việc chiến đấu trực diện với kẻ thù hoặc tìm cách né tránh để bảo toàn tài nguyên.</p>\r\n\r\n<p>Hệ thống chiến đấu trong Requiem cũng được cải tiến đáng kể với nhiều loại vũ khí mới và cơ chế điều khiển mượt mà hơn. Các trận chiến trở nên kịch tính hơn khi kẻ thù có hành vi thông minh và khó đoán.</p>\r\n\r\n<ul>\r\n<li>Quản lý tài nguyên sinh tồn</li>\r\n<li>Giải đố môi trường phức tạp</li>\r\n<li>Chiến đấu với nhiều loại quái vật mới</li>\r\n<li>Những trận boss đầy thử thách</li>\r\n</ul>\r\n\r\n<p>Sự kết hợp giữa hành động và yếu tố sinh tồn giúp trò chơi luôn giữ được nhịp độ căng thẳng từ đầu đến cuối.</p>\r\n\r\n<h2>Thiết kế môi trường và màn chơi ấn tượng</h2>\r\n\r\n<p>Resident Evil Requiem gây ấn tượng mạnh nhờ cách thiết kế môi trường chi tiết và đầy ám ảnh. Các khu vực trong game được xây dựng với nhiều lớp bí mật và lối đi ẩn, khuyến khích người chơi khám phá kỹ lưỡng.</p>\r\n\r\n<p>Từ những phòng thí nghiệm bỏ hoang cho đến những khu rừng u ám, mỗi địa điểm đều mang lại cảm giác nguy hiểm và bí ẩn. Ánh sáng yếu, hành lang hẹp và những góc tối khiến người chơi luôn cảm thấy bất an.</p>\r\n\r\n<p>Đây chính là yếu tố giúp Resident Evil Requiem duy trì bầu không khí kinh dị đặc trưng của series.</p>\r\n\r\n<h2>Đồ họa thế hệ mới với RE Engine</h2>\r\n\r\n<p>Resident Evil Requiem tiếp tục sử dụng phiên bản nâng cấp của RE Engine – công nghệ đồ họa đã từng được Capcom sử dụng trong nhiều tựa game lớn trước đây.</p>\r\n\r\n<p>Nhờ đó, trò chơi sở hữu chất lượng hình ảnh cực kỳ ấn tượng với mô hình nhân vật chi tiết, hiệu ứng ánh sáng chân thực và môi trường sống động.</p>\r\n\r\n<p>Những chi tiết nhỏ như bụi bay trong không khí, ánh sáng phản chiếu trên bề mặt kim loại hay biểu cảm khuôn mặt của nhân vật đều được tái hiện một cách chân thực.</p>\r\n\r\n<p>Đồ họa không chỉ làm cho trò chơi đẹp hơn mà còn góp phần tăng thêm cảm giác kinh dị và căng thẳng.</p>\r\n\r\n<h2>Âm thanh – yếu tố tạo nên nỗi sợ</h2>\r\n\r\n<p>Nếu đồ họa giúp tạo nên khung cảnh kinh dị thì âm thanh chính là yếu tố khiến người chơi thực sự cảm thấy sợ hãi.</p>\r\n\r\n<p>Resident Evil Requiem sử dụng thiết kế âm thanh cực kỳ tinh tế. Những tiếng động nhỏ trong bóng tối, tiếng bước chân vang vọng trong hành lang hay tiếng gầm gừ của sinh vật đột biến đều được xử lý rất chân thực.</p>\r\n\r\n<p>Nhiều khoảnh khắc trong game khiến người chơi phải dừng lại chỉ để lắng nghe những âm thanh xung quanh trước khi tiếp tục tiến về phía trước.</p>\r\n\r\n<h3>Những điểm nổi bật của Resident Evil Requiem</h3>\r\n\r\n<ul>\r\n<li>Cốt truyện hấp dẫn với nhiều bí ẩn</li>\r\n<li>Gameplay sinh tồn căng thẳng</li>\r\n<li>Đồ họa ấn tượng nhờ RE Engine</li>\r\n<li>Thiết kế màn chơi thông minh</li>\r\n<li>Âm thanh tạo cảm giác kinh dị chân thực</li>\r\n</ul>\r\n\r\n<h2>Những điểm còn hạn chế</h2>\r\n\r\n<p>Mặc dù là một tựa game rất chất lượng, Resident Evil Requiem vẫn tồn tại một vài điểm chưa thực sự hoàn hảo.</p>\r\n\r\n<p>Một số đoạn trong game có nhịp độ khá chậm, đặc biệt là các khu vực tập trung nhiều vào khám phá. Ngoài ra, một số cơ chế gameplay vẫn mang cảm giác quen thuộc đối với fan lâu năm của series.</p>\r\n\r\n<p>Tuy nhiên, những điểm trừ này không ảnh hưởng quá nhiều đến trải nghiệm tổng thể.</p>\r\n\r\n<h2>Đánh giá tổng thể</h2>\r\n\r\n<p>Resident Evil Requiem là một trong những tựa game kinh dị sinh tồn đáng chú ý nhất năm 2026. Capcom đã thành công trong việc kết hợp những yếu tố truyền thống của Resident Evil với những cải tiến hiện đại để tạo nên một trải nghiệm mới mẻ.</p>\r\n\r\n<p>Với cốt truyện hấp dẫn, gameplay căng thẳng và đồ họa ấn tượng, Resident Evil Requiem chắc chắn là một tựa game mà bất kỳ fan của thể loại kinh dị sinh tồn nào cũng nên thử.</p>\r\n\r\n<h2>Kết luận</h2>\r\n\r\n<p>Sau nhiều năm phát triển và đổi mới, Resident Evil Requiem đã chứng minh rằng dòng game Resident Evil vẫn còn rất nhiều tiềm năng để phát triển.</p>\r\n\r\n<p>Đây là một trải nghiệm kinh dị hấp dẫn, đầy căng thẳng và xứng đáng trở thành một trong những tựa game nổi bật của năm 2026.</p>\r\n\r\n<p>Nếu bạn đang tìm kiếm một tựa game mang lại cảm giác hồi hộp và thử thách, Resident Evil Requiem chắc chắn là lựa chọn không nên bỏ lỡ.</p>\r\n', 'http://localhost/gamenews/public/images/uploads/img_69b4657e5a173_1773430142.jpg', 'Resident Evil Requiem Review – Game Kinh Dị Sinh Tồn Đáng Chơi Nhất 2026', 'Review Resident Evil Requiem: cốt truyện u ám, gameplay sinh tồn căng thẳng và đồ họa ấn tượng. Một trong những game kinh dị đáng chú ý nhất năm 2026.', 2, 1, 13, 'published', 1, 1, '2026-03-13 13:29:02', '2026-03-13 19:29:02', '2026-03-19 14:58:02');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `article_tags`
--

CREATE TABLE `article_tags` (
  `id` int(11) NOT NULL,
  `article_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `article_tags`
--

INSERT INTO `article_tags` (`id`, `article_id`, `tag_id`, `created_at`) VALUES
(1, 1, 1, '2026-03-11 06:31:39'),
(2, 1, 15, '2026-03-11 06:31:39'),
(3, 1, 16, '2026-03-11 06:31:39'),
(4, 2, 4, '2026-03-11 06:31:39'),
(5, 2, 16, '2026-03-11 06:31:39'),
(6, 3, 9, '2026-03-11 06:31:39'),
(7, 3, 11, '2026-03-11 06:31:39'),
(8, 3, 17, '2026-03-11 06:31:39'),
(9, 4, 12, '2026-03-11 06:31:39'),
(10, 4, 8, '2026-03-11 06:31:39'),
(11, 4, 16, '2026-03-11 06:31:39'),
(12, 5, 1, '2026-03-11 06:31:39'),
(13, 5, 7, '2026-03-11 06:31:39'),
(14, 5, 19, '2026-03-11 06:31:39'),
(15, 6, 5, '2026-03-11 06:31:39'),
(16, 6, 13, '2026-03-11 06:31:39'),
(17, 6, 10, '2026-03-11 06:31:39'),
(18, 6, 17, '2026-03-11 06:31:39'),
(19, 7, 14, '2026-03-11 06:31:39'),
(20, 7, 17, '2026-03-11 06:31:39'),
(21, 8, 1, '2026-03-11 06:31:39'),
(22, 8, 17, '2026-03-11 06:31:39'),
(23, 9, 1, '2026-03-11 06:31:39'),
(24, 9, 7, '2026-03-11 06:31:39'),
(25, 9, 17, '2026-03-11 06:31:39'),
(26, 10, 1, '2026-03-11 06:31:39'),
(27, 10, 7, '2026-03-11 06:31:39'),
(28, 10, 16, '2026-03-11 06:31:39'),
(29, 11, 5, '2026-03-11 06:31:39'),
(30, 11, 9, '2026-03-11 06:31:39'),
(31, 11, 16, '2026-03-11 06:31:39'),
(32, 12, 1, '2026-03-11 06:31:39'),
(33, 12, 16, '2026-03-11 06:31:39'),
(34, 13, 1, '2026-03-11 06:31:39'),
(35, 13, 7, '2026-03-11 06:31:39'),
(36, 13, 17, '2026-03-11 06:31:39'),
(37, 14, 1, '2026-03-11 06:31:39'),
(38, 14, 17, '2026-03-11 06:31:39'),
(39, 15, 6, '2026-03-11 06:31:39'),
(40, 15, 7, '2026-03-11 06:31:39'),
(41, 15, 16, '2026-03-11 06:31:39'),
(42, 21, 1, '2026-03-11 06:31:39'),
(43, 21, 7, '2026-03-11 06:31:39'),
(44, 21, 18, '2026-03-11 06:31:39'),
(45, 22, 1, '2026-03-11 06:31:39'),
(46, 22, 7, '2026-03-11 06:31:39'),
(47, 22, 18, '2026-03-11 06:31:39'),
(48, 22, 19, '2026-03-11 06:31:39'),
(49, 23, 2, '2026-03-11 06:31:39'),
(50, 23, 18, '2026-03-11 06:31:39'),
(51, 24, 1, '2026-03-11 06:31:39'),
(52, 24, 7, '2026-03-11 06:31:39'),
(53, 24, 18, '2026-03-11 06:31:39'),
(54, 25, 14, '2026-03-11 06:31:39'),
(55, 25, 20, '2026-03-11 06:31:39'),
(56, 25, 18, '2026-03-11 06:31:39'),
(57, 26, 5, '2026-03-11 06:31:39'),
(58, 26, 13, '2026-03-11 06:31:39'),
(59, 26, 10, '2026-03-11 06:31:39'),
(60, 26, 18, '2026-03-11 06:31:39'),
(61, 27, 1, '2026-03-11 06:31:39'),
(62, 27, 7, '2026-03-11 06:31:39'),
(63, 27, 18, '2026-03-11 06:31:39'),
(64, 27, 19, '2026-03-11 06:31:39'),
(65, 28, 6, '2026-03-11 06:31:39'),
(66, 28, 7, '2026-03-11 06:31:39'),
(67, 28, 18, '2026-03-11 06:31:39'),
(68, 29, 5, '2026-03-11 06:31:39'),
(69, 29, 9, '2026-03-11 06:31:39'),
(70, 29, 18, '2026-03-11 06:31:39'),
(71, 30, 1, '2026-03-11 06:31:39'),
(72, 30, 18, '2026-03-11 06:31:39'),
(73, 31, 6, '2026-03-11 06:31:39'),
(74, 31, 18, '2026-03-11 06:31:39'),
(75, 32, 12, '2026-03-11 06:31:39'),
(76, 32, 8, '2026-03-11 06:31:39'),
(77, 32, 20, '2026-03-11 06:31:39'),
(78, 32, 18, '2026-03-11 06:31:39'),
(79, 33, 1, '2026-03-11 06:31:39'),
(80, 33, 18, '2026-03-11 06:31:39'),
(81, 34, 1, '2026-03-11 06:31:39'),
(82, 34, 18, '2026-03-11 06:31:39'),
(83, 35, 6, '2026-03-11 06:31:39'),
(84, 35, 18, '2026-03-11 06:31:39'),
(85, 36, 5, '2026-03-11 06:31:39'),
(86, 36, 9, '2026-03-11 06:31:39'),
(87, 36, 18, '2026-03-11 06:31:39'),
(88, 37, 1, '2026-03-11 06:31:39'),
(89, 37, 18, '2026-03-11 06:31:39'),
(90, 38, 4, '2026-03-11 06:31:39'),
(91, 38, 18, '2026-03-11 06:31:39'),
(92, 39, 1, '2026-03-11 06:31:39'),
(93, 39, 10, '2026-03-11 06:31:39'),
(94, 39, 18, '2026-03-11 06:31:39'),
(95, 40, 8, '2026-03-11 06:31:39'),
(96, 40, 20, '2026-03-11 06:31:39'),
(97, 40, 18, '2026-03-11 06:31:39');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `article_views`
--

CREATE TABLE `article_views` (
  `view_id` int(11) NOT NULL,
  `article_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL COMMENT 'NULL for guest',
  `ip_address` varchar(45) DEFAULT NULL COMMENT 'IP người xem',
  `user_agent` varchar(255) DEFAULT NULL COMMENT 'Browser info',
  `viewed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `bookmarks`
--

CREATE TABLE `bookmarks` (
  `bookmark_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `article_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `bookmarks`
--

INSERT INTO `bookmarks` (`bookmark_id`, `user_id`, `article_id`, `created_at`) VALUES
(30, 1, 44, '2026-03-13 19:22:03'),
(31, 12, 45, '2026-03-14 06:50:48'),
(33, 12, 42, '2026-03-15 08:43:07'),
(34, 1, 46, '2026-03-15 17:03:23'),
(35, 13, 46, '2026-03-18 16:32:52');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `categories`
--

CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(100) NOT NULL,
  `slug` varchar(100) NOT NULL COMMENT 'SEO friendly',
  `description` text DEFAULT NULL,
  `icon` varchar(50) DEFAULT NULL COMMENT 'Font-awesome class',
  `color` varchar(50) DEFAULT NULL COMMENT 'Màu đại diện hex',
  `parent_id` int(11) DEFAULT NULL COMMENT 'FK tự tham chiếu - cho phép cây danh mục',
  `display_order` int(11) DEFAULT 0,
  `is_active` tinyint(4) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `categories`
--

INSERT INTO `categories` (`category_id`, `category_name`, `slug`, `description`, `icon`, `color`, `parent_id`, `display_order`, `is_active`, `created_at`) VALUES
(1, 'Tin Tức Game', 'tin-tuc-game', 'Tin tức mới nhất về thế giới game', 'fa-newspaper', '#E74C3C', NULL, 1, 1, '2026-03-11 13:31:39'),
(2, 'Review Game', 'review-game', 'Đánh giá chi tiết các tựa game', 'fa-star', '#F39C12', NULL, 2, 1, '2026-03-11 13:31:39'),
(3, 'Game PC', 'game-pc', 'Tin tức game dành cho PC', 'fa-desktop', '#2980B9', 1, 1, 1, '2026-03-11 13:31:39'),
(4, 'Game Console', 'game-console', 'PS5, Xbox, Nintendo Switch', 'fa-gamepad', '#1ABC9C', 1, 2, 1, '2026-03-11 13:31:39'),
(5, 'Game Mobile', 'game-mobile', 'Game dành cho điện thoại', 'fa-mobile', '#E67E22', 1, 3, 1, '2026-03-11 13:31:39'),
(6, 'Game Indie', 'game-indie', 'Các tựa game indie độc đáo', 'fa-heart', '#C0392B', 1, 4, 1, '2026-03-11 13:31:39'),
(7, 'Review PC', 'review-pc', 'Đánh giá game PC', 'fa-star-half', '#D35400', 2, 1, 1, '2026-03-11 13:31:39'),
(8, 'Review Mobile', 'review-mobile', 'Đánh giá game mobile', 'fa-mobile-alt', '#7D3C98', 2, 2, 1, '2026-03-11 13:31:39'),
(9, 'Review Console', 'review-console', 'Đánh giá game PS5/Xbox/Switch', 'fa-gamepad', '#117A65', 2, 3, 1, '2026-03-11 13:31:39');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `comments`
--

CREATE TABLE `comments` (
  `comment_id` int(11) NOT NULL,
  `article_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `parent_comment_id` int(11) DEFAULT NULL COMMENT 'NULL for root - Nested comments',
  `content` text NOT NULL,
  `is_approved` tinyint(4) DEFAULT 1,
  `like_count` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `comments`
--

INSERT INTO `comments` (`comment_id`, `article_id`, `user_id`, `parent_comment_id`, `content`, `is_approved`, `like_count`, `created_at`, `updated_at`) VALUES
(37, 46, 12, NULL, 'bài viết rất hay, game chơi rất cuốn, web đẹp', 1, 0, '2026-03-14 06:48:20', NULL),
(38, 44, 12, NULL, 'game hay', 1, 0, '2026-03-15 05:46:36', NULL),
(39, 42, 12, NULL, 'dmm hay vcl', 1, 0, '2026-03-15 08:43:04', NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `media`
--

CREATE TABLE `media` (
  `media_id` int(11) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `file_type` varchar(50) DEFAULT NULL COMMENT 'image - video - document',
  `file_size` int(11) DEFAULT NULL COMMENT 'Kích thước bytes',
  `uploaded_by` int(11) DEFAULT NULL COMMENT 'FK -> users(user_id)',
  `article_id` int(11) DEFAULT NULL COMMENT 'FK -> articles - NULL: chưa gắn bài',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `ratings`
--

CREATE TABLE `ratings` (
  `rating_id` int(11) NOT NULL,
  `article_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `score` tinyint(4) NOT NULL COMMENT '1-5 stars',
  `review` text DEFAULT NULL COMMENT 'Nhận xét chi tiết',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `ratings`
--

INSERT INTO `ratings` (`rating_id`, `article_id`, `user_id`, `score`, `review`, `created_at`, `updated_at`) VALUES
(26, 46, 12, 5, NULL, '2026-03-14 06:48:02', NULL),
(27, 44, 12, 5, NULL, '2026-03-15 05:46:29', NULL),
(28, 42, 12, 5, NULL, '2026-03-15 08:42:58', NULL),
(29, 46, 1, 5, NULL, '2026-03-15 17:02:57', NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `read_history`
--

CREATE TABLE `read_history` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `article_id` int(11) NOT NULL,
  `read_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `read_history`
--

INSERT INTO `read_history` (`id`, `user_id`, `article_id`, `read_at`) VALUES
(1, 12, 44, '2026-03-19 16:08:29'),
(2, 12, 46, '2026-03-19 16:08:45');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `reset_tokens`
--

CREATE TABLE `reset_tokens` (
  `token_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `expires_at` datetime NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `reset_tokens`
--

INSERT INTO `reset_tokens` (`token_id`, `user_id`, `token`, `expires_at`, `created_at`) VALUES
(1, 11, '1d77cfd058b51dbdd398d630e63cfe991b00f03a1d5b8095fddd94919f7dca52', '2026-03-15 20:13:07', '2026-03-15 18:13:07'),
(2, 13, '825fac3c200b9997ab34ecdbad92f9cf08ac09d44a1c0259412e76f86ae1e289', '2026-03-15 20:14:43', '2026-03-15 18:14:43');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `roles`
--

CREATE TABLE `roles` (
  `role_id` int(11) NOT NULL,
  `role_name` varchar(50) NOT NULL COMMENT 'admin - editor - member',
  `description` text DEFAULT NULL,
  `permissions` varchar(255) DEFAULT NULL COMMENT 'JSON permissions',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `roles`
--

INSERT INTO `roles` (`role_id`, `role_name`, `description`, `permissions`, `created_at`) VALUES
(1, 'admin', 'Quản trị viên toàn quyền', '{\"all\":true}', '2026-03-11 13:31:39'),
(2, 'editor', 'Biên tập viên', '{\"articles\":true,\"media\":true}', '2026-03-11 13:31:39'),
(3, 'member', 'Thành viên thông thường', '{\"comment\":true,\"bookmark\":true}', '2026-03-11 13:31:39');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `settings`
--

CREATE TABLE `settings` (
  `setting_id` int(11) NOT NULL,
  `setting_key` varchar(100) NOT NULL,
  `setting_value` text DEFAULT NULL,
  `setting_group` varchar(50) DEFAULT NULL COMMENT 'general - seo - social',
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `settings`
--

INSERT INTO `settings` (`setting_id`, `setting_key`, `setting_value`, `setting_group`, `updated_at`) VALUES
(1, 'site_name', 'GNews – Tin Tức Game', 'general', NULL),
(2, 'site_tagline', 'Nhanh nhất • Chính xác nhất • Đam mê nhất', 'general', NULL),
(3, 'site_url', 'https://gnews.vn', 'general', NULL),
(4, 'admin_email', 'admin@gnews.vn', 'general', NULL),
(5, 'articles_per_page', '10', 'general', NULL),
(6, 'allow_comments', '1', 'general', NULL),
(7, 'meta_keywords', 'tin tức game, review game, genshin, lmht, valorant, pubg mobile', 'seo', NULL),
(8, 'meta_description', 'GNews – Cập nhật tin tức game nhanh nhất và review game chuyên sâu tại Việt Nam', 'seo', NULL),
(9, 'facebook_url', 'https://facebook.com/gnewsvn', 'social', NULL),
(10, 'youtube_url', 'https://youtube.com/@gnewsvn', 'social', NULL),
(11, 'primary_color', '#E74C3C', 'appearance', NULL),
(12, 'logo_url', 'assets/img/logo.png', 'appearance', NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tags`
--

CREATE TABLE `tags` (
  `tag_id` int(11) NOT NULL,
  `tag_name` varchar(50) NOT NULL,
  `slug` varchar(50) NOT NULL,
  `usage_count` int(11) DEFAULT 0 COMMENT 'Số lần sử dụng',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `tags`
--

INSERT INTO `tags` (`tag_id`, `tag_name`, `slug`, `usage_count`, `created_at`) VALUES
(1, 'PC Gaming', 'pc-gaming', 20, '2026-03-11 13:31:39'),
(2, 'PlayStation 5', 'playstation-5', 15, '2026-03-11 13:31:39'),
(3, 'Xbox', 'xbox', 8, '2026-03-11 13:31:39'),
(4, 'Nintendo Switch', 'nintendo-switch', 10, '2026-03-11 13:31:39'),
(5, 'Mobile Game', 'mobile-game', 18, '2026-03-11 13:31:39'),
(6, 'Indie Game', 'indie-game', 10, '2026-03-11 13:31:39'),
(7, 'RPG', 'rpg', 16, '2026-03-11 13:31:39'),
(8, 'FPS', 'fps', 14, '2026-03-11 13:31:39'),
(9, 'MOBA', 'moba', 18, '2026-03-11 13:31:39'),
(10, 'Battle Royale', 'battle-royale', 12, '2026-03-11 13:31:39'),
(11, 'Liên Minh', 'lien-minh', 20, '2026-03-11 13:31:39'),
(12, 'Valorant', 'valorant', 16, '2026-03-11 13:31:39'),
(13, 'PUBG', 'pubg', 12, '2026-03-11 13:31:39'),
(14, 'Genshin Impact', 'genshin-impact', 14, '2026-03-11 13:31:39'),
(15, 'Open World', 'open-world', 12, '2026-03-11 13:31:39'),
(16, 'Game Mới', 'game-moi', 25, '2026-03-11 13:31:39'),
(17, 'Cập Nhật', 'cap-nhat', 22, '2026-03-11 13:31:39'),
(18, 'Review', 'review', 20, '2026-03-11 13:31:39'),
(19, 'DLC', 'dlc', 8, '2026-03-11 13:31:39'),
(20, 'Free to Play', 'free-to-play', 14, '2026-03-11 13:31:39');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `trending_games`
--

CREATE TABLE `trending_games` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `slug` varchar(170) NOT NULL,
  `thumbnail` varchar(500) DEFAULT NULL,
  `article_count` int(11) DEFAULT 0,
  `featured_rank` int(11) DEFAULT 0,
  `is_Active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `trending_games`
--

INSERT INTO `trending_games` (`id`, `name`, `slug`, `thumbnail`, `article_count`, `featured_rank`, `is_Active`, `created_at`, `updated_at`) VALUES
(1, 'Elden Ring', 'elden-ring', NULL, 245, 1, 1, '2026-03-14 16:04:23', '2026-03-14 16:04:23'),
(2, 'Baldur\'s Gate 3', 'baldurs-gate-3', NULL, 187, 2, 1, '2026-03-14 16:04:23', '2026-03-14 16:04:23'),
(3, 'Black Myth: Wukong', 'black-myth-wukong', NULL, 156, 3, 1, '2026-03-14 16:04:23', '2026-03-14 16:04:23'),
(4, 'Dragon Age: Veilguard', 'dragon-age-veilguard', NULL, 98, 4, 1, '2026-03-14 16:04:23', '2026-03-14 16:04:23'),
(5, 'Hades II', 'hades-ii', NULL, 87, 5, 1, '2026-03-14 16:04:23', '2026-03-14 16:04:23');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `upcoming_games`
--

CREATE TABLE `upcoming_games` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `slug` varchar(270) NOT NULL,
  `image` varchar(500) DEFAULT NULL,
  `release_date` date NOT NULL,
  `platform` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `status` enum('upcoming','delayed','cancelled') DEFAULT 'upcoming',
  `is_featured` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `upcoming_games`
--

INSERT INTO `upcoming_games` (`id`, `title`, `slug`, `image`, `release_date`, `platform`, `description`, `status`, `is_featured`, `created_at`, `updated_at`) VALUES
(1, 'Grand Theft Auto VI', 'gta-vi', 'public/images/uploads/games/game_69b59b372da59_1773509431.png', '2026-05-26', 'PlayStation 5, Xbox Series X|S', 'Rockstar Games brings the ultimate open-world crime saga with female protagonist Lucia', 'upcoming', 1, '2026-03-14 15:08:13', '2026-03-14 17:30:31'),
(2, 'Hades II', 'hades-ii', 'public/images/uploads/games/game_69b59a3da5490_1773509181.webp', '2026-09-15', 'PC, PlayStation 5, Xbox Series X|S, Nintendo Switch', 'Supergiant Games returns with the highly anticipated sequel to the indie masterpiece', 'upcoming', 0, '2026-03-14 15:08:13', '2026-03-14 17:28:51'),
(3, 'Fable', 'fable', 'public/images/uploads/games/game_69b59a52bd021_1773509202.jpg', '2026-08-20', 'Xbox Series X|S, PC', 'Playground Games reimagines the legendary fantasy RPG franchise', 'upcoming', 1, '2026-03-14 15:08:13', '2026-03-14 17:33:49'),
(4, 'The Witcher 4', 'witcher-4', 'public/images/uploads/games/game_69b59be3b961e_1773509603.jpg', '2026-11-15', 'PlayStation 5, Xbox Series X|S, PC', 'CD Projekt Red continues the epic saga with a new protagonist in a vast open world', 'upcoming', 1, '2026-03-14 15:08:13', '2026-03-15 17:05:07'),
(5, 'Black Myth: Wukong – Expansion', 'black-myth-wukong-dlc', 'public/images/uploads/games/game_69b59a8c33486_1773509260.jpeg', '2026-06-30', 'PlayStation 5, Xbox Series X|S, PC', 'Game Science announces major DLC content expanding Wukong&#039;s legendary journey', 'upcoming', 0, '2026-03-14 15:08:13', '2026-03-14 17:27:40'),
(6, 'Marvel&amp;#039;s Wolverine', 'marvels-wolverine', 'public/images/uploads/games/game_69b59a0d2a4e8_1773509133.jpg', '2026-10-15', 'PlayStation 5', 'Insomniac Games brings the iconic mutant hero to life in an exclusive PlayStation adventure', 'upcoming', 0, '2026-03-14 15:08:13', '2026-03-15 17:05:02'),
(7, 'Death Stranding 2: On the Beach', 'death-stranding-2', 'public/images/uploads/games/game_69b59a6b0c368_1773509227.webp', '2026-07-10', 'PlayStation 5, PC', 'Kojima Productions delivers the sequel to the genre-defying delivery simulator', 'upcoming', 1, '2026-03-14 15:08:13', '2026-03-14 17:28:44'),
(8, 'Monster Hunter Wilds', 'monster-hunter-wilds', 'public/images/uploads/games/game_69b59a239328e_1773509155.png', '2026-09-28', 'PlayStation 5, Xbox Series X|S, PC', 'Capcom&#039;s monster-hunting adventure reaches new heights with stunning visuals and massive creatures', 'upcoming', 1, '2026-03-14 15:08:13', '2026-03-14 17:25:55');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL COMMENT 'Hashed bcrypt',
  `provider` varchar(20) NOT NULL DEFAULT 'local',
  `full_name` varchar(100) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT 'default.jpg',
  `bio` text DEFAULT NULL COMMENT 'Giới thiệu bản thân',
  `role_id` int(11) DEFAULT 3 COMMENT 'DEFAULT: 3 (member)',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `last_login` timestamp NULL DEFAULT NULL COMMENT 'Lần đăng nhập cuối',
  `is_active` tinyint(4) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`user_id`, `username`, `email`, `password`, `provider`, `full_name`, `avatar`, `bio`, `role_id`, `created_at`, `updated_at`, `last_login`, `is_active`) VALUES
(1, 'admin', 'admin@gamenews.vn', '$2y$10$ZkoWAyAia64O6nj7D.ikJOe8jC8R2aHpTFUC7saAwNpBeI2eqa.QK', 'local', 'Admin GNews', 'admin.jpg', 'Quản trị viên hệ thống GNews.', 1, '2026-03-11 13:31:39', '2026-03-13 07:37:02', '2026-03-11 13:31:39', 1),
(2, 'editor_nam', 'nam@gamenews.vn', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'local', 'Trần Minh Nam', 'nam.jpg', 'Biên tập viên chuyên game PC & Console. 5 năm kinh nghiệm.', 2, '2026-03-11 13:31:39', NULL, '2026-03-11 13:31:39', 1),
(3, 'editor_lan', 'lan@gamenews.vn', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'local', 'Nguyễn Thị Lan', 'lan.jpg', 'Biên tập viên mảng Mobile Game & Esports Việt Nam.', 2, '2026-03-11 13:31:39', NULL, '2026-03-11 13:31:39', 1),
(4, 'editor_hung', 'hung@gamenews.vn', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'local', 'Lê Văn Hùng', 'hung.jpg', 'Chuyên gia phân tích RPG và game chiến thuật.', 2, '2026-03-11 13:31:39', NULL, '2026-03-11 13:31:39', 1),
(5, 'gamer_pro', 'pro@gmail.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'local', 'Phạm Quốc Huy', 'user5.jpg', 'Game thủ PC hardcore. Yêu thích FPS và MOBA.', 3, '2026-03-11 13:31:39', NULL, '2026-03-11 13:31:39', 1),
(6, 'lmht_fan', 'lmht@gmail.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'local', 'Đặng Văn Tú', 'user6.jpg', 'Main Yasuo LMHT, rank Cao Thủ server VN.', 3, '2026-03-11 13:31:39', NULL, '2026-03-11 13:31:39', 1),
(7, 'pubg_vn', 'pubg@gmail.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'local', 'Bùi Thị Mai', 'user7.jpg', 'Top 10 PUBG Việt Nam, streamer part-time.', 3, '2026-03-11 13:31:39', NULL, '2026-03-11 13:31:39', 1),
(8, 'console_guy', 'console@gmail.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'local', 'Phan Thị Ngọc', 'user8.jpg', 'PS5 player. Chuyên game Action-Adventure.', 3, '2026-03-11 13:31:39', NULL, '2026-03-11 13:31:39', 1),
(9, 'rpg_nerd', 'rpg@gmail.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'local', 'Nguyễn Minh Tuấn', 'user9.jpg', 'RPG lover, đã chơi qua 200+ tựa game nhập vai.', 3, '2026-03-11 13:31:39', NULL, '2026-03-11 13:31:39', 1),
(10, 'genshin_fan', 'genshin@gmail.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'local', 'Lý Thị Kim', 'user10.jpg', 'Genshin Impact từ ngày đầu ra mắt, AR 60.', 3, '2026-03-11 13:31:39', NULL, '2026-03-11 13:31:39', 1),
(11, 'phuclq199', 'phuclq199@gmail.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'local', NULL, 'default.jpg', NULL, 2, '2026-03-13 06:46:10', '2026-03-13 07:18:27', NULL, 1),
(12, 'phuc123', 'phuc123@gmail.com', '$2y$10$OsxMaq9YCFSSFNMSXQUoRu8aVPSWSPq/rJkOE0igemGEjGJM3X9zm', 'local', 'phuc123@gmail.com', 'http://localhost/gamenews/public/images/uploads/avatars/avatar_12_1773932237.png', NULL, 3, '2026-03-13 13:01:35', '2026-03-19 16:09:30', NULL, 1),
(13, 'phuc1234', 'hotrongphuc822020@gmail.com', '$2y$10$FUfZ9SJQSiDJSJJnLkCPMOpSf8OtHe65x.HtI6h09kWS.jxczDWBW', 'local', NULL, 'default.jpg', NULL, 3, '2026-03-15 18:14:21', NULL, NULL, 1);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `fk_log_user` (`user_id`);

--
-- Chỉ mục cho bảng `articles`
--
ALTER TABLE `articles`
  ADD PRIMARY KEY (`article_id`),
  ADD UNIQUE KEY `uk_article_slug` (`slug`),
  ADD KEY `fk_article_author` (`author_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_category` (`category_id`),
  ADD KEY `idx_is_featured` (`is_featured`),
  ADD KEY `idx_is_breaking` (`is_breaking`),
  ADD KEY `idx_published_at` (`published_at`),
  ADD KEY `idx_view_count` (`view_count`);

--
-- Chỉ mục cho bảng `article_tags`
--
ALTER TABLE `article_tags`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_article_tag` (`article_id`,`tag_id`),
  ADD KEY `fk_at_tag` (`tag_id`);

--
-- Chỉ mục cho bảng `article_views`
--
ALTER TABLE `article_views`
  ADD PRIMARY KEY (`view_id`),
  ADD KEY `fk_view_article` (`article_id`),
  ADD KEY `fk_view_user` (`user_id`);

--
-- Chỉ mục cho bảng `bookmarks`
--
ALTER TABLE `bookmarks`
  ADD PRIMARY KEY (`bookmark_id`),
  ADD UNIQUE KEY `uk_bookmark` (`user_id`,`article_id`),
  ADD KEY `fk_bookmark_article` (`article_id`),
  ADD KEY `idx_user_bookmark` (`user_id`);

--
-- Chỉ mục cho bảng `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`),
  ADD UNIQUE KEY `uk_category_name` (`category_name`),
  ADD UNIQUE KEY `uk_category_slug` (`slug`),
  ADD KEY `fk_category_parent` (`parent_id`);

--
-- Chỉ mục cho bảng `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`comment_id`),
  ADD KEY `fk_comment_user` (`user_id`),
  ADD KEY `fk_comment_parent` (`parent_comment_id`),
  ADD KEY `idx_article_approved` (`article_id`,`is_approved`);

--
-- Chỉ mục cho bảng `media`
--
ALTER TABLE `media`
  ADD PRIMARY KEY (`media_id`),
  ADD KEY `fk_media_user` (`uploaded_by`),
  ADD KEY `fk_media_article` (`article_id`);

--
-- Chỉ mục cho bảng `ratings`
--
ALTER TABLE `ratings`
  ADD PRIMARY KEY (`rating_id`),
  ADD UNIQUE KEY `uk_rating` (`article_id`,`user_id`),
  ADD KEY `fk_rating_user` (`user_id`),
  ADD KEY `idx_article_rating` (`article_id`);

--
-- Chỉ mục cho bảng `read_history`
--
ALTER TABLE `read_history`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_read` (`user_id`,`article_id`),
  ADD KEY `article_id` (`article_id`),
  ADD KEY `idx_user_read` (`user_id`),
  ADD KEY `idx_read_at` (`read_at`);

--
-- Chỉ mục cho bảng `reset_tokens`
--
ALTER TABLE `reset_tokens`
  ADD PRIMARY KEY (`token_id`),
  ADD UNIQUE KEY `token` (`token`),
  ADD KEY `idx_token` (`token`),
  ADD KEY `idx_user` (`user_id`),
  ADD KEY `idx_expires` (`expires_at`);

--
-- Chỉ mục cho bảng `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`role_id`),
  ADD UNIQUE KEY `uk_role_name` (`role_name`);

--
-- Chỉ mục cho bảng `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`setting_id`),
  ADD UNIQUE KEY `uk_setting_key` (`setting_key`);

--
-- Chỉ mục cho bảng `tags`
--
ALTER TABLE `tags`
  ADD PRIMARY KEY (`tag_id`),
  ADD UNIQUE KEY `uk_tag_name` (`tag_name`),
  ADD UNIQUE KEY `uk_tag_slug` (`slug`);

--
-- Chỉ mục cho bảng `trending_games`
--
ALTER TABLE `trending_games`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `idx_featured_rank` (`featured_rank`),
  ADD KEY `idx_active` (`is_Active`);

--
-- Chỉ mục cho bảng `upcoming_games`
--
ALTER TABLE `upcoming_games`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `idx_release_date` (`release_date`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_featured` (`is_featured`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `uk_username` (`username`),
  ADD UNIQUE KEY `uk_email` (`email`),
  ADD KEY `fk_user_role` (`role_id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `activity_logs`
--
ALTER TABLE `activity_logs`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=91;

--
-- AUTO_INCREMENT cho bảng `articles`
--
ALTER TABLE `articles`
  MODIFY `article_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT cho bảng `article_tags`
--
ALTER TABLE `article_tags`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=98;

--
-- AUTO_INCREMENT cho bảng `article_views`
--
ALTER TABLE `article_views`
  MODIFY `view_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `bookmarks`
--
ALTER TABLE `bookmarks`
  MODIFY `bookmark_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT cho bảng `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT cho bảng `comments`
--
ALTER TABLE `comments`
  MODIFY `comment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT cho bảng `media`
--
ALTER TABLE `media`
  MODIFY `media_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `ratings`
--
ALTER TABLE `ratings`
  MODIFY `rating_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT cho bảng `read_history`
--
ALTER TABLE `read_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `reset_tokens`
--
ALTER TABLE `reset_tokens`
  MODIFY `token_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `roles`
--
ALTER TABLE `roles`
  MODIFY `role_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `settings`
--
ALTER TABLE `settings`
  MODIFY `setting_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT cho bảng `tags`
--
ALTER TABLE `tags`
  MODIFY `tag_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT cho bảng `trending_games`
--
ALTER TABLE `trending_games`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `upcoming_games`
--
ALTER TABLE `upcoming_games`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD CONSTRAINT `fk_log_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `articles`
--
ALTER TABLE `articles`
  ADD CONSTRAINT `fk_article_author` FOREIGN KEY (`author_id`) REFERENCES `users` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_article_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `article_tags`
--
ALTER TABLE `article_tags`
  ADD CONSTRAINT `fk_at_article` FOREIGN KEY (`article_id`) REFERENCES `articles` (`article_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_at_tag` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`tag_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `article_views`
--
ALTER TABLE `article_views`
  ADD CONSTRAINT `fk_view_article` FOREIGN KEY (`article_id`) REFERENCES `articles` (`article_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_view_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `bookmarks`
--
ALTER TABLE `bookmarks`
  ADD CONSTRAINT `fk_bookmark_article` FOREIGN KEY (`article_id`) REFERENCES `articles` (`article_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_bookmark_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `fk_category_parent` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`category_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `fk_comment_article` FOREIGN KEY (`article_id`) REFERENCES `articles` (`article_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_comment_parent` FOREIGN KEY (`parent_comment_id`) REFERENCES `comments` (`comment_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_comment_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `media`
--
ALTER TABLE `media`
  ADD CONSTRAINT `fk_media_article` FOREIGN KEY (`article_id`) REFERENCES `articles` (`article_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_media_user` FOREIGN KEY (`uploaded_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `ratings`
--
ALTER TABLE `ratings`
  ADD CONSTRAINT `fk_rating_article` FOREIGN KEY (`article_id`) REFERENCES `articles` (`article_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_rating_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `read_history`
--
ALTER TABLE `read_history`
  ADD CONSTRAINT `read_history_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `read_history_ibfk_2` FOREIGN KEY (`article_id`) REFERENCES `articles` (`article_id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `reset_tokens`
--
ALTER TABLE `reset_tokens`
  ADD CONSTRAINT `reset_tokens_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_user_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
