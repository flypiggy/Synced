import $ from 'jquery';

// shared
import wavyLine from './shared/wavyLine';
import agenda from './2017/agenda';
import address from './2017/address';

$(() => {
  wavyLine();
  agenda();
  address();
});
