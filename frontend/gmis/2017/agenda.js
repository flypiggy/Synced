import $ from 'jquery';
import Swiper from 'swiper';
import 'swiper/dist/css/swiper.css';
const $agendaDays = $('.js-agenda-days');

const agenda = () => {
  new Swiper('#agenda-container', {
    nextButton: '.agenda-button-next',
    prevButton: '.agenda-button-prev',
    onTransitionStart: s => {
      const $activeDay = $agendaDays.children('.day-header').eq(s.activeIndex);
      $activeDay.addClass('active').siblings().removeClass('active');
    }
  });
};

export default agenda;
