export default function initSmoothScroll() {
  document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function(e) {
      e.preventDefault();

      const targetId = this.getAttribute('href').substring(1);
      const targetElement = document.getElementById(targetId);

      if (targetElement) {
        targetElement.scrollIntoView({
          behavior: 'smooth'
        });
      }
    });
  });
}

export function initInfiniteScroll() {
  const loadMoreBtn = document.getElementById('loadMore');
  const grid = document.getElementById('category-grid');
  if (!loadMoreBtn || !grid) return;

  const locale = document.documentElement.lang || 'bg';
  const loadingText = loadMoreBtn.getAttribute('data-loading') || (locale === 'en' ? 'Loading...' : 'Зареждане...');
  const loadMoreText = loadMoreBtn.getAttribute('data-load-more') || (locale === 'en' ? 'Load more' : 'Зареди още');

  let page = parseInt(new URL(window.location.href).searchParams.get('page') || '1', 10);

  loadMoreBtn.addEventListener('click', async () => {
    page += 1;
    const url = new URL(window.location.href);
    url.searchParams.set('page', page.toString());
    url.searchParams.set('partial', '1');

    loadMoreBtn.disabled = true;
    loadMoreBtn.textContent = loadingText;

    try {
      const res = await fetch(url.toString(), { headers: { Accept: 'text/html' } });
      
      if (!res.ok) {
        throw new Error(`HTTP error! status: ${res.status}`);
      }

      const html = await res.text();
      const hasMore = res.headers.get('X-Has-More') === 'true';

      const temp = document.createElement('div');
      temp.insertAdjacentHTML('beforeend', html);
      Array.from(temp.children).forEach((el) => grid.appendChild(el));

      if (hasMore) {
        loadMoreBtn.disabled = false;
        loadMoreBtn.textContent = loadMoreText;
      } else {
        loadMoreBtn.remove();
      }
    } catch (error) {
      console.error('Error loading more items:', error);
      loadMoreBtn.disabled = false;
      loadMoreBtn.textContent = loadMoreText;
    }
  });
}