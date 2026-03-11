-- ============================================================
--  DỮ LIỆU MẪU - WEB TIN TỨC GAME (Phiên bản gọn)
--  Tập trung: Tin Tức Game + Review Game
--  ~40 bài viết | Đủ để demo đồ án
-- ============================================================

USE online_news_db;

-- Xóa dữ liệu cũ theo đúng thứ tự FK (bảng con trước, bảng cha sau)
SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM activity_logs;
DELETE FROM article_tags;
DELETE FROM bookmarks;
DELETE FROM ratings;
DELETE FROM comments;
DELETE FROM article_views;
DELETE FROM media;
DELETE FROM articles;
DELETE FROM tags;
DELETE FROM categories;
DELETE FROM users;
DELETE FROM roles;
DELETE FROM settings;
ALTER TABLE activity_logs  AUTO_INCREMENT = 1;
ALTER TABLE article_tags   AUTO_INCREMENT = 1;
ALTER TABLE bookmarks      AUTO_INCREMENT = 1;
ALTER TABLE ratings        AUTO_INCREMENT = 1;
ALTER TABLE comments       AUTO_INCREMENT = 1;
ALTER TABLE article_views  AUTO_INCREMENT = 1;
ALTER TABLE media          AUTO_INCREMENT = 1;
ALTER TABLE articles       AUTO_INCREMENT = 1;
ALTER TABLE tags           AUTO_INCREMENT = 1;
ALTER TABLE categories     AUTO_INCREMENT = 1;
ALTER TABLE users          AUTO_INCREMENT = 1;
ALTER TABLE roles          AUTO_INCREMENT = 1;
ALTER TABLE settings       AUTO_INCREMENT = 1;
SET FOREIGN_KEY_CHECKS = 1;

-- ============================================================
-- 1. ROLES
-- ============================================================
INSERT INTO roles (role_id, role_name, description, permissions) VALUES
(1, 'admin',  'Quản trị viên toàn quyền',  '{"all":true}'),
(2, 'editor', 'Biên tập viên',              '{"articles":true,"media":true}'),
(3, 'member', 'Thành viên thông thường',    '{"comment":true,"bookmark":true}');

-- ============================================================
-- 2. USERS (3 editor + 7 member = 10 người)
-- ============================================================
INSERT INTO users (user_id, username, email, password, full_name, avatar, bio, role_id, is_active, last_login) VALUES
(1, 'admin',      'admin@gamenews.vn',   '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Admin GNews',    'admin.jpg',   'Quản trị viên hệ thống GNews.',                          1, 1, NOW()),
(2, 'editor_nam', 'nam@gamenews.vn',     '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Trần Minh Nam',  'nam.jpg',     'Biên tập viên chuyên game PC & Console. 5 năm kinh nghiệm.', 2, 1, NOW()),
(3, 'editor_lan', 'lan@gamenews.vn',     '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Nguyễn Thị Lan', 'lan.jpg',     'Biên tập viên mảng Mobile Game & Esports Việt Nam.',     2, 1, NOW()),
(4, 'editor_hung','hung@gamenews.vn',    '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Lê Văn Hùng',   'hung.jpg',    'Chuyên gia phân tích RPG và game chiến thuật.',          2, 1, NOW()),
(5, 'gamer_pro',  'pro@gmail.com',       '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Phạm Quốc Huy', 'user5.jpg',   'Game thủ PC hardcore. Yêu thích FPS và MOBA.',           3, 1, NOW()),
(6, 'lmht_fan',   'lmht@gmail.com',      '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Đặng Văn Tú',   'user6.jpg',   'Main Yasuo LMHT, rank Cao Thủ server VN.',               3, 1, NOW()),
(7, 'pubg_vn',    'pubg@gmail.com',      '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Bùi Thị Mai',   'user7.jpg',   'Top 10 PUBG Việt Nam, streamer part-time.',              3, 1, NOW()),
(8, 'console_guy','console@gmail.com',   '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Phan Thị Ngọc', 'user8.jpg',   'PS5 player. Chuyên game Action-Adventure.',              3, 1, NOW()),
(9, 'rpg_nerd',   'rpg@gmail.com',       '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Nguyễn Minh Tuấn','user9.jpg', 'RPG lover, đã chơi qua 200+ tựa game nhập vai.',         3, 1, NOW()),
(10,'genshin_fan','genshin@gmail.com',   '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Lý Thị Kim',    'user10.jpg',  'Genshin Impact từ ngày đầu ra mắt, AR 60.',              3, 1, NOW());

-- ============================================================
-- 3. CATEGORIES
-- ============================================================
INSERT INTO categories (category_id, category_name, slug, description, icon, color, parent_id, display_order, is_active) VALUES
-- Cha
(1, 'Tin Tức Game',  'tin-tuc-game',  'Tin tức mới nhất về thế giới game',      'fa-newspaper', '#E74C3C', NULL, 1, 1),
(2, 'Review Game',   'review-game',   'Đánh giá chi tiết các tựa game',         'fa-star',      '#F39C12', NULL, 2, 1),
-- Con của Tin Tức
(3, 'Game PC',       'game-pc',       'Tin tức game dành cho PC',               'fa-desktop',   '#2980B9', 1,   1, 1),
(4, 'Game Console',  'game-console',  'PS5, Xbox, Nintendo Switch',             'fa-gamepad',   '#1ABC9C', 1,   2, 1),
(5, 'Game Mobile',   'game-mobile',   'Game dành cho điện thoại',               'fa-mobile',    '#E67E22', 1,   3, 1),
(6, 'Game Indie',    'game-indie',    'Các tựa game indie độc đáo',             'fa-heart',     '#C0392B', 1,   4, 1),
-- Con của Review
(7, 'Review PC',     'review-pc',     'Đánh giá game PC',                       'fa-star-half', '#D35400', 2,   1, 1),
(8, 'Review Mobile', 'review-mobile', 'Đánh giá game mobile',                   'fa-mobile-alt','#7D3C98', 2,   2, 1),
(9, 'Review Console','review-console','Đánh giá game PS5/Xbox/Switch',          'fa-gamepad',   '#117A65', 2,   3, 1);

-- ============================================================
-- 4. TAGS
-- ============================================================
INSERT INTO tags (tag_id, tag_name, slug, usage_count) VALUES
(1,  'PC Gaming',      'pc-gaming',      20),
(2,  'PlayStation 5',  'playstation-5',  15),
(3,  'Xbox',           'xbox',            8),
(4,  'Nintendo Switch','nintendo-switch', 10),
(5,  'Mobile Game',    'mobile-game',    18),
(6,  'Indie Game',     'indie-game',     10),
(7,  'RPG',            'rpg',            16),
(8,  'FPS',            'fps',            14),
(9,  'MOBA',           'moba',           18),
(10, 'Battle Royale',  'battle-royale',  12),
(11, 'Liên Minh',      'lien-minh',      20),
(12, 'Valorant',       'valorant',       16),
(13, 'PUBG',           'pubg',           12),
(14, 'Genshin Impact', 'genshin-impact', 14),
(15, 'Open World',     'open-world',     12),
(16, 'Game Mới',       'game-moi',       25),
(17, 'Cập Nhật',       'cap-nhat',       22),
(18, 'Review',         'review',         20),
(19, 'DLC',            'dlc',             8),
(20, 'Free to Play',   'free-to-play',   14);

-- ============================================================
-- 5. ARTICLES (20 Tin Tức + 20 Review = 40 bài)
-- ============================================================
INSERT INTO articles
  (article_id, title, slug, summary, content, thumbnail,
   meta_title, meta_description,
   category_id, author_id, view_count, status,
   is_featured, is_breaking, published_at)
VALUES

-- ══════════════════════════════════════════════
-- NHÓM A: TIN TỨC GAME (20 bài)
-- ══════════════════════════════════════════════

(1,
 'GTA VI chính thức xác nhận ngày ra mắt: 26 tháng 5 năm 2026',
 'gta-vi-ngay-ra-mat-2026',
 'Rockstar Games xác nhận GTA VI ra mắt ngày 26/5/2026 trên PS5 và Xbox Series X/S với nhân vật nữ chính đầu tiên trong series.',
 '<h2>GTA VI – Bom tấn 2026</h2>
<p>Sau nhiều năm chờ đợi, Rockstar Games chính thức xác nhận <strong>GTA VI sẽ ra mắt ngày 26/5/2026</strong> trên PS5 và Xbox Series X/S.</p>
<p>Nhân vật chính Lucia trở thành nữ nhân vật đầu tiên trong series GTA chính. Cô cùng đồng phạm Jason hoạt động ở Leonida – phiên bản hư cấu của bang Florida.</p>
<h3>Điểm nổi bật:</h3>
<ul>
  <li>Bản đồ rộng gấp đôi GTA V</li>
  <li>Đồ họa Unreal Engine 5 thế hệ mới</li>
  <li>AI NPC hoạt động thực tế hơn bao giờ hết</li>
  <li>GTA Online 2 ra mắt sau 6 tháng</li>
</ul>
<p>Phiên bản PC chưa có ngày ra mắt chính thức nhưng dự kiến sau 6–12 tháng.</p>',
 'gta6-cover.jpg',
 'GTA VI ngày ra mắt chính thức 26/5/2026',
 'Rockstar xác nhận GTA VI ra mắt 26/5/2026 trên PS5 và Xbox Series X/S.',
 3, 2, 125840, 'published', 1, 1, '2026-01-15 08:00:00'),

