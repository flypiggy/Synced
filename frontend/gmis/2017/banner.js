import $ from 'jquery';
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

const banner = () => {
  let camera, scene, renderer, particle;
  let mouseX = 0, mouseY = 0;

  let windowHalfX = window.innerWidth / 2;
  let windowHalfY = window.innerHeight / 2;

  init();
  animate();
  function init() {
    camera = new PerspectiveCamera(75, window.innerWidth / window.innerHeight, 1, 5000);
    camera.position.z = 1000;

    scene = new Scene();

    const material = new SpriteMaterial({
      map: new CanvasTexture(generateSprite()),
      blending: AdditiveBlending
    });

    for (let i = 0; i < 300; i += 1) {
      particle = new Sprite(material);
      initParticle(particle, i * 10);
      scene.add(particle);
    }

    renderer = new WebGLRenderer();
    renderer.setClearColor(0x000000);
    renderer.setPixelRatio(window.devicePixelRatio);
    renderer.setSize(window.innerWidth, window.innerHeight);
    $('#banner').append(renderer.domElement);


    document.addEventListener('mousemove', onDocumentMouseMove, false);
    window.addEventListener('resize', onWindowResize, false);
  }

  function onWindowResize() {
    windowHalfX = window.innerWidth / 2;
    windowHalfY = window.innerHeight / 2;

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
    gradient.addColorStop(0.2, 'rgba(0, 255, 255, 1)');
    gradient.addColorStop(0.4, 'rgba(0, 0, 64, 1)');
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
    particle.scale.x = particle.scale.y = Math.random() * 32 + 16;

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

  function onDocumentMouseMove(event) {
    mouseX = event.clientX - windowHalfX;
    mouseY = event.clientY - windowHalfY;
  }

  let animaID;
  function animate() {
    animaID = requestAnimationFrame(animate);
    render();
  }

  function render() {
    TWEEN.update();

    camera.position.x += (mouseX - camera.position.x) * 0.05;
    camera.position.y += (-mouseY - camera.position.y) * 0.05;
    camera.lookAt(scene.position);
    renderer.render(scene, camera);
  }

  $('.js-menu-btn').on('click', function () {
    $(this).parent('.menu-list').toggleClass('is-active');
  });

  $(window).on('scroll', () => {
    if (document.body.scrollTop <= window.innerHeight) {
      cancelAnimationFrame(animaID);
      animaID = requestAnimationFrame(animate);
    } else {
      cancelAnimationFrame(animaID);
    }
  });
};

export default banner;
