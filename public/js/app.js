/**
 * public/js/app.js — GameNexus
 * AJAX: live search, comments, star ratings, bookmark, load more, dark mode
 * SECURITY: CSRF tokens, XSS escaping, credentials handling
 */
'use strict';

// ── Utility ────────────────────────────────────────────────────────────────

/** Escape HTML to prevent XSS when inserting user-generated content */
function escapeHtml(str) {
    const div = document.createElement('div');
    div.textContent = str ?? '';
    return div.innerHTML;
}

/** AJAX helper — includes CSRF token and session cookie in every request */
async function apiFetch(url, options = {}) {
    const merged = {
        credentials: 'same-origin',
        ...options,
        headers: {
            'X-Requested-With': 'XMLHttpRequest',
            'X-CSRF-TOKEN': CSRF_TOKEN,
            ...(options.headers || {}),
        },
    };
    const res = await fetch(BASE_URL + url, merged);
    if (!res.ok) throw new Error(`HTTP ${res.status}`);
    return res.json();
}

/** Build a FormData from a plain object, auto-includes CSRF token */
function buildFormData(obj) {
    const fd = new FormData();
    fd.append('_token', CSRF_TOKEN);
    Object.entries(obj).forEach(([k, v]) => fd.append(k, v));
    return fd;
}

/** Toast notification */
function notify(msg, type = 'success') {
    const el = document.createElement('div');
    el.className = `alert alert-${type} position-fixed bottom-0 end-0 m-3 shadow`;
    el.style.zIndex = '9999';
    el.textContent = msg;
    document.body.appendChild(el);
    setTimeout(() => el.remove(), 3500);
}

// ── Dark mode ──────────────────────────────────────────────────────────────
(function initDarkMode() {
    const btn = document.getElementById('darkToggle');
    const html = document.documentElement;
    const saved = localStorage.getItem('gn-theme') || 'dark';
    html.setAttribute('data-bs-theme', saved);
    if (btn) {
        btn.querySelector('i').className = saved === 'dark' ? 'bi bi-moon-fill' : 'bi bi-sun-fill';
        btn.addEventListener('click', () => {
            const next = html.getAttribute('data-bs-theme') === 'dark' ? 'light' : 'dark';
            html.setAttribute('data-bs-theme', next);
            localStorage.setItem('gn-theme', next);
            btn.querySelector('i').className = next === 'dark' ? 'bi bi-moon-fill' : 'bi bi-sun-fill';
        });
    }
})();

// ── Live search ────────────────────────────────────────────────────────────
(function initSearch() {
    const input = document.getElementById('globalSearch');
    const dropdown = document.getElementById('searchDropdown');
    const form = document.getElementById('searchForm');
    if (!input) return;

    // Autocomplete dropdown on typing (unchanged)
    let timer;
    input.addEventListener('input', () => {
        clearTimeout(timer);
        const q = input.value.trim();
        if (q.length < 2) { dropdown.classList.add('d-none'); return; }
        timer = setTimeout(() => doAutocomplete(q), 300);
    });

    // Form submit → navigate to /search?q=keyword (Enter or button click)
    form?.addEventListener('submit', (e) => {
        const q = input.value.trim();
        if (q.length < 2) {
            e.preventDefault();
            input.focus();
            return;
        }
        // Hide autocomplete dropdown before navigating
        dropdown.classList.add('d-none');
        // Let the form submit naturally (GET /search?q=...)
    });

    async function doAutocomplete(q) {
        dropdown.innerHTML = '<div class="p-3 text-center"><div class="gn-spinner"></div></div>';
        dropdown.classList.remove('d-none');
        try {
            const data = await apiFetch(`/search?q=${encodeURIComponent(q)}&page=1`);
            const items = data.data || [];
            if (!items.length) {
                dropdown.innerHTML = `<div class="p-3 text-muted small">No results for "<strong>${escapeHtml(q)}</strong>"</div>`;
                return;
            }
            dropdown.innerHTML = items.slice(0, 6).map(a => `
                <a href="${BASE_URL}/article/${encodeURIComponent(a.slug)}" class="search-item">
                    ${a.thumbnail ? `<img src="${escapeHtml(a.thumbnail)}" alt="">` : '<div style="width:48px;height:36px;background:#2a2d35;border-radius:4px;flex-shrink:0"></div>'}
                    <div class="search-item-info">
                        <div class="title">${escapeHtml(a.title)}</div>
                        <div class="cat">${escapeHtml(a.category_name || '')}</div>
                    </div>
                </a>`).join('');
        } catch {
            dropdown.innerHTML = '<div class="p-3 text-muted small">Search error. Try again.</div>';
        }
    }
    document.addEventListener('click', e => {
        if (!input.contains(e.target) && !dropdown.contains(e.target)) dropdown.classList.add('d-none');
    });
})();