(2,
 'Nintendo Switch 2 – Tất cả thông tin chính thức trước ngày ra mắt',
 'nintendo-switch-2-thong-tin-chinh-thuc',
 'Nintendo xác nhận Switch 2 với màn hình lớn hơn, Joy-Con nam châm mới và khả năng chơi 4K khi dock.',
 '<h2>Nintendo Switch 2 – Mọi thứ bạn cần biết</h2>
<p>Nintendo chính thức ra mắt Switch 2 sau 7 năm từ thế hệ đầu. Máy được nâng cấp toàn diện về phần cứng lẫn tính năng.</p>
<h3>Thông số chính:</h3>
<ul>
  <li>Màn hình 8 inch LCD lớn hơn, viền mỏng hơn</li>
  <li>Joy-Con kết nối nam châm – gắn chắc hơn, không còn drift</li>
  <li>Chip mới hỗ trợ 4K khi cắm dock, 1080p khi cầm tay</li>
  <li>Tương thích ngược toàn bộ game Switch 1</li>
  <li>Giá dự kiến: 449 USD</li>
</ul>',
 'switch2-announce.jpg',
 'Nintendo Switch 2 thông tin chính thức',
 'Tất cả thông tin về Nintendo Switch 2 trước ngày ra mắt.',
 4, 4, 92150, 'published', 1, 1, '2025-07-01 09:00:00'),

(3,
 'Liên Minh Huyền Thoại mùa 2025 – Riot Games công bố những thay đổi lớn',
 'lmht-mua-2025-thay-doi-lon',
 'Riot Games công bố toàn bộ thay đổi lớn LMHT mùa 2025: map mới, cơ chế drake mới, hệ thống rank cải tiến.',
 '<h2>LMHT Mùa 2025 – Revolution</h2>
<p>Đây là bản cập nhật lớn nhất LMHT kể từ 2012. Riot thay đổi gần như mọi thứ từ map đến hệ thống rank.</p>
<h3>Thay đổi lớn nhất:</h3>
<ul>
  <li><strong>Map Summoner Rift:</strong> Thêm khu vực mới phía trên Drake pit</li>
  <li><strong>Void Drake:</strong> Loại drake thứ 6 hoàn toàn mới</li>
  <li><strong>Rank mới:</strong> Thêm hạng Emerald giữa Platinum và Diamond</li>
  <li><strong>Objective Atakhan:</strong> Boss mới xuất hiện giữa trận</li>
</ul>',
 'lmht-2025-update.jpg',
 'LMHT mùa 2025 thay đổi lớn nhất lịch sử',
 'Riot Games công bố toàn bộ thay đổi lớn LMHT mùa 2025.',
 3, 3, 98750, 'published', 1, 1, '2025-11-15 08:00:00'),

(4,
 'Valorant Episode 10 – Agent mới Tejo và map Abyss',
 'valorant-episode-10-tejo-abyss',
 'Riot Games ra mắt Valorant Episode 10 với Tejo – Initiator người Colombia – và map Abyss hoàn toàn mới không có rào cản.',
 '<h2>Valorant Episode 10 – Đầu năm mới nhiều bất ngờ</h2>
<p>Episode 10 mang đến Agent thứ 26 tên <strong>Tejo</strong> – một Initiator với gadget công nghệ cao từ Colombia.</p>
<h3>Kỹ năng của Tejo:</h3>
<ul>
  <li><strong>Stealth Drone (Q):</strong> Drone trinh sát tàng hình</li>
  <li><strong>Guided Salvo (E):</strong> Phóng tên lửa điều khiển</li>
  <li><strong>Ultimate – Armageddon:</strong> Gọi không kích diện rộng</li>
</ul>
<p>Map Abyss đặc biệt ở chỗ hoàn toàn không có tường bao quanh – rơi xuống biên là chết ngay.</p>',
 'valorant-ep10.jpg',
 'Valorant Episode 10 Agent Tejo và map Abyss',
 'Valorant Episode 10 ra mắt Agent Tejo và map Abyss.',
 3, 3, 75320, 'published', 1, 0, '2025-10-22 10:00:00'),

(5,
 'Elden Ring DLC Shadow of the Erdtree – 6 tháng nhìn lại',
 'elden-ring-dlc-shadow-6-thang',
 'DLC lớn nhất lịch sử FromSoftware đã ra mắt 6 tháng với hơn 10 triệu bản bán ra. Cộng đồng nói gì?',
 '<h2>Shadow of the Erdtree – Nửa năm nhìn lại</h2>
<p>6 tháng sau khi ra mắt, Shadow of the Erdtree vẫn là chủ đề được bàn luận sôi nổi nhất trong cộng đồng game.</p>
<h3>Con số ấn tượng:</h3>
<ul>
  <li>10 triệu bản bán ra trong tháng đầu</li>
  <li>DLC bán chạy nhất lịch sử FromSoftware</li>
  <li>Điểm Metacritic: 94/100</li>
  <li>Hơn 200 giờ stream trên Twitch ngày ra mắt</li>
</ul>
<p>Boss Messmer the Impaler được bình chọn là boss hay nhất trong toàn bộ Elden Ring.</p>',
 'er-dlc-shadow.jpg',
 'Elden Ring DLC Shadow of the Erdtree 6 tháng',
 'Nhìn lại DLC Shadow of the Erdtree sau 6 tháng ra mắt.',
 3, 2, 89320, 'published', 1, 0, '2025-12-10 10:00:00'),

(6,
 'PUBG Mobile Season 20 – Bản đồ mới Rondo và vũ khí huyền thoại',
 'pubg-mobile-season-20-rondo',
 'PUBG Mobile Season 20 ra mắt với bản đồ Rondo 8x8km, vũ khí SMG mới PP-19 Bizon và Royal Pass cực hot.',
 '<h2>PUBG Mobile Season 20 – Rondo Map</h2>
<p>Krafton mang đến bản đồ hoàn toàn mới lấy cảm hứng từ đô thị châu Á hiện đại.</p>
<h3>Điểm mới nổi bật:</h3>
<ul>
  <li>Rondo Map: 8x8km với trung tâm thành phố dày đặc</li>
  <li>PP-19 Bizon: SMG mới với băng đạn 53 viên</li>
  <li>Vehicle mới: Motor Glider phiên bản 2 chỗ</li>
  <li>Royal Pass Season 20: Theme Neon City</li>
</ul>',
 'pubg-s20-rondo.jpg',
 'PUBG Mobile Season 20 bản đồ Rondo',
 'PUBG Mobile Season 20 ra mắt với bản đồ Rondo và PP-19 Bizon.',
 5, 3, 88940, 'published', 1, 0, '2025-10-15 08:00:00'),

(7,
 'Genshin Impact 5.3 – Hoàn tất arc Natlan với nhân vật mới',
 'genshin-53-natlan-hoan-tat',
 'HoYoverse phát hành phiên bản 5.3 hoàn tất câu chuyện Natlan với 2 nhân vật 5 sao mới: Citlali và Iansan.',
 '<h2>Genshin Impact 5.3 – Kết thúc Natlan</h2>
<p>Phiên bản 5.3 đánh dấu cột mốc quan trọng: kết thúc toàn bộ arc Natlan kéo dài hơn 1 năm.</p>
<h3>Nhân vật mới:</h3>
<ul>
  <li><strong>Citlali (5★ Cryo):</strong> Shaman tộc Mictlan, hỗ trợ đặc biệt</li>
  <li><strong>Iansan (5★ Electro):</strong> Nữ chiến binh DPS mạnh nhất patch</li>
</ul>
<h3>Sự kiện đặc biệt:</h3>
<ul>
  <li>Nhân vật 5★ miễn phí dành cho người chơi hoàn thành cốt truyện</li>
  <li>Rerun banner Xilonen và Mualani</li>
</ul>',
 'genshin-53.jpg',
 'Genshin Impact 5.3 Natlan kết thúc',
 'Genshin Impact 5.3 hoàn tất arc Natlan với nhân vật mới Citlali và Iansan.',
 5, 4, 71560, 'published', 1, 0, '2025-09-15 08:00:00'),

(8,
 'Minecraft 1.22 Garden Awakens – Pale Garden biome và sinh vật Creaking',
 'minecraft-122-garden-awakens-pale',
 'Mojang phát hành Minecraft 1.22 với biome Pale Garden rừng trắng huyền bí và sinh vật mới Creaking đáng sợ.',
 '<h2>Minecraft 1.22 Garden Awakens</h2>
<p>Bản cập nhật Garden Awakens mang đến hai điểm nhấn lớn: biome mới và sinh vật độc đáo chưa từng có trong Minecraft.</p>
<h3>Pale Garden Biome:</h3>
<ul>
  <li>Rừng cây trắng mờ ảo, không có âm thanh mob thông thường</li>
  <li>Block mới: Pale Oak Wood, Pale Moss</li>
  <li>Luôn có sương mù dày đặc</li>
</ul>
<h3>Sinh vật Creaking:</h3>
<ul>
  <li>Chỉ di chuyển khi bạn không nhìn vào nó</li>
  <li>Bất tử nếu còn Creaking Heart trong cây</li>
  <li>Cơ chế đặc biệt nhất từng có trong Minecraft</li>
</ul>',
 'mc-122-garden.jpg',
 'Minecraft 1.22 Garden Awakens biome Pale Garden',
 'Minecraft 1.22 Garden Awakens với Pale Garden và sinh vật Creaking.',
 3, 2, 62100, 'published', 0, 0, '2025-09-30 09:00:00'),

