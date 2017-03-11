const layout = () => {
  $(document).on('turbolinks:load', () => {
    $('.sidebar-collapse').sideNav({
      menuWidth: 240
    });

    Waves.displayEffect();

    function fullScreen(){
      document.fullScreenElement && null !== document.fullScreenElement || !document.mozFullScreen && !document.webkitIsFullScreen ?
        document.documentElement.requestFullScreen ?
        document.documentElement.requestFullScreen() :
          document.documentElement.mozRequestFullScreen ?
          document.documentElement.mozRequestFullScreen() :
            document.documentElement.webkitRequestFullScreen && document.documentElement.webkitRequestFullScreen(Element.ALLOW_KEYBOARD_INPUT) :
      document.cancelFullScreen ?
      document.cancelFullScreen() :
        document.mozCancelFullScreen ?
        document.mozCancelFullScreen() :
          document.webkitCancelFullScreen && document.webkitCancelFullScreen()
    }

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

    $(".dropdown-button").dropdown({
      inDuration: 300,
      outDuration: 125,
      constrain_width: true,
      hover: false,
      alignment: "left",
      gutter: 0,
      belowOrigin: true
    });

    // switch full screen event
    $(".toggle-fullscreen").click(() => fullScreen());

    // perfect scrollbar
    const topbar_t = $(".page-topbar").height();
    const topbar_h = window.innerHeight - topbar_t;
    $(".leftside-navigation")
      .height(topbar_t)
      .perfectScrollbar({ suppressScrollX: true });

    // loading loader anima
    setTimeout(function() {
        $("body").addClass("loaded")
    }, 200);

  });
};

export default layout;
