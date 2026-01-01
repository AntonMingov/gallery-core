import Swiper from 'https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.mjs'

export default function swiper(){
  document.querySelectorAll('.swiper-slide-bg[data-bg-image]').forEach(slide => {
    const bgImage = slide.getAttribute('data-bg-image');
    if (bgImage) {
      slide.style.backgroundImage = `url('${bgImage}')`;
    }
  });

  const swiper =  new Swiper(".mySwiper", {
    pagination: {
      el: ".swiper-pagination",
    },
    centeredSlides: true,
    autoplay: {
      delay: 5000,
      disableOnInteraction: true,
    }
  })
}