(9,
 'Baldur''s Gate 3 Patch 8 – Thêm 12 subclass mới và New Game+',
 'bg3-patch-8-subclass-moi',
 'Larian Studios phát hành Patch 8 khổng lồ cho BG3 với 12 subclass mới, New Game+ và hàng trăm fix bug.',
 '<h2>Baldur''s Gate 3 Patch 8 – Bản vá cuối cùng</h2>
<p>Đây là bản cập nhật lớn cuối cùng của BG3, đánh dấu kết thúc vòng đời chính thức của game.</p>
<h3>12 Subclass mới:</h3>
<ul>
  <li>Barbarian: Giant Instinct</li>
  <li>Bard: College of Glamour</li>
  <li>Cleric: Death Domain</li>
  <li>Druid: Circle of Stars</li>
  <li>Fighter: Arcane Archer</li>
  <li>...và 7 class khác</li>
</ul>
<h3>New Game+:</h3>
<ul>
  <li>Giữ nguyên level và equipment từ playthrough cũ</li>
  <li>Enemy mạnh hơn tương ứng</li>
</ul>',
 'bg3-patch8.jpg',
 'BG3 Patch 8 12 subclass mới và New Game+',
 'Baldur''s Gate 3 Patch 8 thêm 12 subclass và chế độ New Game+.',
 3, 4, 54210, 'published', 0, 0, '2025-11-20 14:00:00'),

(10,
 'The Witcher 4 – Trailer đầu tiên xác nhận Ciri là nhân vật chính',
 'witcher-4-trailer-ciri-nhan-vat-chinh',
 'CD Projekt Red gây sốt tại The Game Awards với trailer The Witcher 4, chính thức xác nhận Ciri thay thế Geralt.',
 '<h2>The Witcher 4 – Kỷ nguyên mới của Ciri</h2>
<p>Trailer bất ngờ tại The Game Awards đã làm cộng đồng bùng nổ. CD Projekt Red xác nhận Ciri sẽ là nhân vật chính của The Witcher 4.</p>
<h3>Những điều đã biết:</h3>
<ul>
  <li>Engine: Unreal Engine 5 – đẹp hơn Cyberpunk 2077 nhiều lần</li>
  <li>Ciri giờ là Witcher chuyên nghiệp</li>
  <li>Geralt vẫn xuất hiện với vai trò phụ</li>
  <li>Thế giới mở lớn hơn W3 đáng kể</li>
</ul>
<p>Game chưa có ngày ra mắt. Dự kiến 2026–2027.</p>',
 'witcher4-trailer.jpg',
 'The Witcher 4 trailer Ciri nhân vật chính',
 'The Witcher 4 trailer xác nhận Ciri là nhân vật chính thay Geralt.',
 3, 2, 79650, 'published', 1, 0, '2025-12-13 08:00:00'),

(11,
 'Liên Quân Mobile – Tướng mới Keera siêu cơ động ra mắt',
 'lien-quan-keera-tuong-moi-ra-mat',
 'Garena ra mắt Keera – tướng Assassin thứ 130 của Liên Quân Mobile với khả năng dash liên tục và burst damage cực cao.',
 '<h2>Keera – Sát Thủ Cơ Động Nhất Liên Quân</h2>
<p>Keera là tướng được fan chờ đợi nhất 2025 với bộ kỹ năng hoàn toàn mới lạ trong MOBA mobile.</p>
<h3>Bộ kỹ năng:</h3>
<ul>
  <li><strong>Nội công (Passive):</strong> Mỗi lần dash nạp thêm 1 chồng sát thương</li>
  <li><strong>Kỹ năng 1:</strong> Dash nhanh, áp dụng Slow</li>
  <li><strong>Kỹ năng 2:</strong> Tàng hình ngắn + tăng tốc</li>
  <li><strong>Kỹ năng 3:</strong> Dash xuyên tường địa hình</li>
  <li><strong>Chiêu cuối:</strong> 5 lần dash liên tiếp + burst toàn bộ chồng sát thương</li>
</ul>',
 'keera-lq.jpg',
 'Liên Quân tướng mới Keera Assassin',
 'Liên Quân Mobile ra mắt tướng Assassin Keera siêu cơ động.',
 5, 3, 55870, 'published', 0, 0, '2025-08-20 10:00:00'),

(12,
 'Steam Deck OLED 2 – Valve hé lộ thế hệ handheld tiếp theo',
 'steam-deck-oled-2-valve-he-lo',
 'Valve bất ngờ hé lộ Steam Deck OLED 2 với màn hình 8 inch, chip AMD mới và pin 6000mAh.',
 '<h2>Steam Deck OLED 2 – Nâng cấp đáng kể</h2>
<p>Chỉ 2 năm sau Steam Deck OLED đời đầu, Valve đã sẵn sàng với thế hệ tiếp theo.</p>
<h3>Nâng cấp chính:</h3>
<ul>
  <li>Màn hình 8 inch OLED 90Hz (tăng từ 7.4 inch 60Hz)</li>
  <li>Chip AMD Ryzen AI 365 – mạnh gấp đôi thế hệ cũ</li>
  <li>Pin 6000mAh – chơi được 4–6 tiếng liên tục</li>
  <li>Hỗ trợ Wi-Fi 7</li>
  <li>Giá dự kiến: 599 USD</li>
</ul>',
 'steamdeck2.jpg',
 'Steam Deck OLED 2 thế hệ mới',
 'Valve hé lộ Steam Deck OLED 2 với chip AMD mới và màn hình lớn hơn.',
 3, 2, 45320, 'published', 1, 0, '2025-08-10 09:00:00'),

(13,
 'Diablo IV Season 8 – Endgame mới và Necromancer overhaul',
 'diablo4-season-8-endgame',
 'Blizzard phát hành Season 8 của Diablo IV với Pit of Artificer, Necromancer overhaul và hệ thống Paragon mới.',
 '<h2>Diablo IV Season 8 – Sins of the Horadrim</h2>
<p>Season 8 là bản cập nhật lớn nhất kể từ khi Diablo IV ra mắt, thay đổi hoàn toàn endgame loop.</p>
<h3>Nội dung mới:</h3>
<ul>
  <li><strong>Pit of Artificer:</strong> Dungeon 100 tầng mới – khó hơn Pit hiện tại</li>
  <li><strong>Necromancer Overhaul:</strong> Hệ thống Summoner được làm lại từ đầu</li>
  <li><strong>Paragon V2:</strong> Bảng talent mới linh hoạt hơn</li>
  <li>Boss mới: Azmodan phiên bản Uber</li>
</ul>',
 'diablo4-s8.jpg',
 'Diablo IV Season 8 nội dung mới',
 'Diablo IV Season 8 Sins of the Horadrim với endgame mới.',
 3, 4, 52340, 'published', 0, 0, '2025-05-20 09:00:00'),

(14,
 'Cyberpunk 2077 Ultimate Edition giảm giá còn 299k trên Steam',
 'cyberpunk-2077-sale-299k-steam',
 'CD Projekt Red giảm giá sốc Cyberpunk 2077 Ultimate Edition xuống còn 299.000 VND – thấp nhất lịch sử.',
 '<h2>Cyberpunk 2077 – Deal Không Thể Bỏ Qua</h2>
<p>Đây là lần đầu tiên Ultimate Edition (bao gồm game + DLC Phantom Liberty) xuống mức giá này trên Steam.</p>
<h3>Gói bao gồm:</h3>
<ul>
  <li>Cyberpunk 2077 game chính – 60–80 giờ chơi</li>
  <li>Phantom Liberty DLC – thêm 20–30 giờ</li>
  <li>Toàn bộ DLC cosmetic và xe cộ</li>
</ul>
<p>Sale kéo dài đến 31/7/2025. Yêu cầu: RTX 2060 / RX 5700 để chơi 1080p 60fps.</p>',
 'cp2077-sale.jpg',
 'Cyberpunk 2077 sale 299k Steam',
 'Cyberpunk 2077 Ultimate Edition giảm còn 299k VND trên Steam.',
 3, 2, 38760, 'published', 0, 1, '2025-07-25 15:00:00'),

(15,
 'Hades II chính thức ra khỏi Early Access – Phiên bản đầy đủ',
 'hades-2-chinh-thuc-full-release',
 'Supergiant Games phát hành Hades II bản đầy đủ sau 1 năm Early Access với Act 3 và kết thúc chính thức.',
 '<h2>Hades II – Full Release</h2>
<p>Sau 1 năm Early Access được đón nhận nồng nhiệt, Hades II chính thức ra mắt bản đầy đủ với cốt truyện hoàn chỉnh.</p>
<h3>Nội dung mới trong bản full:</h3>
<ul>
  <li>Act 3: Olympus – hành trình cuối cùng của Melinoë</li>
  <li>Boss mới: Chronos phiên bản final</li>
  <li>10 weapon mới</li>
  <li>Kết thúc true ending và multiple endings</li>
  <li>New Game+ với độ khó Chaos mode</li>
</ul>',
 'hades2-full.jpg',
 'Hades II full release ra khỏi Early Access',
 'Hades II chính thức ra mắt bản đầy đủ với Act 3 và kết thúc.',
 6, 4, 39450, 'published', 0, 0, '2025-08-30 09:00:00'),

