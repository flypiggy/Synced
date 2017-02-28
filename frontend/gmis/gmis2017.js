import $ from 'jquery';
import { isMobileView } from 'mdetect';
import 'jquery-lazyload';
import eruda from 'eruda';

import header from './2017/header';
import agenda from './2017/agenda';
import address from './2017/address';
import banner from './2017/banner';
import vote from './2017/vote';


$(() => {
  header();
  banner();
  agenda();
  vote();
  address();

  $.scrollIt({ topOffset: isMobileView() ? 0 : -75 });
  $('.js-lazy').lazyload({
    threshold: 200,
    effect: 'fadeIn'
  });

  const isDev = process.env.NODE_ENV === 'development';
  if (isDev && isMobileView()) eruda.init();
});
