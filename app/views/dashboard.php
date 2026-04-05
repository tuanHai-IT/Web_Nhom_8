<?php // app/views/admin/dashboard.php ?>
<div class="row g-4 mb-5">
    <div class="col-6 col-lg-3">
        <div class="stat-card">
            <div class="stat-icon"><i class="bi bi-newspaper"></i></div>
            <div>
                <div class="stat-num"><?= number_format($stats['articles']) ?></div>
                <div class="stat-label">Total Articles</div>
            </div>
        </div>
    </div>
    <div class="col-6 col-lg-3">
        <div class="stat-card">
            <div class="stat-icon"><i class="bi bi-people"></i></div>
            <div>
                <div class="stat-num"><?= number_format($stats['users']) ?></div>
                <div class="stat-label">Registered Users</div>
            </div>
        </div>
    </div>
    <div class="col-6 col-lg-3">
        <div class="stat-card">
            <div class="stat-icon"><i class="bi bi-chat-left-dots"></i></div>
            <div>
                <div class="stat-num"><?= number_format($stats['comments']) ?></div>
                <div class="stat-label">Total Comments</div>
            </div>
        </div>
    </div>
    <div class="col-6 col-lg-3">
        <div class="stat-card">
            <div class="stat-icon" style="background:rgba(250,204,21,0.15)">
                <i class="bi bi-hourglass-split" style="color:#facc15"></i>
            </div>
            <div>
                <div class="stat-num" style="color:#facc15"><?= $stats['pending'] ?></div>
                <div class="stat-label">Pending Comments</div>
            </div>
        </div>
    </div>
</div>

<div class="d-flex justify-content-between align-items-center mb-3">
    <h5 class="mb-0" style="font-family:var(--font-display)">Latest Articles</h5>
    <a href="<?= BASE_URL ?>/admin/articles/create" class="btn btn-sm btn-accent">
        <i class="bi bi-plus-lg me-1"></i>New Article
    </a>
</div>

<div class="admin-table">
    <table class="table table-dark table-hover">
        <thead>
            <tr>
                <th>Title</th>
                <th>Category</th>
                <th>Status</th>
                <th>Views</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($latest as $a): ?>
            <tr>
                <td><?= htmlspecialchars($a['title']) ?></td>
                <td><?= htmlspecialchars($a['category_name']) ?></td>
                <td>
                    <span class="badge badge-<?= $a['status'] ?>">
                        <?= ucfirst($a['status']) ?>
                    </span>
                </td>
                <td><?= number_format($a['view_count']) ?></td>
                <td>
                    <a href="<?= BASE_URL ?>/admin/articles/edit/<?= $a['article_id'] ?>"
                       class="btn btn-xs btn-outline-secondary btn-sm">
                        <i class="bi bi-pencil"></i>
                    </a>
                </td>
            </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
</div>

<!-- ══════════════════════════════════════════════════════════════
     SECTION: Charts Row — Page Views + Category Distribution
     Chèn thêm bởi frontend. Dùng mock data.
     Backend cần truyền: $viewsData, $categoryStats
     ══════════════════════════════════════════════════════════════ -->
<div class="row g-4 mt-2 mb-4">

    <!-- ── Page Views Area Chart ────────────────────────────────── -->
    <div class="col-lg-8">
        <div class="dashboard-widget">
            <div class="widget-header">
                <h6 class="widget-title">
                    <i class="bi bi-graph-up"></i> Page Views
                </h6>
                <!-- Toggle: 7 ngày / 30 ngày / 90 ngày -->
                <div class="time-toggle" id="viewsToggle">
                    <button class="btn-toggle active" data-range="7">7D</button>
                    <button class="btn-toggle" data-range="30">30D</button>
                    <button class="btn-toggle" data-range="90">90D</button>
                </div>
            </div>

            <!-- Summary stats -->
            <div class="chart-summary">
                <div class="chart-summary-item">
                    <span class="chart-summary-value" id="totalViews">12,847</span>
                    <span class="chart-summary-label">Total Views</span>
                </div>
                <div class="chart-summary-item">
                    <span class="chart-summary-change up" id="viewsChange">
                        <i class="bi bi-arrow-up-short"></i> +14.2%
                    </span>
                    <span class="chart-summary-label">vs previous period</span>
                </div>
            </div>

            <!-- Chart canvas -->
            <div class="chart-container" style="height:260px">
                <canvas id="pageViewsChart"></canvas>
            </div>
        </div>
    </div>

    <!-- ── Category Distribution Donut ─────────────────────────── -->
    <div class="col-lg-4">
        <div class="dashboard-widget">
            <div class="widget-header">
                <h6 class="widget-title">
                    <i class="bi bi-pie-chart"></i> Categories
                </h6>
            </div>

            <div class="chart-container chart-container-sm">
                <canvas id="categoryChart"></canvas>
            </div>

            <!--
                MOCK DATA — Backend cần truyền $categoryStats dạng:
                [['name' => 'Reviews', 'count' => 18, 'color' => '#e63946'], ...]
            -->
            <ul class="category-legend" id="categoryLegend">
                <!-- Filled dynamically by JS -->
            </ul>
        </div>
    </div>