(16,
 'Mobile Legends Project NEXT 2025 – 15 tướng được revamp',
 'mlbb-project-next-2025-revamp',
 'Moonton công bố Project NEXT 2025 với 15 tướng sẽ được làm mới hoàn toàn về skill set và visual.',
 '<h2>MLBB Project NEXT 2025 – Làm Mới Huyền Thoại</h2>
<p>Moonton tiếp tục chuỗi revamp tướng với Project NEXT 2025, tập trung vào những tướng cổ nhất game.</p>
<h3>Một số tướng sẽ được revamp:</h3>
<ul>
  <li>Layla – ADC cổ nhất được thiết kế lại hoàn toàn</li>
  <li>Balmond – Fighter cổ điển với skill mới</li>
  <li>Clint – Gunslinger nâng cấp visual 4K</li>
  <li>Nana – Support được thêm passive mới</li>
</ul>',
 'mlbb-pnext.jpg',
 'MLBB Project NEXT 2025 revamp 15 tướng',
 'Mobile Legends Project NEXT 2025 revamp 15 tướng cổ điển.',
 5, 3, 47890, 'published', 0, 0, '2025-05-10 10:00:00'),

(17,
 'Fortnite Chapter 6 – Map mới và collab Marvel Spider-Man',
 'fortnite-chapter-6-map-spiderman',
 'Epic Games khởi động Fortnite Chapter 6 với map hoàn toàn mới theo theme Nhật Bản và Spider-Man Miles Morales.',
 '<h2>Fortnite Chapter 6 – Nhật Bản + Marvel</h2>
<p>Chapter 6 mang đến map kiến trúc Nhật Bản với nhiều biome độc đáo và cơ chế khinh công mới.</p>
<h3>Điểm mới:</h3>
<ul>
  <li>Map theme samurai Nhật Bản với núi tuyết và làng cổ</li>
  <li>Cơ chế Grapple Blade – leo trèo như ninja</li>
  <li>Collab: Spider-Man Miles Morales skin huyền thoại</li>
  <li>Collab: Naruto Shippuden bundle trở lại</li>
</ul>',
 'fn-c6.jpg',
 'Fortnite Chapter 6 map mới Spider-Man',
 'Fortnite Chapter 6 map Nhật Bản và collab Marvel Spider-Man.',
 3, 3, 65430, 'published', 0, 0, '2025-12-01 09:00:00'),

(18,
 'Apex Legends Season 24 – Legend mới Alter và LMG Nemesis',
 'apex-legends-season-24-alter',
 'Respawn công bố Season 24 của Apex Legends với Legend mới Alter – có thể đi xuyên tường – và LMG Nemesis.',
 '<h2>Apex Legends Season 24 – Alter Dimensions</h2>
<p>Alter là Legend độc đáo nhất từ trước đến nay với khả năng mở rift xuyên qua các vật cản.</p>
<h3>Kỹ năng của Alter:</h3>
<ul>
  <li><strong>Passive:</strong> Xem được path của enemy vừa grapple qua</li>
  <li><strong>Tactical:</strong> Mở lối xuyên tường trong 10 giây</li>
  <li><strong>Ultimate:</strong> Dịch chuyển tức thời đến vị trí khác trên map</li>
</ul>
<h3>LMG Nemesis:</h3>
<ul>
  <li>55 damage/viên, 25 đạn/băng</li>
  <li>Cơ chế tích điện – bắn liên tục tăng tốc độ đạn</li>
</ul>',
 'apex-s24.jpg',
 'Apex Legends Season 24 Alter Legend mới',
 'Apex Legends Season 24 với Legend Alter và LMG Nemesis.',
 3, 3, 48920, 'published', 0, 0, '2025-01-28 10:00:00'),

(19,
 'EA Sports FC 26 – HyperMotion V và AI gameplay hoàn toàn mới',
 'ea-sports-fc-26-hypermotion-v',
 'EA Sports hé lộ FC 26 với công nghệ HyperMotion V – AI học từ 180 trận đấu thực tế – thay đổi hoàn toàn cảm giác chơi.',
 '<h2>EA Sports FC 26 – Tương Lai Bóng Đá Số</h2>
<p>FC 26 sử dụng AI thế hệ mới được train từ 180 trận đấu thực tế để tái hiện chuyển động cầu thủ chân thực nhất.</p>
<h3>Nổi bật:</h3>
<ul>
  <li><strong>HyperMotion V:</strong> Mỗi cầu thủ có 2000+ animation riêng biệt</li>
  <li><strong>Rush Mode:</strong> 5v5 mini-game trong Ultimate Team</li>
  <li><strong>FC IQ:</strong> Hệ thống AI đồng đội thông minh hơn</li>
  <li>Ra mắt: 27/9/2025 trên tất cả nền tảng</li>
</ul>',
 'eafc26.jpg',
 'EA Sports FC 26 HyperMotion V AI mới',
 'EA Sports FC 26 với HyperMotion V và AI gameplay hoàn toàn mới.',
 3, 2, 58760, 'published', 0, 0, '2025-04-20 10:00:00'),

(20,
 'Overwatch 2 Season 15 – Hệ thống Perks thay đổi toàn bộ meta',
 'overwatch-2-season-15-perks',
 'Blizzard ra mắt hệ thống Perks trong Season 15 – cho phép nâng cấp kỹ năng hero ngay trong trận – thay đổi hoàn toàn cách chơi.',
 '<h2>Overwatch 2 Season 15 – Perks Revolution</h2>
<p>Perks là thay đổi gameplay lớn nhất của OW2 từ khi ra mắt. Mỗi hero có 4 Perk có thể chọn trong trận.</p>
<h3>Cách hoạt động:</h3>
<ul>
  <li>Level 2: Chọn Minor Perk (buff nhỏ)</li>
  <li>Level 4: Chọn Major Perk (thay đổi kỹ năng đáng kể)</li>
  <li>Mỗi hero có 4 Perk khác nhau để chọn lựa</li>
</ul>
<p>Ví dụ: Tracer Minor Perk tăng Recall range, Major Perk cho phép dùng Pulse Bomb ngay khi recall.</p>',
 'ow2-s15.jpg',
 'Overwatch 2 Season 15 Perks system',
 'Overwatch 2 Season 15 với hệ thống Perks thay đổi meta.',
 3, 4, 43210, 'published', 0, 0, '2025-02-28 09:00:00'),

-- ══════════════════════════════════════════════
-- NHÓM B: REVIEW GAME (20 bài)
-- ══════════════════════════════════════════════

(21,
 'Review Black Myth: Wukong – Game năm 2024 không thể tranh cãi',
 'review-black-myth-wukong-2024',
 'Black Myth: Wukong từ studio Game Science đã làm thay đổi cả ngành game với màn debut ngoạn mục. Đây là review toàn diện nhất.',
 '<h2>Review Black Myth: Wukong – 9/10</h2>
<p>Game Science đã tạo ra điều không tưởng: một studio Trung Quốc nhỏ với AAA game đẳng cấp thế giới.</p>
<h3>Đồ họa – 10/10</h3>
<p>Đẹp nhất năm 2024, không bàn cãi. Unreal Engine 5 với Lumen và Nanite cho ra những cảnh phim không phân biệt được với thực tế.</p>
<h3>Gameplay – 8/10</h3>
<p>72 phép biến hóa độc đáo, hệ thống boss phong phú. Hơi thiếu variety trong combat về cuối game.</p>
<h3>Cốt truyện – 9/10</h3>
<p>Tây Du Ký được kể lại từ góc nhìn hoàn toàn mới. Cảm xúc và bi kịch hơn nguyên tác nhiều.</p>
<h3>Âm nhạc – 10/10</h3>
<p>OST hòa trộn nhạc cụ truyền thống Trung Hoa với orchestra hiện đại – xuất sắc nhất năm.</p>
<h3>Kết luận:</h3>
<p><strong>9/10</strong> – Game năm 2024. Bắt buộc phải chơi nếu bạn yêu thích action RPG.</p>',
 'bmw-review.jpg',
 'Review Black Myth Wukong 9/10 game năm 2024',
 'Review Black Myth Wukong – Game năm 2024 với điểm 9/10.',
 7, 4, 135680, 'published', 1, 0, '2025-08-25 08:00:00'),

(22,
 'Review Elden Ring: Shadow of the Erdtree – DLC xuất sắc nhất mọi thời đại',
 'review-elden-ring-shadow-dlc',
 'Shadow of the Erdtree có xứng đáng với mức giá 35 USD? Câu trả lời ngắn gọn: Hoàn toàn xứng đáng.',
 '<h2>Review Shadow of the Erdtree – 9.5/10</h2>
<p>FromSoftware một lần nữa chứng minh tại sao họ là studio hàng đầu thế giới trong thiết kế game.</p>
<h3>Nội dung – 10/10</h3>
<p>30+ giờ nội dung chính, 10 legacy dungeon, 8 boss chính và hơn 100 vũ khí mới. Nhiều hơn nhiều game full price.</p>
<h3>Boss Design – 10/10</h3>
<p>Messmer the Impaler là boss hay nhất FromSoftware từng tạo ra – cả về lore lẫn gameplay. Bayle the Dread là runner-up xứng đáng.</p>
<h3>Khó khăn:</h3>
<p>DLC khó hơn game chính đáng kể. Cần tìm đủ Scadutree Fragment mới có thể đánh boss được. Một số người thấy đây là điểm trừ.</p>
<h3>Kết luận:</h3>
<p><strong>9.5/10</strong> – DLC tốt nhất mọi thời đại. Giá 35 USD là deal của thế kỷ.</p>',
 'er-dlc-review.jpg',
 'Review Elden Ring Shadow of the Erdtree 9.5/10',
 'Review Shadow of the Erdtree – DLC tốt nhất mọi thời đại.',
 7, 2, 98340, 'published', 1, 0, '2025-07-10 09:00:00'),

