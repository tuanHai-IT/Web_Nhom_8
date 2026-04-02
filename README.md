<div align="center">
<img width="2451" height="1355" alt="image" src="https://github.com/user-attachments/assets/100e8bd4-b6ef-4a2e-99fa-64957b823b7f" />
</div>

# ĐỒ ÁN KẾT THÚC MÔN: WEB TIN TỨC GAME

[![PHP](https://img.shields.io/badge/PHP-8.1%2B-777BB4)](https://www.php.net/)
[![MySQL](https://img.shields.io/badge/MySQL-8.0-4479A1)](https://www.mysql.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## THÔNG TIN MÔN HỌC
- **Môn học:** Phát triển Ứng dụng Web
- **Trường:** Đại học Kinh tế TP.HCM (UEH)
- **Chủ đề:** Website Tin tức Game
- **Năm học:** 2025-2026

---

## MÔ TẢ ĐỒ ÁN

**GameNews** là website tin tức game hiện đại được xây dựng theo kiến trúc **MVC** với **PHP OOP**, cung cấp thông tin bài viết, tin tức game mới nhất. Website có giao diện responsive, thân thiện, hỗ trợ người dùng đăng nhập, bookmark, đánh giá, bình luận bài viết.

### Tính năng chính:
- **Frontend**: Trang chủ với tin nổi bật, carousel, tag cloud, search real-time.
- **User**: Đăng ký/đăng nhập, profile, bookmark, lịch sử xem, dark/light mode.
- **Content**: Chi tiết bài viết (rating, comment AJAX), category/tag browsing.
- **Admin**: Dashboard CRUD (articles, categories, users, comments, trending/upcoming games).
- **Advanced**: AJAX (comment/rate/bookmark/load-more), security (CSRF, PDO prepared, hashing), pagination, image upload.

---

## 🛠️ CÔNG NGHỆ SỬ DỤNG

### Frontend
- **HTML5, CSS3, Vanilla JavaScript** (custom responsive theme)
- **AJAX** cho tương tác real-time (comment, rating, search)
- **Font Awesome** - Icons

### Backend
- **PHP 8.x** (OOP + Custom MVC Framework)
- **Custom Core**: Router, Database (PDO singleton), Model/ Controller base, Autoloader
- **Composer** autoload (classmap)

### Database
- **MySQL 8.0** với schema đầy đủ (`database.sql`)
- **Stored Procedures/Views** (từ dumps)

### Tools & Services
- **XAMPP/Apache** - Local dev server
- **Git/GitHub** - Version control
- **phpMyAdmin** - DB management
- **VS Code** - IDE

---

## 🚀 HƯỚNG DẪN CÀI ĐẶT

### Yêu cầu
- PHP 8.1+, MySQL 8.0+, Apache mod_rewrite

### 1. Clone/Tải project vào `htdocs/gamenews`
### 2. Tạo DB `gamenews` & import `database.sql`
### 3. Cấu hình `config/database.php`:
```php
define('DB_HOST', 'localhost');
define('DB_NAME', 'gamenews');
define('DB_USER', 'root');
define('DB_PASS', '');
define('BASE_URL', 'http://localhost/gamenews');
```
### 4. Truy cập Local: `http://localhost/gamenews`
### 5. Live Demo (Free Hosting): [https://gamenexus.great-site.net](https://gamenexus.great-site.net)

**Admin default**:
- Email: `admin@gamenews.com`
- Password: `admin123456`

---

## 📁 CẤU TRÚC DỰ ÁN
```
gamenews/
├── index.php          # Entry point
├── routes/web.php     # Routes
├── config/database.php
├── core/              # Framework core (Router, DB, etc.)
├── app/
│   ├── controllers/   # Controllers (Home, Article, Admin...)
│   ├── models/        # Models (Article, User...)
│   └── views/         # Views (pages, admin, layouts)
├── public/            # Assets (css, js, images/uploads)
└── database.sql       # Schema + data
```

---

## 👥 Nhóm Phát Triển

| Thành viên          | Vai trò     |
|---------------------|-------------|
| Võ Hoàng Tuấn Hải   | Team Leader |
| Hồ Trong Phúc       | Member      |
| Nguyễn Thành Đạt    | Member      |
| Lê Quân             | Member      |

---

**GameNews - Nơi cập nhật tin game nhanh chóng & chuyên nghiệp!** 🎯
