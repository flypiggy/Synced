const wavyLine = () => {
  const c = document.querySelector('.js-canvas-wavy');
  const ctx = c.getContext('2d');
  const sqrt = Math.sqrt, PI = Math.PI, sin = Math.sin, cos = Math.cos;
  const rand = 0.2;
  let w, h, t = 0;

  const trimUnit = (input_str, unit) => {
    return parseInt(input_str.split(unit)[0], 10);
  };

  const initCanvas = () => {
    const s = window.getComputedStyle(c);
    w = c.width = trimUnit(s.width, 'px');
    h = c.height = trimUnit(s.height, 'px');
  };

  const line = (rand, rand2) => {
    let x, y, x0 = -10, y0 = h / 2;

    for (x = 0; x < w; x += 2) {
      const v = Math.floor(x / 4 / 142) % 2 === 0 ? x / 4 % 142 : 142 - x / 4 % 142;

      y = rand * sqrt(x) * sin(x / 23 / PI + t / 3 + sin(x / 29 + t)) +
                  10 * sin(t) * cos(x / 19 + t / 7) +
                  rand2 * cos(t) * sin(sqrt(x)) + h / 2;
      ctx.beginPath();
      ctx.moveTo(x0, y0);
      ctx.lineTo(x++, y);
      ctx.lineWidth = 2;
      ctx.strokeStyle = `hsl(${337 - v}, 85%, 30%)`;
      ctx.stroke();
      x0 = x;
      y0 = y;
    }
  };

  const wave = () => {
    const t_step = 1 / 10;
    ctx.clearRect(0, 0, w, h);
    line(rand, 16);
    line(rand * 2, 20);
    line(rand * -1.5, 16);
    t += t_step;
    window.requestAnimationFrame(wave);
  };

  setTimeout(() => {
    initCanvas();
    wave();

    window.addEventListener('resize', initCanvas, false);
  }, 15);
};

export default wavyLine;
