import $ from 'jquery';
import { isMobileUA } from 'mdetect';

import { scrollTop } from '../../common/tool';

const header = () => {
  const $header = $('header.header');

  if (isMobileUA()) {
    const $hamburger = $('.js-hamburger');
    $hamburger.on('click', () => {
      $hamburger.toggleClass('is-active');
      $header.toggleClass('is-active');
    });

    $('#gmis-nav a').on('click', () => {
      $hamburger.removeClass('is-active');
      $header.removeClass('is-active');
    });
  } else {
    $(window).on('scroll', () => {
      if (scrollTop() >= 400) {
        $header.addClass('is-active');
      } else {
        $header.removeClass('is-active');
      }
    });
  }
};

export default header;
