import $ from 'jquery';
import Swiper from 'swiper';
import { isMobileUA } from 'mdetect';
import 'swiper/dist/css/swiper.css';

import wavyLine from '../shared/wavyLine';

const $agendaDays = $('.js-agenda-days');
const agenda = () => {
  if (isMobileUA()) return;

  wavyLine();
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
