
import initRellax from "initRellax"
import swiper from "swiper"
import initSmoothScroll, { initInfiniteScroll } from "smooth-scroll"
import initModal from "modal"

initRellax();

const location = window.location.href;

if(!location.includes('categories')) {
  swiper();
}

document.addEventListener('DOMContentLoaded', () => {
  initSmoothScroll();
  initModal();
  if (location.includes('categories')) {
    initInfiniteScroll();
  }
});


