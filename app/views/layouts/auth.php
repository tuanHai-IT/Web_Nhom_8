<!DOCTYPE html>
<html lang="en" data-bs-theme="dark">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?= htmlspecialchars($pageTitle ?? 'GameNexus') ?></title>
    <meta name="description" content="GameNexus — Your ultimate gaming news hub">

    <!-- CSRF token for AJAX requests -->
    <meta name="csrf-token" content="<?= Csrf::token() ?>">

    <!-- Google Fonts: Exo 2 (display) + Roboto (body) -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Exo+2:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <!-- Bootstrap 5 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="<?= BASE_URL ?>/public/css/style.css">

    <style>
        body {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: var(--bg-dark);
            padding: 20px;
        }

        main {
            width: 100%;
            padding: 0;
        }
    </style>
</head>

<body>
    <main class="gn-main">
        <?= $content ?>
    </main>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Global CSRF token for JavaScript -->
    <script>
        const BASE_URL = '<?= BASE_URL ?>';
        const CSRF_TOKEN = '<?= Csrf::token() ?>';
    </script>
</body>

</html>