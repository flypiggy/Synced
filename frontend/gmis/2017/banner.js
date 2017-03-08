import $ from 'jquery';
import scrollTo from 'jquery-scroll';
import 'jquery-mousewheel';

import {
  PerspectiveCamera,
  Scene,
  SpriteMaterial,
  CanvasTexture,
  AdditiveBlending,
  Sprite,
  WebGLRenderer
} from 'three';

import TWEEN from 'tween.js';

import { scrollTop } from '../../common/tool';


const banner = () => {
  let camera, scene, renderer, particle;
  const $window = $(window);

  init();
  animate();
  function init() {
    camera = new PerspectiveCamera(75, window.innerWidth / window.innerHeight, 1, 2000);
    camera.position.z = 1000;

    scene = new Scene();

    const material = new SpriteMaterial({
      map: new CanvasTexture(generateSprite()),
      blending: AdditiveBlending
    });

    for (let i = 0; i < 200; i += 1) {
      particle = new Sprite(material);
      initParticle(particle, i * 10);
      scene.add(particle);
    }

    renderer = new WebGLRenderer();
    renderer.setClearColor(0x000000);
    renderer.setPixelRatio(window.devicePixelRatio);
    renderer.setSize(window.innerWidth, window.innerHeight);
    $('#banner').append(renderer.domElement);


    window.addEventListener('resize', onWindowResize, false);
  }

  function onWindowResize() {
    camera.aspect = window.innerWidth / window.innerHeight;
    camera.updateProjectionMatrix();

    renderer.setSize(window.innerWidth, window.innerHeight);
  }

  function generateSprite() {
    const canvas = document.createElement('canvas');
    canvas.width = 16;
    canvas.height = 16;

    const context = canvas.getContext('2d');
    const gradient = context.createRadialGradient(canvas.width / 2, canvas.height / 2, 0, canvas.width / 2, canvas.height / 2, canvas.width / 2);
    gradient.addColorStop(0, 'rgba(255, 255, 255, 1)');
    gradient.addColorStop(0.5, 'rgba(255, 255, 255, 1)');
    gradient.addColorStop(1, 'rgba(0, 0, 0, 0)');

    context.fillStyle = gradient;
    context.fillRect(0, 0, canvas.width, canvas.height);

    return canvas;
  }

  function initParticle(particle, delay) {
    const x = Math.random() * 4000 - 2000;
    const y = Math.random() * 1000 - 500;

    particle.position.set(x, y, 0);
    particle.visible = false;
    particle.scale.x = particle.scale.y = Math.random() * 12 + 6;

    new TWEEN.Tween(particle)
      .delay(delay)
      .to({}, 4000)
      .onComplete(() => initParticle(particle, delay))
      .start();

    setTimeout(() => {
      particle.visible = true;
    }, delay);

    new TWEEN.Tween(particle.position)
      .delay(delay)
      .to({ x, y, z: Math.random() * 4000 }, 4000)
      .start();

    new TWEEN.Tween(particle.scale)
      .delay(delay)
      .to({ x: 0.01, y: 0.01 }, 4000)
      .start();
  }

  let animaID;
  function animate() {
    animaID = requestAnimationFrame(animate);
    render();
  }

  function render() {
    TWEEN.update();
    camera.lookAt(scene.position);
    renderer.render(scene, camera);
  }


  $('.js-menu-btn').on('click', function () {
    $(this).parent('.menu-list').toggleClass('is-active');
  });

  $window.on('scroll', () => {
    if (scrollTop() <= window.innerHeight) {
      cancelAnimationFrame(animaID);
      animaID = requestAnimationFrame(animate);
    } else {
      cancelAnimationFrame(animaID);
    }
  });

  $window.on('mousewheel', scrollDown);

  function scrollDown(e) {
    const direction = e.deltaY < 0 ? 'down' : 'up';

    if (direction === 'down' && scrollTop() <= 100) {
      $window.off('mousewheel', scrollDown);
      $window.on('mousewheel', lockScroll);

      scrollTo({
        selector: '#guests',
        duration: 400,
        offset: 75,
        callback: () => {
          $window.on('mousewheel', scrollDown);
          $window.off('mousewheel', lockScroll);
        }
      });
    }
  }

  function lockScroll(e) {
    e.preventDefault();
  }
};

export default banner;