(23,
 'Review Astro Bot – Platformer hoàn hảo trên PS5',
 'review-astro-bot-ps5',
 'Astro Bot của Team Asobi là bằng chứng platformer thuần túy vẫn có thể đạt đỉnh cao nghệ thuật. Review 10/10.',
 '<h2>Review Astro Bot – 10/10</h2>
<p>Tôi hiếm khi chấm điểm tuyệt đối. Astro Bot là một trong số ít game xứng đáng được 10/10.</p>
<h3>Gameplay – 10/10</h3>
<p>Mỗi level có cơ chế mới, không level nào giống level nào. Team Asobi tận dụng DualSense haptic hoàn hảo.</p>
<h3>Level Design – 10/10</h3>
<p>80 level chính + 40 level ẩn, tất cả đều được polish đến từng chi tiết nhỏ nhất.</p>
<h3>Fan Service – 10/10</h3>
<p>Hơn 150 PlayStation character được biến thành Bot collectible. Fan Sony sẽ khóc vì hạnh phúc.</p>
<h3>Kết luận:</h3>
<p><strong>10/10</strong> – Game của năm 2024. Lý do phải sở hữu PS5.</p>',
 'astrobot-review.jpg',
 'Review Astro Bot 10/10 PS5 game của năm',
 'Review Astro Bot PS5 – Platformer hoàn hảo điểm 10/10.',
 9, 4, 72150, 'published', 1, 0, '2025-09-20 10:00:00'),

(24,
 'Review Baldur''s Gate 3 – RPG tốt nhất thập kỷ',
 'review-baldurs-gate-3-rpg',
 'Larian Studios tạo ra kiệt tác RPG với 100+ giờ nội dung, mọi lựa chọn đều có ý nghĩa và co-op mode xuất sắc.',
 '<h2>Review Baldur''s Gate 3 – 9.5/10</h2>
<p>Sau 3 năm Early Access, BG3 ra mắt bản đầy đủ và vượt xa mọi kỳ vọng.</p>
<h3>Nội dung – 10/10</h3>
<p>100+ giờ chơi cho một playthrough đầy đủ, và mỗi lần chơi lại là một trải nghiệm khác biệt nhờ hệ thống lựa chọn cực kỳ sâu.</p>
<h3>Combat – 9/10</h3>
<p>Turn-based combat dựa trên D&D 5e cực kỳ chiến thuật. Đa dạng spell và build không bao giờ chán.</p>
<h3>Nhược điểm:</h3>
<p>Act 3 hơi rushed so với Act 1 và 2. Một số questline bị cắt xén.</p>
<h3>Kết luận:</h3>
<p><strong>9.5/10</strong> – RPG tốt nhất thập kỷ. Nếu chơi 1 game trong đời, hãy chọn BG3.</p>',
 'bg3-review.jpg',
 'Review Baldur Gate 3 9.5/10 RPG tốt nhất',
 'Review Baldur Gate 3 – RPG tốt nhất thập kỷ 9.5/10.',
 7, 4, 89670, 'published', 1, 0, '2025-01-15 09:00:00'),

(25,
 'Review Genshin Impact 2025 – Vẫn xứng đáng sau 5 năm?',
 'review-genshin-impact-2025',
 'Genshin Impact sau 5 năm ra mắt – game có còn phù hợp với người mới? Lượng nội dung khổng lồ và câu hỏi gacha có fair?',
 '<h2>Review Genshin Impact 2025 – 8/10</h2>
<p>5 năm sau ngày ra mắt, Genshin vẫn là gacha game miễn phí tốt nhất thị trường – nhưng cũng ngày càng phức tạp hơn.</p>
<h3>Điểm mạnh:</h3>
<ul>
  <li>Lượng nội dung khổng lồ – hàng trăm giờ hoàn toàn miễn phí</li>
  <li>Đồ họa và âm nhạc top đầu mobile game</li>
  <li>Story arc Natlan được đánh giá hay nhất từ trước đến nay</li>
  <li>F2P friendly hơn so với 2021–2022</li>
</ul>
<h3>Điểm yếu:</h3>
<ul>
  <li>Gacha vẫn là p2w ở mức độ nhất định</li>
  <li>Power creep ngày càng rõ ràng</li>
  <li>Daily grind nhàm chán</li>
</ul>
<h3>Kết luận:</h3>
<p><strong>8/10</strong> – Đáng chơi nếu bạn có patience. F2P hoàn toàn có thể enjoy.</p>',
 'genshin-review.jpg',
 'Review Genshin Impact 2025 sau 5 năm',
 'Review Genshin Impact 2025 – Còn đáng chơi sau 5 năm?',
 8, 3, 61230, 'published', 0, 0, '2025-10-05 10:00:00'),

(26,
 'Review PUBG Mobile Season 20 – Rondo Map có thực sự tốt?',
 'review-pubg-mobile-season-20-rondo',
 'Chúng tôi chơi 50 giờ trên Rondo để đưa ra nhận xét khách quan nhất về bản đồ mới nhất của PUBG Mobile.',
 '<h2>Review PUBG Mobile Season 20 – 7.5/10</h2>
<p>Rondo là bản đồ đẹp nhất trong lịch sử PUBG Mobile nhưng có khá nhiều điểm cần cải thiện.</p>
<h3>Rondo Map – 8/10</h3>
<p>Thành phố trung tâm đậm chất châu Á, loot phân bổ hợp lý. Hot zone thiết kế tốt với nhiều tầng và lối thoát.</p>
<h3>Vũ khí mới – 7/10</h3>
<p>PP-19 Bizon ổn định nhưng không đặc sắc. Cần thêm thời gian để thấy được vị trí trong meta.</p>
<h3>Nhược điểm:</h3>
<ul>
  <li>Endgame zone thường kết thúc ở vùng đất trống, thiếu cover</li>
  <li>Vài building có hitbox không chính xác</li>
</ul>
<h3>Kết luận:</h3>
<p><strong>7.5/10</strong> – Bản đồ đáng chơi, cần thêm patch để hoàn thiện.</p>',
 'pubg-rondo-review.jpg',
 'Review PUBG Mobile Season 20 Rondo Map',
 'Review PUBG Mobile Season 20 bản đồ Rondo 7.5/10.',
 8, 3, 45670, 'published', 0, 0, '2025-11-01 09:00:00'),

(27,
 'Review Cyberpunk 2077 Phantom Liberty – Chuộc lỗi hoàn hảo',
 'review-cyberpunk-2077-phantom-liberty',
 'Từ một game bị chê tơi tả khi ra mắt năm 2020, Phantom Liberty DLC đã biến CP2077 thành masterpiece.',
 '<h2>Review Cyberpunk 2077 Phantom Liberty – 9/10</h2>
<p>Ít game nào có hành trình như Cyberpunk 2077 – từ thảm họa ra mắt đến một trong những RPG tốt nhất thập kỷ.</p>
<h3>Cốt truyện – 9.5/10</h3>
<p>Spy thriller căng thẳng với những twist không thể đoán trước. Solomon Reed (Idris Elba) là NPC hay nhất trong bất kỳ game nào.</p>
<h3>Map mới Dogtown – 9/10</h3>
<p>Dogtown nhỏ hơn Night City nhưng dày đặc nội dung hơn. Thiết kế vertical xuất sắc.</p>
<h3>Kết thúc mới:</h3>
<p>Phantom Liberty thêm vào một ending mới hoàn toàn cho game chính – đây là ending hay nhất trong 4 kết thúc.</p>
<h3>Kết luận:</h3>
<p><strong>9/10</strong> – Nếu bạn bỏ cuộc với CP2077 năm 2020, đã đến lúc quay lại.</p>',
 'cp2077-pl-review.jpg',
 'Review Cyberpunk 2077 Phantom Liberty 9/10',
 'Review Cyberpunk 2077 Phantom Liberty – Chuộc lỗi hoàn hảo.',
 7, 2, 67890, 'published', 0, 0, '2025-03-10 09:00:00'),

(28,
 'Review Hades II Early Access – Sequel vượt trội bản gốc',
 'review-hades-2-early-access',
 'Hades II Early Access ra mắt với điểm Overwhelmingly Positive ngay từ ngày đầu. Supergiant đã làm được điều không thể.',
 '<h2>Review Hades II Early Access – 9/10</h2>
<p>Early Access mà tốt hơn bản full của nhiều game khác – đó là Hades II.</p>
<h3>Điểm mạnh:</h3>
<ul>
  <li>Nhân vật Melinoë đa dạng hơn Zagreus trong cách build</li>
  <li>6 weapon type với Aspect system sâu hơn nhiều</li>
  <li>Arcana system thay thế Mirror of Night – linh hoạt hơn</li>
  <li>Art style và nhạc nền vượt trội bản gốc</li>
</ul>
<h3>Lưu ý:</h3>
<p>Vẫn là Early Access – Act 3 chưa có. Story chưa hoàn chỉnh. Nhưng đã có 20+ giờ nội dung chất lượng.</p>
<h3>Kết luận:</h3>
<p><strong>9/10</strong> – Roguelite tốt nhất 2024 kể cả khi chưa hoàn chỉnh.</p>',
 'hades2-review.jpg',
 'Review Hades II Early Access 9/10',
 'Review Hades II Early Access – Sequel vượt trội bản gốc.',
 7, 4, 35600, 'published', 0, 0, '2025-05-01 09:00:00'),

