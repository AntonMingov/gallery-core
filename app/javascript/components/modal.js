export default function initModal() {
  const modal = document.getElementById('imageModal');
  const modalImage = document.getElementById('modalImage');
  const title = document.getElementById('modal-title');
  const closeModal = document.getElementById('closeModal');

  if (!modal || !modalImage || !closeModal) return;

  let previousActiveElement = null;
  let focusableElements = null;

  const getFocusableElements = () => {
    return modal.querySelectorAll(
      'button, [href], input, select, textarea, [tabindex]:not([tabindex="-1"])'
    );
  };

  const trapFocus = (e) => {
    if (!focusableElements || focusableElements.length === 0) return;

    const firstElement = focusableElements[0];
    const lastElement = focusableElements[focusableElements.length - 1];

    if (e.key === 'Tab') {
      if (e.shiftKey) {
        if (document.activeElement === firstElement) {
          e.preventDefault();
          lastElement.focus();
        }
      } else {
        if (document.activeElement === lastElement) {
          e.preventDefault();
          firstElement.focus();
        }
      }
    }
  };

  const open = (imageUrl, text, triggerElement) => {
    previousActiveElement = triggerElement || document.activeElement;
    modalImage.src = imageUrl;
    modalImage.alt = text || 'Full size image';
    title.textContent = text || '';
    modal.classList.remove('hidden');
    modal.setAttribute('aria-hidden', 'false');
    document.body.setAttribute('aria-hidden', 'true');
    document.body.style.overflow = 'hidden';

    focusableElements = getFocusableElements();
    closeModal.focus({ preventScroll: true });

    modal.addEventListener('keydown', trapFocus);
  };

  const close = () => {
    modal.classList.add('hidden');
    modal.setAttribute('aria-hidden', 'true');
    document.body.removeAttribute('aria-hidden');
    document.body.style.overflow = '';
    modalImage.src = '';
    modalImage.alt = 'Full size image';
    title.textContent = '';

    modal.removeEventListener('keydown', trapFocus);

    if (previousActiveElement) {
      previousActiveElement.focus();
      previousActiveElement = null;
    }
  };

  document.addEventListener('click', (e) => {
    const trigger = e.target.closest('.open-modal');
    if (!trigger) return;
    
    e.preventDefault();
    e.stopPropagation();
    
    const text = trigger.getAttribute('data-image-title');
    const imageUrl = trigger.getAttribute('data-image-url');
    
    if (imageUrl) {
      open(imageUrl, text, trigger);
    }
  });

  closeModal.addEventListener('click', close);

  document.addEventListener('keydown', (e) => {
    if (e.key === 'Escape' && !modal.classList.contains('hidden')) {
      close();
    }
  });

  modal.addEventListener('click', (e) => {
    if (e.target === modal) close();
  });
}