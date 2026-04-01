<?php
// routes/web.php
// Route definitions with middleware groups
// IMPORTANT: Static routes must come BEFORE dynamic :slug routes (first-match wins)

// ── Public routes (no middleware) ─────────────────────────────────────────

$router->get('/',                     'HomeController@index');
$router->get('/search',               'SearchController@index');

// Articles - STATIC before DYNAMIC
$router->get('/article/load-more',    'ArticleController@loadMore');
$router->get('/article/:slug',        'ArticleController@show');  // :slug last

// Categories & Tags
$router->get('/category/:slug',       'CategoryController@show');
$router->get('/tag/:slug',            'TagController@show');

// Auth — CSRF protection on POST routes
$router->get('/auth/login',           'UserController@loginForm');
$router->get('/auth/register',        'UserController@registerForm');
$router->get('/auth/forgot-password', 'UserController@forgotPasswordForm');
$router->get('/auth/reset-password/:token', 'UserController@resetPasswordForm');

$router->group(['middleware' => ['csrf']], function ($r) {
    $r->post('/auth/login',            'UserController@login');
    $r->post('/auth/register',         'UserController@register');
    $r->post('/auth/forgot-password',  'UserController@forgotPassword');
    $r->post('/auth/reset-password',   'UserController@resetPassword');
    $r->post('/auth/logout',           'UserController@logout');
    $r->post('/auth/social-callback',  'UserController@socialCallback');

    // AJAX interactions (CSRF validated via X-CSRF-TOKEN header)
    $r->post('/article/comment',       'ArticleController@submitComment');
    $r->post('/article/rate',          'ArticleController@rate');
    $r->post('/article/bookmark',      'ArticleController@bookmark');
});

$router->group(['middleware' => ['auth']], function ($r) {
    $r->get('/profile/bookmarks', 'UserController@bookmarks');
    $r->get('/profile',           'UserController@profileForm');
    $r->get('/profile/history',   'UserController@readHistory');
});

$router->group(['middleware' => ['auth', 'csrf']], function ($r) {
    $r->post('/profile/update',   'UserController@updateProfile');
});

// ── Admin routes (requires admin + CSRF on POST) ─────────────────────────

$router->group(['middleware' => ['admin']], function ($r) {
    $r->get('/admin',                          'AdminController@dashboard');
    $r->get('/admin/articles',                 'AdminController@articles');
    $r->get('/admin/articles/create',          'AdminController@createArticleForm');
    $r->get('/admin/articles/edit/:id',        'AdminController@editArticleForm');
    $r->get('/admin/categories',               'AdminController@categories');
    $r->get('/admin/users',                    'AdminController@users');
    $r->get('/admin/comments',                 'AdminController@comments');

    // Game Management Routes
    $r->get('/admin/upcoming-games',           'AdminGameController@upcomingGames');
    $r->get('/admin/upcoming-games/create',    'AdminGameController@createUpcomingGameForm');
    $r->get('/admin/upcoming-games/:id/edit',  'AdminGameController@editUpcomingGameForm');
    $r->get('/admin/trending-games',           'AdminGameController@trendingGames');
    $r->get('/admin/trending-games/create',    'AdminGameController@createTrendingGameForm');
    $r->get('/admin/trending-games/:id/edit',  'AdminGameController@editTrendingGameForm');
});

$router->group(['middleware' => ['admin', 'csrf']], function ($r) {
    $r->post('/admin/articles/store',          'AdminController@storeArticle');
    $r->post('/admin/articles/update/:id',     'AdminController@updateArticle');
    $r->post('/admin/articles/delete/:id',     'AdminController@deleteArticle');
    $r->post('/admin/categories/store',        'AdminController@storeCategory');
    $r->post('/admin/categories/update/:id',   'AdminController@updateCategory');
    $r->post('/admin/categories/delete/:id',   'AdminController@deleteCategory');
    $r->post('/admin/users/role/:id',          'AdminController@updateUserRole');
    $r->post('/admin/comments/approve/:id',    'AdminController@approveComment');
    $r->post('/admin/comments/delete/:id',     'AdminController@deleteComment');

    // Game Management Routes
    $r->post('/admin/upcoming-games/store',    'AdminGameController@storeUpcomingGame');
    $r->post('/admin/upcoming-games/update/:id', 'AdminGameController@updateUpcomingGame');
    $r->post('/admin/upcoming-games/:id/delete', 'AdminGameController@deleteUpcomingGame');
    $r->post('/admin/trending-games/store',    'AdminGameController@storeTrendingGame');
    $r->post('/admin/trending-games/update/:id', 'AdminGameController@updateTrendingGame');
    $r->post('/admin/trending-games/:id/delete', 'AdminGameController@deleteTrendingGame');
});