(29,
 'Review Liên Quân Mobile 2025 – Có nên quay lại chơi?',
 'review-lien-quan-mobile-2025',
 'Liên Quân Mobile sau nhiều năm cải tiến – matchmaking tốt hơn, anti-cheat mạnh hơn. Review toàn diện 2025.',
 '<h2>Review Liên Quân Mobile 2025 – 7/10</h2>
<p>Liên Quân 2025 là phiên bản tốt nhất từ trước đến nay nhưng vẫn còn nhiều vấn đề dai dẳng.</p>
<h3>Cải thiện đáng kể:</h3>
<ul>
  <li>Matchmaking: Ít toxic player hơn nhờ behavior scoring system</li>
  <li>Anti-cheat: Giảm 80% cheat so với 2023</li>
  <li>Đồ họa: Hỗ trợ 120fps trên iPhone 15 Pro và flagship Android</li>
</ul>
<h3>Vẫn còn vấn đề:</h3>
<ul>
  <li>P2W vẫn hiện diện ở một số tướng mới</li>
  <li>Server VN vẫn bị lag trong giờ cao điểm</li>
</ul>
<h3>Kết luận:</h3>
<p><strong>7/10</strong> – MOBA mobile tốt nhất VN. Đáng chơi nếu bạn thích thể loại này.</p>',
 'lq-review.jpg',
 'Review Liên Quân Mobile 2025',
 'Review Liên Quân Mobile 2025 – Có nên quay lại chơi?',
 8, 3, 52890, 'published', 0, 0, '2025-06-25 10:00:00'),

(30,
 'Review Minecraft 1.22 Garden Awakens – Bản cập nhật hay nhất từ 1.18',
 'review-minecraft-122-garden-awakens',
 'Garden Awakens mang đến Pale Garden và Creaking – đây có phải bản cập nhật hay nhất kể từ Caves & Cliffs?',
 '<h2>Review Minecraft 1.22 Garden Awakens – 8/10</h2>
<p>Mojang tiếp tục chuỗi cập nhật chất lượng với Garden Awakens – sáng tạo và đáng sợ theo cách chưa từng có.</p>
<h3>Pale Garden – 9/10</h3>
<p>Biome đẹp và ám ảnh nhất trong lịch sử Minecraft. Màu trắng xám kết hợp sương mù tạo nên atmosphere rùng rợn.</p>
<h3>Creaking – 10/10</h3>
<p>Cơ chế "chỉ di chuyển khi không nhìn" là sáng tạo nhất từ trước đến nay. Đáng sợ hơn Enderman rất nhiều.</p>
<h3>Nhược điểm:</h3>
<p>Lượng block và item mới hơi ít so với các bản cập nhật trước. Cần thêm nội dung cho Pale Garden.</p>
<h3>Kết luận:</h3>
<p><strong>8/10</strong> – Bản cập nhật sáng tạo và đáng chơi.</p>',
 'mc-review.jpg',
 'Review Minecraft 1.22 Garden Awakens 8/10',
 'Review Minecraft 1.22 Garden Awakens – Sáng tạo nhất từ 1.18.',
 7, 2, 38760, 'published', 0, 0, '2025-10-10 10:00:00'),

(31,
 'Review Stardew Valley 1.6 – Indie hoàn hảo nhất mọi thời đại',
 'review-stardew-valley-1-6',
 'ConcernedApe một mình tạo ra thứ mà studio AAA không làm được. Stardew Valley 1.6 là bản cập nhật hoàn hảo.',
 '<h2>Review Stardew Valley 1.6 – 10/10</h2>
<p>Không có gì để nói thêm – Stardew Valley 1.6 là bản cập nhật hoàn hảo của một game đã hoàn hảo.</p>
<h3>Nội dung mới 1.6:</h3>
<ul>
  <li>Bookshelves – sưu tập sách tăng skill</li>
  <li>Mastery system – endgame mới sau max level</li>
  <li>Trousersnake Challenge – farm challenge mode</li>
  <li>Hàng trăm đối thoại mới cho NPC</li>
  <li>Hỗ trợ multiplayer lên đến 8 người</li>
</ul>
<h3>Lý do 10/10:</h3>
<p>ConcernedApe tạo ra game này một mình. 1.6 là bản update miễn phí. Và vẫn là một trong những game tốt nhất mọi thời đại.</p>
<h3>Kết luận:</h3>
<p><strong>10/10</strong> – Mua game, chơi game, yêu thương game này.</p>',
 'stardew-review.jpg',
 'Review Stardew Valley 1.6 10/10 indie hoàn hảo',
 'Review Stardew Valley 1.6 – Indie hoàn hảo nhất mọi thời đại.',
 7, 4, 41230, 'published', 0, 0, '2025-04-20 09:00:00'),

(32,
 'Review Valorant 2025 – FPS tactical tốt nhất PC hiện tại?',
 'review-valorant-2025-fps',
 'Sau 5 Episode, Valorant có còn giữ được vị trí FPS PC hàng đầu? Review toàn diện sau 4 năm ra mắt.',
 '<h2>Review Valorant 2025 – 8.5/10</h2>
<p>4 năm tuổi, Valorant vẫn là FPS tactical tốt nhất PC về mặt competitive.</p>
<h3>Gameplay – 9/10</h3>
<p>Gunplay vẫn là tốt nhất trong thể loại. Balance agent được cải thiện đáng kể so với 2021–2022.</p>
<h3>Content – 8/10</h3>
<p>30 Agent đa dạng với role rõ ràng. 11 map chất lượng cao. Esports scene phát triển mạnh.</p>
<h3>Nhược điểm:</h3>
<ul>
  <li>Toxicity vẫn là vấn đề lớn ở VN server</li>
  <li>Cosmetics quá đắt (skin bundle 70 USD)</li>
</ul>
<h3>Kết luận:</h3>
<p><strong>8.5/10</strong> – Vẫn là chuẩn mực FPS tactical. Miễn phí = không có lý do không thử.</p>',
 'valo-review.jpg',
 'Review Valorant 2025 FPS tactical 8.5/10',
 'Review Valorant 2025 – FPS tactical tốt nhất PC hiện tại.',
 7, 3, 58900, 'published', 0, 0, '2025-11-05 10:00:00'),

(33,
 'Review Diablo IV 2025 – Đã cứu vãn được chưa sau 1 năm?',
 'review-diablo-4-2025-sau-1-nam',
 'Diablo IV ra mắt gây thất vọng năm 2023. Sau 1 năm update liên tục, game có trở nên tốt hơn thực sự không?',
 '<h2>Review Diablo IV 2025 – 7.5/10</h2>
<p>Blizzard đã làm việc chăm chỉ và kết quả là Diablo IV 2025 tốt hơn 2023 rất nhiều – nhưng vẫn chưa đến mức masterpiece.</p>
<h3>Cải thiện lớn:</h3>
<ul>
  <li>Season 4 Loot Reborn: Hệ thống loot được thiết kế lại hoàn toàn</li>
  <li>Endgame phong phú hơn với Pit và Tormented Boss</li>
  <li>Balance class tốt hơn – mọi class đều viable</li>
</ul>
<h3>Vẫn còn thiếu:</h3>
<ul>
  <li>Cốt truyện chính vẫn nhạt so với D2</li>
  <li>Battle Pass thiếu value</li>
</ul>
<h3>Kết luận:</h3>
<p><strong>7.5/10</strong> – Đáng chơi nếu bạn thích ARPG, nhưng chờ sale.</p>',
 'diablo4-review.jpg',
 'Review Diablo IV 2025 sau 1 năm 7.5/10',
 'Review Diablo IV 2025 – Đã cứu vãn được chưa sau 1 năm?',
 7, 4, 47800, 'published', 0, 0, '2025-06-20 09:00:00'),

(34,
 'Review Tekken 8 – Fighting game đỉnh cao không thể bỏ lỡ',
 'review-tekken-8-fighting',
 'Tekken 8 là fighting game tốt nhất năm 2024 với Arcade Quest story mode xuất sắc và gameplay depth cực cao.',
 '<h2>Review Tekken 8 – 9/10</h2>
<p>Bandai Namco đã tạo ra Tekken tốt nhất từ trước đến nay.</p>
<h3>Story Mode – 9/10</h3>
<p>The Dark Awakens là story mode fighting game hay nhất từng được làm. Mỗi character có arc riêng đầy đủ.</p>
<h3>Gameplay – 9.5/10</h3>
<p>Heat system mới tạo ra lớp depth chiến thuật mà các Tekken cũ thiếu. Beginner friendly hơn nhưng vẫn cao deepness cho pro.</p>
<h3>Online – 8/10</h3>
<p>Rollback netcode chuẩn, matching fair. Chỉ thiếu cross-play giữa console và PC.</p>
<h3>Kết luận:</h3>
<p><strong>9/10</strong> – Fighting game of the year 2024. Xứng đáng với cái tên King of Iron Fist.</p>',
 'tekken8-review.jpg',
 'Review Tekken 8 9/10 fighting game',
 'Review Tekken 8 – Fighting game đỉnh cao 9/10.',
 7, 2, 33450, 'published', 0, 0, '2025-02-25 10:00:00'),

