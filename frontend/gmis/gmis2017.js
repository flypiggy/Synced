import $ from 'jquery';

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

  $.scrollIt({ topOffset: -75 });
});
