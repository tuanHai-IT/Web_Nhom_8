/**
 * public/js/admin.js
 * Admin panel AJAX actions: delete, approve, role update, category CRUD
 * SECURITY: CSRF token included in every POST request
 */
'use strict';

// ── Utility (shared pattern with app.js — CSRF-aware) ─────────────────────

/** AJAX POST with CSRF token */
async function adminPost(url, data = {}) {
    const fd = new FormData();
    fd.append('_token', CSRF_TOKEN);
    Object.entries(data).forEach(([k, v]) => fd.append(k, v));
    const res = await fetch(BASE_URL + url, {
        method: 'POST',
        headers: {
            'X-Requested-With': 'XMLHttpRequest',
            'X-CSRF-TOKEN': CSRF_TOKEN,
        },
        credentials: 'same-origin',
        body: fd,
    });
    if (!res.ok) throw new Error(`HTTP ${res.status}`);
    return res.json();
}

/** Toast notification */
function notify(msg, type = 'success') {
    const el = document.createElement('div');
    el.className = `alert alert-${type} position-fixed top-0 end-0 m-3 shadow`;
    el.style.zIndex = 9999;
    el.textContent = msg;
    document.body.appendChild(el);
    setTimeout(() => el.remove(), 3000);
}

// ── Articles ───────────────────────────────────────────────────────────────

async function deleteArticle(id) {
    if (!confirm('Delete this article? This cannot be undone.')) return;
    try {
        const data = await adminPost(`/admin/articles/delete/${id}`);
        if (data.success) { notify('Article deleted.'); location.reload(); }
        else notify('Delete failed.', 'danger');
    } catch (e) { notify('Error: ' + e.message, 'danger'); }
}

// ── Categories ─────────────────────────────────────────────────────────────

document.getElementById('addCatForm')?.addEventListener('submit', async e => {
    e.preventDefault();
    const form = e.target;
    const fd = new FormData(form);
    try {
        const data = await adminPost('/admin/categories/store', Object.fromEntries(fd));
        if (data.success) { notify('Category added.'); location.reload(); }
        else notify('Failed to add.', 'danger');
    } catch (err) { notify('Error: ' + err.message, 'danger'); }
});

function editCategory(cat) {
    document.getElementById('editCatId').value    = cat.category_id;
    document.getElementById('editCatName').value  = cat.name || cat.category_name;
    document.getElementById('editCatSlug').value  = cat.slug;
    document.getElementById('editCatDesc').value  = cat.description || '';
    document.getElementById('editCatColor').value = cat.color || '#e63946';
    new bootstrap.Modal(document.getElementById('editCatModal')).show();
}

document.getElementById('editCatForm')?.addEventListener('submit', async e => {
    e.preventDefault();
    const fd = new FormData(e.target);
    const id = fd.get('cat_id');
    fd.delete('cat_id');
    try {
        const data = await adminPost(`/admin/categories/update/${id}`, Object.fromEntries(fd));
        if (data.success) { notify('Category updated.'); location.reload(); }
        else notify('Update failed.', 'danger');
    } catch (err) { notify('Error: ' + err.message, 'danger'); }
});

async function deleteCategory(id) {
    if (!confirm('Delete category? Associated articles will lose their category.')) return;
    try {
        const data = await adminPost(`/admin/categories/delete/${id}`);
        if (data.success) { notify('Category deleted.'); location.reload(); }
        else notify('Delete failed.', 'danger');
    } catch (e) { notify('Error: ' + e.message, 'danger'); }
}

// ── Comments ───────────────────────────────────────────────────────────────

async function approveComment(id) {
    try {
        const data = await adminPost(`/admin/comments/approve/${id}`);
        if (data.success) {
            const badge = document.querySelector(`#comment-row-${id} .badge`);
            if (badge) { badge.className = 'badge bg-success'; badge.textContent = 'Approved'; }
            const btn = document.querySelector(`#comment-row-${id} .btn-outline-success`);
            if (btn) btn.remove();
            notify('Comment approved.');
        }
    } catch (e) { notify('Error: ' + e.message, 'danger'); }
}