(35,
 'Review Hollow Knight – Tại sao indie 2017 này vẫn là must-play 2025?',
 'review-hollow-knight-must-play-2025',
 'Nhìn lại Hollow Knight năm 2025 – tại sao game 8 năm tuổi vẫn là metroidvania hay nhất từng được tạo ra?',
 '<h2>Review Hollow Knight – 10/10 (2025)</h2>
<p>8 năm trôi qua, Hollow Knight vẫn chưa có đối thủ thực sự trong thể loại metroidvania.</p>
<h3>Tại sao vẫn hay năm 2025:</h3>
<ul>
  <li><strong>World building:</strong> Hallownest là thế giới game được xây dựng công phu nhất từng có trong indie game</li>
  <li><strong>Combat:</strong> Đơn giản để học, vô hạn để master – boss cuối vẫn thách thức pro player</li>
  <li><strong>Âm nhạc:</strong> Christopher Larkin tạo ra OST không thể quên</li>
  <li><strong>Giá:</strong> 150k VND – deal tốt nhất trong gaming</li>
</ul>
<h3>Lý do chơi 2025:</h3>
<p>Silksong vẫn chưa ra. Đây là cách chuẩn bị tốt nhất và cũng là cách tận hưởng masterpiece.</p>
<h3>Kết luận:</h3>
<p><strong>10/10</strong> – Bắt buộc phải chơi trước khi Silksong ra mắt.</p>',
 'hk-review.jpg',
 'Review Hollow Knight 10/10 must-play 2025',
 'Review Hollow Knight – Tại sao vẫn là must-play năm 2025.',
 7, 2, 29450, 'published', 0, 0, '2025-07-15 10:00:00'),

(36,
 'Review Mobile Legends 2025 – MOBA mobile vua Đông Nam Á',
 'review-mobile-legends-2025-sea',
 'MLBB vẫn là MOBA mobile số 1 Đông Nam Á sau nhiều năm. Review toàn diện 2025: gameplay, meta và vấn đề P2W.',
 '<h2>Review Mobile Legends 2025 – 7/10</h2>
<p>Moonton tiếp tục duy trì vị trí thống trị MOBA mobile ĐNA nhưng game vẫn còn những vấn đề khó chịu.</p>
<h3>Điểm mạnh:</h3>
<ul>
  <li>Gameplay nhanh (15–18 phút/trận) phù hợp mobile</li>
  <li>120+ hero đa dạng, meta thay đổi thường xuyên</li>
  <li>Esports scene mạnh (MPL)</li>
</ul>
<h3>Điểm yếu:</h3>
<ul>
  <li>P2W vẫn hiện diện với hero mới OP</li>
  <li>Matchmaking ghép đội không đồng đều</li>
  <li>Skin quá đắt</li>
</ul>
<h3>Kết luận:</h3>
<p><strong>7/10</strong> – Vẫn là best MOBA mobile nhưng cần cải thiện nhiều thứ.</p>',
 'mlbb-review.jpg',
 'Review Mobile Legends 2025 MOBA mobile',
 'Review Mobile Legends 2025 – MOBA mobile số 1 Đông Nam Á.',
 8, 3, 43560, 'published', 0, 0, '2025-08-30 09:00:00'),

(37,
 'Review EA Sports FC 25 – Có đáng mua hay chờ FC 26?',
 'review-ea-sports-fc-25-dang-mua',
 'EA Sports FC 25 với Rush mode mới và FC IQ system. Có đáng bỏ 1.5 triệu mua hay chờ FC 26 sang năm?',
 '<h2>Review EA Sports FC 25 – 7/10</h2>
<p>FC 25 là bước đi nhỏ so với FC 24, không phải bước nhảy vọt.</p>
<h3>Rush Mode – 8/10</h3>
<p>5v5 format mới trong Ultimate Team thú vị và tươi mới. Cách kiếm coin nhanh hơn và ít toxic hơn Rivals.</p>
<h3>FC IQ – 7/10</h3>
<p>AI đồng đội thông minh hơn trong positioning. Nhưng cần thêm thời gian để thực sự ảnh hưởng đến gameplay pro.</p>
<h3>Vấn đề:</h3>
<ul>
  <li>Ultimate Team vẫn P2W nặng</li>
  <li>Career Mode không có gì mới đáng kể</li>
</ul>
<h3>Kết luận:</h3>
<p><strong>7/10</strong> – Nếu bạn đã có FC 24, hãy chờ sale hoặc FC 26.</p>',
 'eafc25-review.jpg',
 'Review EA Sports FC 25 có đáng mua',
 'Review EA Sports FC 25 – Có đáng mua hay chờ FC 26?',
 7, 2, 38900, 'published', 0, 0, '2025-09-25 10:00:00'),

(38,
 'Review Nintendo Switch – Vẫn đáng mua năm 2025 trước khi Switch 2 ra mắt?',
 'review-nintendo-switch-1-2025',
 'Switch đời đầu giảm giá còn 6 triệu. Với Switch 2 sắp ra mắt, có nên mua Switch 1 không?',
 '<h2>Review Nintendo Switch 2025 – Có Nên Mua?</h2>
<p>Câu trả lời phụ thuộc vào nhu cầu của bạn – nhưng đây là phân tích trung thực nhất.</p>
<h3>Lý do NÊN mua Switch 1:</h3>
<ul>
  <li>Game library: 5000+ game, nhiều exclusive kiệt tác</li>
  <li>Giá hiện tại: 6 triệu VND – rẻ nhất từ trước đến nay</li>
  <li>Portable gaming không gì sánh bằng</li>
  <li>Switch 2 tương thích ngược – library vẫn dùng được</li>
</ul>
<h3>Lý do KHÔNG NÊN:</h3>
<ul>
  <li>Switch 2 ra mắt 2025 – đợi thêm vài tháng đáng hơn</li>
  <li>Joy-Con drift vẫn là vấn đề</li>
</ul>
<h3>Kết luận:</h3>
<p>Nếu ngân sách eo hẹp: mua Switch 1. Nếu có thể chờ: đợi Switch 2.</p>',
 'switch-review.jpg',
 'Review Nintendo Switch 2025 có nên mua',
 'Review Nintendo Switch 2025 – Có nên mua trước khi Switch 2 ra?',
 9, 4, 45600, 'published', 0, 0, '2025-03-15 09:00:00'),

(39,
 'Review Apex Legends 2025 – Battle Royale đang dần mất hút',
 'review-apex-legends-2025-state',
 'Apex Legends đang mất dần người chơi dù gameplay vẫn xuất sắc. Phân tích những gì đã sai với Respawn.',
 '<h2>Review Apex Legends 2025 – 7/10</h2>
<p>Apex vẫn là battle royale với gameplay tốt nhất – nhưng Respawn đang tự bắn vào chân mình.</p>
<h3>Gameplay vẫn 9/10:</h3>
<p>Movement system không game nào bắt kịp. Legend kit phong phú và unique. Gunplay đỉnh nhất BR genre.</p>
<h3>Vấn đề ngày càng tệ:</h3>
<ul>
  <li>Monetization: Skin 70 USD là bình thường, battle pass giá tăng liên tục</li>
  <li>Server: Ddos và cheater vẫn chưa được xử lý</li>
  <li>Ranked: System thay đổi quá nhiều gây confuse</li>
</ul>
<h3>Kết luận:</h3>
<p><strong>7/10</strong> – Gameplay tốt nhất BR nhưng publisher đang giết chết game.</p>',
 'apex-review.jpg',
 'Review Apex Legends 2025 state 7/10',
 'Review Apex Legends 2025 – Battle Royale dần mất hút.',
 7, 3, 41230, 'published', 0, 0, '2025-03-25 09:00:00'),

(40,
 'Review Overwatch 2 2025 – Perks System có cứu được game không?',
 'review-overwatch-2-2025-perks',
 'Overwatch 2 thêm hệ thống Perks trong Season 15. Đây có phải thay đổi cần thiết hay chỉ là band-aid fix?',
 '<h2>Review Overwatch 2 2025 – 6.5/10</h2>
<p>Perks system là thay đổi tích cực nhất OW2 từ khi ra mắt – nhưng vẫn còn quá nhiều vấn đề nền tảng.</p>
<h3>Perks System – 8/10</h3>
<p>Mang lại chiều sâu chiến thuật và tăng replayability đáng kể. Đúng hướng đi.</p>
<h3>Vẫn còn nhiều vấn đề:</h3>
<ul>
  <li>Thiếu identity – không biết muốn là OW1 hay game mới</li>
  <li>Hero pool giống OW1 quá nhiều, thiếu hero thực sự mới</li>
  <li>PvE promise vẫn chưa được thực hiện</li>
  <li>Community trust đã mất từ lâu</li>
</ul>
<h3>Kết luận:</h3>
<p><strong>6.5/10</strong> – Cải thiện nhưng chưa đủ. Cần thêm 2–3 season nữa để thực sự đánh giá được.</p>',
 'ow2-review.jpg',
 'Review Overwatch 2 2025 Perks system 6.5/10',
 'Review Overwatch 2 2025 – Perks System có cứu được game không?',
 7, 4, 35780, 'published', 0, 0, '2025-04-10 10:00:00');

