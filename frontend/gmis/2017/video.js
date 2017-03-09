import $ from 'jquery';
import videojs from 'video.js';
import 'video.js/dist/video-js.min.css';

const video = () => {
  const player = videojs('gmis-player', {
    controls: true,
    autoplay: false,
    preload: 'auto'
  });

  const $overlay = $('#video-hero-overlay');
  player.on(['play', 'playing'], () => {
    $overlay.addClass('transparent');
  });

  player.on(['pause'], () => {
    $overlay.removeClass('transparent');
  });
};

export default video;
