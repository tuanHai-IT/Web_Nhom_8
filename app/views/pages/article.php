<?php // app/views/pages/article.php 
?>
<div class="container">
    <div class="row g-4">

        <!-- ── Main Article Column ──────────────────────────────────── -->
        <div class="col-lg-8">

            <!-- Breadcrumb -->
            <nav aria-label="breadcrumb" class="mb-3">
                <ol class="breadcrumb small">
                    <li class="breadcrumb-item"><a href="<?= BASE_URL ?>/" class="text-accent">Home</a></li>
                    <li class="breadcrumb-item">
                        <a href="<?= BASE_URL ?>/category/<?= $article['category_slug'] ?>" class="text-accent">
                            <?= htmlspecialchars($article['category_name']) ?>
                        </a>
                    </li>
                    <li class="breadcrumb-item active text-muted" aria-current="page">Article</li>
                </ol>
            </nav>

            <!-- Hero Image -->
            <?php if ($article['thumbnail']): ?>
                <img src="<?= htmlspecialchars($article['thumbnail']) ?>"
                    alt="<?= htmlspecialchars($article['title']) ?>" class="article-hero">
            <?php endif; ?>

            <!-- Title + Meta -->
            <a href="<?= BASE_URL ?>/category/<?= $article['category_slug'] ?>" class="card-cat-badge mb-2 d-inline-block">
                <?= htmlspecialchars($article['category_name']) ?>
            </a>
            <?php if ($article['is_breaking']): ?>
                <span class="badge bg-danger ms-2">BREAKING</span>
            <?php endif; ?>
            <?php if ($article['is_featured']): ?>
                <span class="badge bg-warning text-dark ms-2">FEATURED</span>
            <?php endif; ?>

            <h1 class="article-title mt-2 mb-3"><?= htmlspecialchars($article['title']) ?></h1>

            <div class="d-flex flex-wrap align-items-center gap-3 mb-4 pb-3 border-bottom border-secondary">
                <span class="small text-muted">
                    <i class="bi bi-person-circle me-1 text-accent"></i>
                    <?= htmlspecialchars($article['author_name']) ?>
                </span>
                <span class="small text-muted">
                    <i class="bi bi-calendar3 me-1"></i>
                    <?= $article['published_at'] ? date('M d, Y', strtotime($article['published_at'])) : '' ?>
                </span>
                <span class="small text-muted">
                    <i class="bi bi-eye me-1"></i>
                    <?= number_format($article['view_count']) ?> views
                </span>
                <span class="small text-muted">
                    <i class="bi bi-clock me-1"></i>
                    <?= $readTime ?? 1 ?> phút đọc
                </span>

                <!-- Bookmark button -->
                <?php if (!empty($_SESSION['user_id'])): ?>
                    <button id="bookmarkBtn"
                        class="btn btn-sm btn-outline-secondary bookmark-btn ms-auto <?= $bookmarked ? 'bookmarked' : '' ?>"
                        data-article-id="<?= $article['article_id'] ?>">
                        <i class="<?= $bookmarked ? 'bi bi-bookmark-fill' : 'bi bi-bookmark' ?>"></i>
                        <span class="bm-label"><?= $bookmarked ? 'Bookmarked' : 'Bookmark' ?></span>
                    </button>
                <?php endif; ?>
            </div>

            <!-- Article content -->
            <div class="article-content mb-5">
                <?= $article['content'] /* trusted HTML from admin */ ?>
            </div>

            <!-- Tags -->
            <?php if (!empty($tags)): ?>
                <div class="mb-4">
                    <h6 class="text-muted text-uppercase small mb-2">Tags</h6>
                    <div class="tag-cloud">
                        <?php foreach ($tags as $t): ?>
                            <a href="<?= BASE_URL ?>/tag/<?= $t['slug'] ?>" class="tag-pill">
                                #<?= htmlspecialchars($t['name']) ?>
                            </a>
                        <?php endforeach; ?>
                    </div>
                </div>
            <?php endif; ?>

            <!-- Rating -->
            <div class="gn-sidebar-widget mb-4">
                <div class="widget-title"><i class="bi bi-star-fill me-1"></i>Rate this Article</div>
                <div class="d-flex align-items-center gap-3">
                    <?php if (!empty($_SESSION['user_id'])): ?>
                        <div id="starRating" class="star-rating"
                            data-article-id="<?= $article['article_id'] ?>"
                            data-user-rating="<?= $userRating ?>">
                            <?php for ($i = 1; $i <= 5; $i++): ?>
                                <button class="star-btn <?= $i <= $userRating ? 'active' : '' ?>"
                                    data-value="<?= $i ?>" title="<?= $i ?> star">
                                    <i class="bi bi-star-fill"></i>
                                </button>
                            <?php endfor; ?>
                        </div>
                    <?php else: ?>
                        <p class="text-muted small mb-0">
                            <a href="<?= BASE_URL ?>/auth/login" class="text-accent">Login</a> to rate this article.
                        </p>
                    <?php endif; ?>
                    <span class="text-muted small">
                        Avg: <strong id="avgRating" class="text-accent"><?= $avgRating ?></strong>/5
                    </span>
                </div>
            </div>

            <!-- Comments -->
            <h3 class="section-heading"><i class="bi bi-chat-left-text"></i> Comments (<?= count($comments) ?>)</h3>

            <div id="commentList" class="mb-4">
                <?php foreach ($comments as $c): ?>
                    <div class="comment-item d-flex gap-3">
                        <div class="comment-avatar"><?= strtoupper(substr($c['username'], 0, 1)) ?></div>
                        <div class="flex-grow-1">
                            <div class="d-flex justify-content-between">
                                <strong class="small"><?= htmlspecialchars($c['username']) ?></strong>
                                <span class="small text-muted"><?= date('M d, Y', strtotime($c['created_at'])) ?></span>
                            </div>
                            <p class="mt-1 mb-0 small"><?= nl2br(htmlspecialchars($c['content'])) ?></p>
                        </div>
                    </div>
                <?php endforeach; ?>
                <?php if (empty($comments)): ?>
                    <p class="text-muted small">No comments yet. Be the first!</p>
                <?php endif; ?>
            </div>

            <!-- Submit comment -->
            <?php if (!empty($_SESSION['user_id'])): ?>
                <div class="gn-sidebar-widget">
                    <div class="widget-title"><i class="bi bi-pencil-square me-1"></i>Leave a Comment</div>
                    <form id="commentForm" data-article-id="<?= $article['article_id'] ?>">
                        <textarea class="form-control mb-3" rows="4" placeholder="Share your thoughts…" required minlength="3"></textarea>
                        <button type="submit" class="btn btn-accent">Post Comment</button>
                    </form>
                </div>
            <?php else: ?>
                <div class="alert alert-dark border border-secondary">
                    <a href="<?= BASE_URL ?>/auth/login" class="text-accent">Login</a> to post a comment.
                </div>
            <?php endif; ?>

        </div>

        <!-- ── Sidebar ────────────────────────────────────────────────── -->
        <div class="col-lg-4">

            <!-- Related Articles -->
            <?php if (!empty($related)): ?>
                <div class="gn-sidebar-widget">
                    <div class="widget-title"><i class="bi bi-journals me-1"></i>Related Articles</div>
                    <?php foreach ($related as $r): ?>
                        <a class="sidebar-list-item" href="<?= BASE_URL ?>/article/<?= $r['slug'] ?>">
                            <img src="<?= $r['thumbnail'] ?? BASE_URL . '/public/images/placeholder.jpg' ?>"
                                alt="<?= htmlspecialchars($r['title']) ?>" loading="lazy">
                            <div>
                                <div class="item-title"><?= htmlspecialchars($r['title']) ?></div>
                                <div class="item-meta"><?= htmlspecialchars($r['category_name']) ?></div>
                            </div>
                        </a>
                    <?php endforeach; ?>
                </div>
            <?php endif; ?>

            <!-- Popular Tags -->
            <div class="gn-sidebar-widget">
                <div class="widget-title"><i class="bi bi-tags me-1"></i>Trending Tags</div>
                <div class="tag-cloud">
                    <?php foreach ($popularTags as $t): ?>
                        <a href="<?= BASE_URL ?>/tag/<?= $t['slug'] ?>" class="tag-pill">
                            #<?= htmlspecialchars($t['name']) ?>
                        </a>
                    <?php endforeach; ?>
                </div>
            </div>

            <!-- Categories -->
            <div class="gn-sidebar-widget">
                <div class="widget-title"><i class="bi bi-grid me-1"></i>Categories</div>
                <?php foreach ($categories as $cat): ?>
                    <a href="<?= BASE_URL ?>/category/<?= $cat['slug'] ?>"
                        class="d-block py-2 border-bottom border-secondary text-decoration-none text-white small">
                        <span style="color:<?= htmlspecialchars($cat['color'] ?? '#e63946') ?>">■</span>
                        <?= htmlspecialchars($cat['name']) ?>
                    </a>
                <?php endforeach; ?>
            </div>
        </div>
    </div>
</div>