// ── Newsletter (UI only – show toast, no backend) ───────────────────────────
(function initNewsletter() {
    const forms = document.querySelectorAll('#newsletterForm, #footerNewsletterForm');
    forms.forEach(form => {
        if (!form) return;
        form.addEventListener('submit', (e) => {
            e.preventDefault();
            const email = form.querySelector('input[type=email]');
            if (email && email.value.trim()) {
                notify('Cảm ơn bạn đã đăng ký! Chúng tôi sẽ gửi tin mới nhất đến ' + email.value.trim(), 'success');
                email.value = '';
            }
        });
    });
})();

// ── Star rating ────────────────────────────────────────────────────────────
(function initRating() {
    const container = document.getElementById('starRating');
    if (!container || !USER_ID) return;

    const articleId = container.dataset.articleId;
    const stars = container.querySelectorAll('.star-btn');
    let current = parseInt(container.dataset.userRating || 0);

    function highlight(n) { stars.forEach((s, i) => s.classList.toggle('active', i < n)); }
    highlight(current);

    stars.forEach((star, i) => {
        star.addEventListener('mouseenter', () => highlight(i + 1));
        star.addEventListener('mouseleave', () => highlight(current));
        star.addEventListener('click', async () => {
            const rating = i + 1;
            try {
                const data = await apiFetch('/article/rate', {
                    method: 'POST',
                    body: buildFormData({ article_id: articleId, rating }),
                });
                if (data.success) {
                    current = rating;
                    highlight(rating);
                    const avgEl = document.getElementById('avgRating');
                    if (avgEl) avgEl.textContent = data.avg;
                    notify(`Rated ${rating}/5 ⭐`);
                } else {
                    notify(data.message || 'Unable to rate.', 'warning');
                }
            } catch (err) {
                notify('Error: ' + err.message, 'danger');
            }
        });
    });
})();

// ── Bookmark ───────────────────────────────────────────────────────────────
(function initBookmark() {
    const btn = document.getElementById('bookmarkBtn');
    if (!btn || !USER_ID) return;

    btn.addEventListener('click', async () => {
        const articleId = btn.dataset.articleId;
        try {
            const data = await apiFetch('/article/bookmark', {
                method: 'POST',
                body: buildFormData({ article_id: articleId }),
            });
            if (data.success) {
                btn.classList.toggle('bookmarked', data.bookmarked);
                btn.querySelector('.bm-label').textContent = data.bookmarked ? 'Bookmarked' : 'Bookmark';
                btn.querySelector('i').className = data.bookmarked ? 'bi bi-bookmark-fill' : 'bi bi-bookmark';
                notify(data.bookmarked ? 'Bookmark saved!' : 'Bookmark removed.');
            }
        } catch { notify('Unable to update bookmark.', 'danger'); }
    });
})();

// ── Comments ───────────────────────────────────────────────────────────────
(function initComments() {
    const form = document.getElementById('commentForm');
    if (!form) return;

    form.addEventListener('submit', async e => {
        e.preventDefault();
        const articleId = form.dataset.articleId;
        const textarea = form.querySelector('textarea');
        const content = textarea.value.trim();
        if (content.length < 3) { notify('Comment too short.', 'warning'); return; }

        const submitBtn = form.querySelector('[type=submit]');
        submitBtn.disabled = true;
        submitBtn.textContent = 'Posting…';

        try {
            const data = await apiFetch('/article/comment', {
                method: 'POST',
                body: buildFormData({ article_id: articleId, content }),
            });
            if (data.success) {
                textarea.value = '';
                notify(data.message || 'Comment posted!');
                // Show comment immediately without reload
                const list = document.getElementById('commentList');
                if (list) {
                    const noComment = list.querySelector('.text-muted');
                    if (noComment) noComment.remove();

                    const div = document.createElement('div');
                    div.className = 'comment-item d-flex gap-3';
                    div.innerHTML = `
                        <div class="comment-avatar">${escapeHtml((data.username || 'Y')[0].toUpperCase())}</div>
                        <div class="flex-grow-1">
                            <div class="d-flex justify-content-between">
                                <strong class="small">${escapeHtml(data.username || 'You')}</strong>
                                <span class="small text-muted">${escapeHtml(data.date || 'Just now')}</span>
                            </div>
                            <p class="mt-1 mb-0 small">${escapeHtml(data.content)}</p>
                        </div>`;
                    list.appendChild(div);

                    // Update comment count
                    const countEl = document.querySelector('.section-heading');
                    if (countEl) {
                        const match = countEl.textContent.match(/\d+/);
                        if (match) countEl.innerHTML = countEl.innerHTML.replace(/\(\d+\)/, `(${parseInt(match[0]) + 1})`);
                    }
                }
            } else {
                notify(data.message || 'Unable to post comment.', 'danger');
            }
        } catch (err) {
            notify('Error: ' + err.message, 'danger');
        } finally {
            submitBtn.disabled = false;
            submitBtn.textContent = 'Post Comment';
        }
    });
})();

