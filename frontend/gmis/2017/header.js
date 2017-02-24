import $ from 'jquery';

const header = () => {
  const $header = $('header.header');
  const $hamburger = $('.js-hamburger');

  $hamburger.on('click', () => {
    $hamburger.toggleClass('is-active');
    $header.toggleClass('is-active');
  });

  $('#gmis-nav a').on('click', () => {
    $hamburger.removeClass('is-active');
    $header.removeClass('is-active');
  });
};

export default header;
