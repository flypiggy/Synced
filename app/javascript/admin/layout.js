import $ from 'jquery';
import screenfull from 'screenfull';

const layout = () => {
  $(document).on('turbolinks:load', () => {
    $('.sidebar-collapse').sideNav({
      menuWidth: 240
    });

    Waves.displayEffect();

    // notification dropdown
    $('.notification-button').dropdown({
      inDuration: 300,
      outDuration: 225,
      constrainWidth: false,
      hover: true,
      gutter: 0,
      belowOrigin: true,
      alignment: 'right',
      stopPropagation: false
    });

    $('.dropdown-button').dropdown({
      inDuration: 300,
      outDuration: 125,
      constrain_width: true,
      hover: false,
      alignment: 'left',
      gutter: 0,
      belowOrigin: true
    });

    // switch full screen event
    $('.toggle-fullscreen').click(() => {
      if (screenfull.enabled) {
        screenfull.request();
      }
    });

    // perfect scrollbar
    const topbar_t = $('.page-topbar').height();
    // const topbar_h = window.innerHeight - topbar_t;
    $('.leftside-navigation')
      .height(topbar_t)
      .perfectScrollbar({ suppressScrollX: true });

    // loading loader anima
    setTimeout(() => {
      $('body').addClass('loaded');
    }, 200);
  });
};

export default layout;