// ── Load more ──────────────────────────────────────────────────────────────
(function initLoadMore() {
    const btn = document.getElementById('loadMoreBtn');
    if (!btn) return;
    const grid = document.getElementById('articleGrid');
    let page = 2;
    const categoryId = btn.dataset.categoryId || 0;

    btn.addEventListener('click', async () => {
        btn.innerHTML = '<div class="gn-spinner"></div>';
        btn.disabled = true;
        try {
            const data = await apiFetch(`/article/load-more?page=${page}&category_id=${categoryId}`);
            if (data.data && data.data.length) {
                data.data.forEach(a => {
                    const col = document.createElement('div');
                    col.className = 'col-md-6 col-lg-4 mb-4';
                    col.innerHTML = cardHTML(a);
                    grid.appendChild(col);
                });
                page++;
                if (page > data.pages) btn.remove();
            } else {
                btn.remove();
            }
        } catch { notify('Unable to load more.', 'danger'); }
        finally {
            if (btn.parentNode) {
                btn.innerHTML = 'Load More <i class="bi bi-arrow-down-circle ms-1"></i>';
                btn.disabled = false;
            }
        }
    });

    function cardHTML(a) {
        const thumb = escapeHtml(a.thumbnail || `${BASE_URL}/public/images/placeholder.jpg`);
        const date = a.published_at
            ? new Date(a.published_at).toLocaleDateString('en-US', { day: 'numeric', month: 'short', year: 'numeric' })
            : '';
        return `<div class="gn-card h-100">
            <a href="${BASE_URL}/article/${encodeURIComponent(a.slug)}">
                <img src="${thumb}" class="gn-card-img" alt="${escapeHtml(a.title)}" loading="lazy">
            </a>
            <div class="gn-card-body">
                <a href="${BASE_URL}/category/${encodeURIComponent(a.category_slug)}" class="card-cat-badge">${escapeHtml(a.category_name)}</a>
                <div class="gn-card-title"><a href="${BASE_URL}/article/${encodeURIComponent(a.slug)}">${escapeHtml(a.title)}</a></div>
                <div class="gn-card-meta"><i class="bi bi-calendar3 me-1"></i>${escapeHtml(date)}</div>
            </div>
        </div>`;
    }
})();

// ── Scroll-reveal (IntersectionObserver) ──────────────────────────────────
(function initScrollReveal() {
    /* ENHANCEMENT - GROUP 2 MICRO-INTERACTIONS: Stagger reveal cho cards/widgets */
    const targets = document.querySelectorAll('.gn-reveal, .gn-card, .gn-sidebar-widget');
    if (!targets.length) return;

    const observer = new IntersectionObserver((entries) => {
        entries.forEach((entry, index) => {
            if (entry.isIntersecting) {
                setTimeout(() => {
                    entry.target.classList.add('revealed');
                }, index * 120); // Stagger 120ms per item
                observer.unobserve(entry.target);
            }
        });
    }, {
        threshold: 0.1,
        rootMargin: '0px 0px -60px 0px' // Trigger sớm hơn
    });

    targets.forEach(el => observer.observe(el));
})();

// ── Carousel progress bar ─────────────────────────────────────────────────
(function initCarouselProgress() {
    const carousel = document.getElementById('heroCarousel');
    const bar = document.getElementById('carouselProgressBar');
    if (!carousel || !bar) return;

    function resetBar() {
        bar.classList.remove('running');
        // force reflow to restart animation
        void bar.offsetWidth;
        bar.classList.add('running');
    }

    // Start bar on page load
    resetBar();

    // Reset bar on each slide transition
    carousel.addEventListener('slid.bs.carousel', () => resetBar());

    // Pause progress on hover
    carousel.addEventListener('mouseenter', () => {
        bar.style.animationPlayState = 'paused';
        bar.style.transitionPlayState = 'paused';
    });
    carousel.addEventListener('mouseleave', () => {
        bar.style.animationPlayState = 'running';
        bar.style.transitionPlayState = 'running';
    });
})();

// ── Back to Top ───────────────────────────────────────────────────────────
(function initBackToTop() {
    const btn = document.getElementById('backToTop');
    if (!btn) return;

    let ticking = false;
    window.addEventListener('scroll', () => {
        if (!ticking) {
            window.requestAnimationFrame(() => {
                btn.classList.toggle('visible', window.scrollY > 400);
                ticking = false;
            });
            ticking = true;
        }
    }, { passive: true });

    btn.addEventListener('click', () => {
        window.scrollTo({ top: 0, behavior: 'smooth' });
    });
})();

// ── Navbar shrink on scroll ───────────────────────────────────────────────
(function initNavbarShrink() {
    const nav = document.querySelector('.gn-navbar');
    if (!nav) return;

    let ticking = false;
    window.addEventListener('scroll', () => {
        if (!ticking) {
            window.requestAnimationFrame(() => {
                nav.classList.toggle('gn-navbar-scrolled', window.scrollY > 80);
                ticking = false;
            });
            ticking = true;
        }
    }, { passive: true });
})();

// ── Footer contact form (UI-only toast) ───────────────────────────────────
(function initContactForm() {
    const form = document.getElementById('footerContactForm');
    if (!form) return;

    form.addEventListener('submit', (e) => {
        e.preventDefault();
        const name = form.querySelector('[name=name]')?.value.trim();
        if (name) {
            notify(`Cảm ơn ${name}! Tin nhắn của bạn đã được gửi thành công.`, 'success');
            form.reset();
        }
    });
})();