async function deleteComment(id) {
    if (!confirm('Delete this comment?')) return;
    try {
        const data = await adminPost(`/admin/comments/delete/${id}`);
        if (data.success) {
            document.getElementById(`comment-row-${id}`)?.remove();
            notify('Comment deleted.');
        }
    } catch (e) { notify('Error: ' + e.message, 'danger'); }
}

// ── Users ──────────────────────────────────────────────────────────────────

async function updateRole(userId, roleId) {
    try {
        const data = await adminPost(`/admin/users/role/${userId}`, { role_id: roleId });
        if (data.success) notify('Role updated.');
        else notify('Update failed.', 'danger');
    } catch (e) { notify('Error: ' + e.message, 'danger'); }
}

// ══════════════════════════════════════════════════════════════
// Dashboard Charts — chỉ chạy khi ở trang dashboard
// MOCK DATA — comment rõ ràng cho backend biết cần truyền gì
// ══════════════════════════════════════════════════════════════

(function initDashboardWidgets() {
    // Chỉ init nếu đang ở trang dashboard (có canvas charts)
    if (!document.getElementById('pageViewsChart')) return;

    // ── Shared chart defaults (dark theme) ────────────────────
    Chart.defaults.color = '#7a7f8a';
    Chart.defaults.font.family = "'Roboto', sans-serif";
    Chart.defaults.plugins.legend.display = false;

    // ── Color palette ─────────────────────────────────────────
    const COLORS = {
        accent: '#e63946',
        blue: '#3a86ff',
        purple: '#8338ec',
        orange: '#fb5607',
        yellow: '#ffbe0b',
        green: '#06d6a0',
        pink: '#ff006e',
        cyan: '#00b4d8',
    };

    // ════════════════════════════════════════════════════════════
    // 1. PAGE VIEWS AREA CHART
    // MOCK DATA — Backend cần truyền $viewsData dạng JSON:
    //   { "7":  { labels: ["21/3","22/3",...], data: [120,340,...], total: 12847, change: 14.2 },
    //     "30": { labels: [...], data: [...], total: 38420, change: 8.5 },
    //     "90": { labels: [...], data: [...], total: 124500, change: 22.1 } }
    // ════════════════════════════════════════════════════════════

    function generateMockViewsData(days) {
        const labels = [];
        const data = [];
        const now = new Date();
        for (let i = days - 1; i >= 0; i--) {
            const d = new Date(now);
            d.setDate(d.getDate() - i);
            // Nhãn: ngày/tháng hoặc tuần tùy range
            if (days <= 30) {
                labels.push(`${d.getDate()}/${d.getMonth() + 1}`);
            } else {
                // Mỗi 7 ngày 1 nhãn
                if (i % 7 === 0) labels.push(`${d.getDate()}/${d.getMonth() + 1}`);
                else labels.push('');
            }
            // Random views with trending pattern
            const base = days === 7 ? 1200 : days === 30 ? 900 : 700;
            data.push(Math.floor(base + Math.random() * 800 + (days - i) * 15));
        }
        const total = data.reduce((s, v) => s + v, 0);
        return { labels, data, total };
    }

    const mockData = {
        7:  generateMockViewsData(7),
        30: generateMockViewsData(30),
        90: generateMockViewsData(90),
    };
    // Pre-calculate % change (mock)
    mockData[7].change  = 14.2;
    mockData[30].change = 8.5;
    mockData[90].change = 22.1;

    const ctx = document.getElementById('pageViewsChart').getContext('2d');

    // Gradient fill
    const gradient = ctx.createLinearGradient(0, 0, 0, 260);
    gradient.addColorStop(0, 'rgba(230, 57, 70, 0.25)');
    gradient.addColorStop(1, 'rgba(230, 57, 70, 0.01)');

    const pageViewsChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: mockData[7].labels,
            datasets: [{
                data: mockData[7].data,
                borderColor: COLORS.accent,
                backgroundColor: gradient,
                borderWidth: 2,
                fill: true,
                tension: 0.4,
                pointRadius: 3,
                pointBackgroundColor: COLORS.accent,
                pointBorderColor: '#161820',
                pointBorderWidth: 2,
                pointHoverRadius: 6,
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            interaction: { mode: 'index', intersect: false },
            scales: {
                x: {
                    grid: { color: 'rgba(255,255,255,0.03)', drawBorder: false },
                    ticks: { font: { size: 10 }, maxRotation: 0 },
                    border: { display: false },
                },
                y: {
                    grid: { color: 'rgba(255,255,255,0.03)', drawBorder: false },
                    ticks: {
                        font: { size: 10 },
                        callback: v => v >= 1000 ? (v / 1000).toFixed(1) + 'k' : v,
                    },
                    border: { display: false },
                    beginAtZero: true,
                }
            },
            plugins: {
                tooltip: {
                    backgroundColor: '#1c1e24',
                    borderColor: '#2a2d35',
                    borderWidth: 1,
                    titleFont: { weight: '600', size: 12 },
                    bodyFont: { size: 12 },
                    padding: 10,
                    displayColors: false,
                    callbacks: {
                        label: ctx => `${ctx.parsed.y.toLocaleString()} views`
                    }
                }
            }
        }
    });

    function updateViewsSummary(range) {
        const d = mockData[range];
        document.getElementById('totalViews').textContent = d.total.toLocaleString();
        const changeEl = document.getElementById('viewsChange');
        const isUp = d.change >= 0;
        changeEl.className = `chart-summary-change ${isUp ? 'up' : 'down'}`;
        changeEl.innerHTML = `<i class="bi bi-arrow-${isUp ? 'up' : 'down'}-short"></i> ${isUp ? '+' : ''}${d.change}%`;
    }
    updateViewsSummary(7);

    // Toggle event listeners
    document.getElementById('viewsToggle')?.addEventListener('click', e => {
        const btn = e.target.closest('.btn-toggle');
        if (!btn) return;
        const range = parseInt(btn.dataset.range);
        // Update active state
        document.querySelectorAll('#viewsToggle .btn-toggle').forEach(b => b.classList.remove('active'));
        btn.classList.add('active');
        // Update chart
        const d = mockData[range];
        pageViewsChart.data.labels = d.labels;
        pageViewsChart.data.datasets[0].data = d.data;
        pageViewsChart.update('active');
        updateViewsSummary(range);
    });


    // ════════════════════════════════════════════════════════════
    // 2. CATEGORY DISTRIBUTION DONUT
    // MOCK DATA — Backend cần truyền $categoryStats
    // ════════════════════════════════════════════════════════════

    const categoryData = [
        { name: 'Reviews',   count: 18, color: COLORS.accent },
        { name: 'News',      count: 14, color: COLORS.blue },
        { name: 'Previews',  count: 8,  color: COLORS.purple },
        { name: 'Guides',    count: 6,  color: COLORS.orange },
        { name: 'Esports',   count: 4,  color: COLORS.yellow },
        { name: 'Hardware',  count: 3,  color: COLORS.green },
    ];

    new Chart(document.getElementById('categoryChart'), {
        type: 'doughnut',
        data: {
            labels: categoryData.map(c => c.name),
            datasets: [{
                data: categoryData.map(c => c.count),
                backgroundColor: categoryData.map(c => c.color),
                borderColor: '#161820',
                borderWidth: 2,
                hoverOffset: 6,
            }]
        },
        options: {
            responsive: true,
            cutout: '68%',
            plugins: {
                tooltip: {
                    backgroundColor: '#1c1e24',
                    borderColor: '#2a2d35',
                    borderWidth: 1,
                    padding: 10,
                    callbacks: {
                        label: ctx => {
                            const total = ctx.dataset.data.reduce((a, b) => a + b, 0);
                            const pct = ((ctx.parsed / total) * 100).toFixed(1);
                            return ` ${ctx.label}: ${ctx.parsed} articles (${pct}%)`;
                        }
                    }
                }
            }
        }
    });

    // Build category legend
    const legendEl = document.getElementById('categoryLegend');
    if (legendEl) {
        const total = categoryData.reduce((s, c) => s + c.count, 0);
        legendEl.innerHTML = categoryData.map(c => {
            const pct = ((c.count / total) * 100).toFixed(0);
            return `<li>
                <span class="cat-dot" style="background:${c.color}"></span>
                <span class="cat-name">${c.name}</span>
                <span class="cat-count">${c.count} <small style="color:#7a7f8a">(${pct}%)</small></span>
            </li>`;
        }).join('');
    }


    // ════════════════════════════════════════════════════════════
    // 3. ARTICLE STATUS DONUT
    // MOCK DATA — Backend cần truyền $statusCounts
    // ════════════════════════════════════════════════════════════

    const statusData = {
        published: 35,
        draft: 10,
        archived: 4,
    };
    const statusColors = {
        published: '#4ade80',
        draft: '#facc15',
        archived: '#9ca3af',
    };

    new Chart(document.getElementById('statusChart'), {
        type: 'doughnut',
        data: {
            labels: ['Published', 'Draft', 'Archived'],
            datasets: [{
                data: [statusData.published, statusData.draft, statusData.archived],
                backgroundColor: [statusColors.published, statusColors.draft, statusColors.archived],
                borderColor: '#161820',
                borderWidth: 2,
                hoverOffset: 4,
            }]
        },
        options: {
            responsive: true,
            cutout: '62%',
            plugins: {
                tooltip: {
                    backgroundColor: '#1c1e24',
                    borderColor: '#2a2d35',
                    borderWidth: 1,
                    padding: 8,
                }
            }
        }
    });

    // Build status legend
    const statusLegend = document.getElementById('statusLegend');
    if (statusLegend) {
        const total = statusData.published + statusData.draft + statusData.archived;
        statusLegend.innerHTML = Object.entries(statusData).map(([key, val]) => {
            const pct = ((val / total) * 100).toFixed(0);
            return `<div class="d-flex align-items-center gap-2" style="font-size:12px">
                <span class="cat-dot" style="background:${statusColors[key]}"></span>
                <span style="color:#ccc;text-transform:capitalize">${key}</span>
                <span style="font-weight:700;color:#fff;font-family:var(--font-display)">${val}</span>
                <span style="color:#7a7f8a">(${pct}%)</span>
            </div>`;
        }).join('');
    }


    // ════════════════════════════════════════════════════════════
    // 4. ACTIVITY FEED
    // MOCK DATA — Backend cần truyền $activityLogs từ bảng activity_logs
    // ════════════════════════════════════════════════════════════

    const mockActivities = [
        { type: 'article', icon: 'bi-newspaper',      text: '<strong>admin</strong> published "<strong>Black Myth: Wukong Update</strong>"',    time: '2 hours ago' },
        { type: 'comment', icon: 'bi-chat-left-text',  text: '<strong>john_doe</strong> commented on "<strong>Elden Ring DLC</strong>"',          time: '3 hours ago' },
        { type: 'user',    icon: 'bi-person-plus',     text: 'New user <strong>gamer_2026</strong> registered',                                   time: '5 hours ago' },
        { type: 'article', icon: 'bi-pencil-square',   text: '<strong>gamer_writer</strong> updated "<strong>GPU Budget Guide</strong>"',         time: '8 hours ago' },
        { type: 'comment', icon: 'bi-chat-left-text',  text: '<strong>john_doe</strong> commented on "<strong>GTA VI</strong>"',                   time: '1 day ago' },
    ];

    const feedEl = document.getElementById('activityFeed');
    if (feedEl) {
        feedEl.innerHTML = mockActivities.map(a => `
            <li class="activity-item">
                <div class="activity-icon ${a.type}">
                    <i class="bi ${a.icon}"></i>
                </div>
                <div>
                    <div class="activity-text">${a.text}</div>
                    <span class="activity-time">${a.time}</span>
                </div>
            </li>
        `).join('');
    }

})(); // End initDashboardWidgets IIFE