-- ============================================================
-- 6. ARTICLE_TAGS
-- ============================================================
INSERT INTO article_tags (article_id, tag_id) VALUES
-- Tin tức
(1, 1),(1,15),(1,16),
(2, 4),(2,16),
(3, 9),(3,11),(3,17),
(4,12),(4, 8),(4,16),
(5, 1),(5, 7),(5,19),
(6, 5),(6,13),(6,10),(6,17),
(7,14),(7,17),
(8, 1),(8,17),
(9, 1),(9, 7),(9,17),
(10, 1),(10, 7),(10,16),
(11, 5),(11, 9),(11,16),
(12, 1),(12,16),
(13, 1),(13, 7),(13,17),
(14, 1),(14,17),
(15, 6),(15, 7),(15,16),
-- Review
(21, 1),(21, 7),(21,18),
(22, 1),(22, 7),(22,18),(22,19),
(23, 2),(23,18),
(24, 1),(24, 7),(24,18),
(25,14),(25,20),(25,18),
(26, 5),(26,13),(26,10),(26,18),
(27, 1),(27, 7),(27,18),(27,19),
(28, 6),(28, 7),(28,18),
(29, 5),(29, 9),(29,18),
(30, 1),(30,18),
(31, 6),(31,18),
(32,12),(32, 8),(32,20),(32,18),
(33, 1),(33,18),
(34, 1),(34,18),
(35, 6),(35,18),
(36, 5),(36, 9),(36,18),
(37, 1),(37,18),
(38, 4),(38,18),
(39, 1),(39,10),(39,18),
(40, 8),(40,20),(40,18);

-- ============================================================
-- 7. COMMENTS
-- ============================================================
INSERT INTO comments (article_id, user_id, parent_comment_id, content, is_approved, like_count) VALUES
-- Bài GTA VI
(1, 5, NULL, 'Đỉnh quá luôn! Đã đặt hàng PS5 Pro để chờ GTA VI rồi. Mong tháng 5 đến mau!', 1, 45),
(1, 6, NULL, 'Sao không release PC cùng lúc vậy? Rockstar phân biệt đối xử game thủ PC quá.', 1, 28),
(1, 9, 2, 'Rockstar lần nào cũng vậy bạn ơi. GTA V PC cũng ra sau 2 năm mà. Quen rồi.', 1, 17),
(1, 8, NULL, 'Lucia làm nhân vật chính hay đấy. Cần thêm góc nhìn nữ trong gaming.', 1, 22),
-- Bài LMHT
(3, 6, NULL, 'Cần nerf Jinx gấp đi. Mùa này bot lane bất cân bằng ghê. Carry quá dễ.', 1, 34),
(3, 5, NULL, 'Void Drake mới trông hay đó. Map thay đổi tạo ra nhiều tình huống chiến thuật mới.', 1, 19),
(3, 6, 6, 'Đồng ý. Objective mới Atakhan cũng cool. Meta assassin sẽ tăng mạnh mùa này.', 1, 11),
-- Bài review Black Myth
(21, 5, NULL, 'Game đỉnh nhất 2024 không bàn cãi. Trung Quốc đã chứng minh đẳng cấp AAA rồi!', 1, 67),
(21, 9, NULL, 'Boss Erlang Shen tốn của mình 4 tiếng mới qua. Đau lắm nhưng rất đã khi thắng.', 1, 43),
(21, 8, 9, 'Erlang dễ hơn Yellow Wind Sage nhiều đó bạn. Mình tốn 6 tiếng với ông gió đó.', 1, 31),
(21, 10, NULL, 'PC mình RTX 3080 mà setting max vẫn bị lag. Optimize chưa tốt lắm.', 1, 20),
-- Bài review Elden Ring DLC
(22, 5, NULL, '9.5/10 hoàn toàn xứng đáng. Messmer là boss hay nhất FromSoft từ trước đến nay.', 1, 55),
(22, 9, NULL, 'DLC khó hơn game chính nhiều. Người mới vào thẳng DLC sẽ bị nghiền nát ngay.', 1, 38),
(22, 5, 13, 'Cần farm Scadutree Fragment đủ level mới đánh được boss bạn ơi. Quan trọng lắm.', 1, 27),
-- Bài review Astro Bot
(23, 8, NULL, 'Game hay nhất PS5 thật sự. Mua PS5 Pro chỉ để chơi Astro Bot là xứng đáng.', 1, 48),
(23, 10, NULL, '10/10 đúng rồi. Mỗi level có 1 cơ chế mới, không level nào nhàm chán.', 1, 35),
-- Bài review Genshin
(25, 10, NULL, 'AR60 đây. Game F2P friendly hơn nhiều rồi. Natlan arc cực hay so với các vùng trước.', 1, 29),
(25, 6, NULL, 'Daily grind nhàm chán thật. Nhưng story và exploration thì không game nào bằng.', 1, 22),
-- Bài PUBG
(6, 7, NULL, 'Rondo map đẹp nhưng endgame zone hay kết ở vùng trống quá. Thiếu cover.', 1, 31),
(6, 5, NULL, 'PP-19 Bizon 53 đạn không reload là meta rồi. Close range bá đạo lắm.', 1, 24),
-- Bài The Witcher 4
(10, 9, NULL, 'Ciri làm nhân vật chính hay đấy! Câu chuyện của cô ấy chưa được khai thác hết ở W3.', 1, 44),
(10, 5, NULL, 'Vẫn mong có Geralt. Bộ đôi Geralt-Ciri trong DLC W3 hay hơn nhiều game khác.', 1, 33),
(10, 9, 21, 'Geralt vẫn sẽ xuất hiện bạn ơi, chỉ là vai phụ thôi. Trailer có hint rồi.', 1, 19);

-- ============================================================
-- 8. RATINGS
-- ============================================================
INSERT INTO ratings (article_id, user_id, score, review) VALUES
(21, 5,  5, 'Review chính xác và toàn diện. Hoàn toàn đồng ý với điểm 9/10.'),
(21, 9,  5, 'Bài review hay nhất về Black Myth tôi đọc được. Cảm ơn editor!'),
(21, 8,  4, 'Review tốt nhưng phần gameplay hơi ngắn. Cần thêm chi tiết về boss fights.'),
(22, 5,  5, 'Shadow of the Erdtree xứng đáng hơn 9.5/10 là khác. DLC tuyệt vời.'),
(23, 8,  5, 'Astro Bot 10/10 đúng rồi. Review rất fair.'),
(24, 9,  5, 'BG3 xứng đáng RPG tốt nhất thập kỷ. Review sâu sắc.'),
(25, 10, 4, 'Review Genshin khá fair. Chỉ thiếu phần so sánh với Honkai Star Rail.'),
(3,  6,  4, 'Thông tin đầy đủ về season mới. Mong có thêm bài chi tiết về từng thay đổi.'),
(1,  5,  5, 'Tin tức nhanh và chính xác. GTA VI hype thật!'),
(10, 9,  5, 'Phân tích The Witcher 4 trailer rất tốt. Bài viết chất lượng.'),
(15, 9,  5, 'Rất vui khi Hades II hoàn chỉnh. Review xúc tích và đủ thông tin.'),
(6,  7,  4, 'Thông tin đầy đủ về Season 20. Rondo map preview trông hay đấy.');

-- ============================================================
-- 9. BOOKMARKS
-- ============================================================
INSERT INTO bookmarks (user_id, article_id) VALUES
(5, 1),(5,21),(5,22),(5, 5),(5,10),
(6, 3),(6,24),(6,32),(6, 4),(6,20),
(7, 6),(7,26),(7,13),(7,18),
(8, 2),(8,23),(8,38),(8, 9),(8,34),
(9, 4),(9,24),(9,28),(9,35),(9,27),
(10,7),(10,25),(10,30),(10,15);

-- ============================================================
-- 10. SETTINGS
-- ============================================================
INSERT INTO settings (setting_key, setting_value, setting_group) VALUES
('site_name',        'GNews – Tin Tức Game',                             'general'),
('site_tagline',     'Nhanh nhất • Chính xác nhất • Đam mê nhất',        'general'),
('site_url',         'https://gnews.vn',                                 'general'),
('admin_email',      'admin@gnews.vn',                                   'general'),
('articles_per_page','10',                                               'general'),
('allow_comments',   '1',                                                'general'),
('meta_keywords',    'tin tức game, review game, genshin, lmht, valorant, pubg mobile', 'seo'),
('meta_description', 'GNews – Cập nhật tin tức game nhanh nhất và review game chuyên sâu tại Việt Nam', 'seo'),
('facebook_url',     'https://facebook.com/gnewsvn',                    'social'),
('youtube_url',      'https://youtube.com/@gnewsvn',                    'social'),
('primary_color',    '#E74C3C',                                          'appearance'),
('logo_url',         'assets/img/logo.png',                              'appearance');

-- ============================================================
-- KIỂM TRA
-- ============================================================
SELECT '✅ Dữ liệu mẫu đã được tạo thành công!' AS status;
SELECT CONCAT('📰 Bài viết: ', COUNT(*)) AS info FROM articles;
SELECT CONCAT('👥 Người dùng: ', COUNT(*)) AS info FROM users;
SELECT CONCAT('💬 Bình luận: ', COUNT(*)) AS info FROM comments;
SELECT CONCAT('⭐ Đánh giá: ',  COUNT(*)) AS info FROM ratings;
SELECT CONCAT('🔖 Bookmark: ', COUNT(*)) AS info FROM bookmarks;