</div>

<!-- ══════════════════════════════════════════════════════════════
     SECTION: Tables Row — Top Articles + Status & Activity
     Backend cần truyền: $topArticles, $statusCounts, $activityLogs
     ══════════════════════════════════════════════════════════════ -->
<div class="row g-4 mb-4">

    <!-- ── Top 5 Most Viewed Articles ──────────────────────────── -->
    <div class="col-lg-7">
        <div class="dashboard-widget">
            <div class="widget-header">
                <h6 class="widget-title">
                    <i class="bi bi-trophy"></i> Top Viewed Articles
                </h6>
            </div>

            <!--
                MOCK DATA — Backend cần truyền $topArticles dạng:
                [['title' => '...', 'view_count' => 88230, 'category_name' => '...'], ...]
                Hiện tại lấy từ $latest có sẵn + sắp xếp lại theo view_count
            -->
            <table class="top-articles-table">
                <tbody>
                    <?php
                    // Sắp xếp $latest theo view_count giảm dần để hiển thị top bài
                    $topArticles = $latest;
                    usort($topArticles, function ($a, $b) {
                        return ($b['view_count'] ?? 0) - ($a['view_count'] ?? 0);
                    });
                    $rank = 1;
                    foreach ($topArticles as $article):
                        $rankClass = $rank <= 3 ? "rank-{$rank}" : 'rank-default';
                    ?>
                    <tr>
                        <td style="width:40px">
                            <div class="rank-badge <?= $rankClass ?>"><?= $rank ?></div>
                        </td>
                        <td>
                            <div class="top-article-title">
                                <?= htmlspecialchars($article['title']) ?>
                            </div>
                            <small class="text-muted"><?= htmlspecialchars($article['category_name']) ?></small>
                        </td>
                        <td class="text-end">
                            <span class="top-article-views">
                                <i class="bi bi-eye me-1" style="font-size:11px;color:var(--text-muted)"></i>
                                <?= number_format($article['view_count'] ?? 0) ?>
                            </span>
                        </td>
                    </tr>
                    <?php $rank++; endforeach; ?>
                </tbody>
            </table>
        </div>
    </div>

    <!-- ── Status Chart + Activity Feed ────────────────────────── -->
    <div class="col-lg-5">
        <div class="dashboard-widget">
            <!-- Mini status donut -->
            <div class="widget-header">
                <h6 class="widget-title">
                    <i class="bi bi-check2-circle"></i> Article Status
                </h6>
            </div>

            <div class="d-flex align-items-center gap-4 mb-2">
                <div class="chart-container-sm" style="max-width:120px">
                    <canvas id="statusChart"></canvas>
                </div>
                <!--
                    MOCK DATA — Backend cần truyền $statusCounts dạng:
                    ['published' => 35, 'draft' => 10, 'archived' => 4]
                -->
                <div class="d-flex flex-column gap-1" id="statusLegend">
                    <!-- Filled dynamically by JS -->
                </div>
            </div>

            <hr class="widget-divider">

            <!-- Activity Feed -->
            <div class="widget-header" style="margin-bottom:12px">
                <h6 class="widget-title">
                    <i class="bi bi-activity"></i> Recent Activity
                </h6>
            </div>

            <!--
                MOCK DATA — Backend cần truyền $activityLogs dạng:
                [['action' => 'article.create', 'details' => '...', 'created_at' => '...'], ...]
                Bảng activity_logs đã có trong DB, chỉ cần query & truyền vào view
            -->
            <ul class="activity-feed" id="activityFeed">
                <!-- Filled dynamically by JS with mock data -->
            </ul>
        </div>
    </div>
</div>
