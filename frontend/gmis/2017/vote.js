import $ from 'jquery';
import { isMobileView } from 'mdetect';
// import Parallax from 'scroll-parallax';

const vote = () => {
  const $voteOption = $('.js-vote-option');
  const retainLeft = 100;
  const retainRight = 20;
  const canVote = 5;

  const votes = $voteOption.map(function () {
    return Number($(this).data('vote'));
  });

  const maxVote = Math.max(...votes);
  const maxWidth = (isMobileView() ? $voteOption.innerWidth() : 310) - retainLeft - retainRight;

  $voteOption.each(function () {
    const $this = $(this);
    const vote = Number($this.data('vote'));
    const ratio = vote / maxVote;
    $this.find('.vote-progress').innerWidth(maxWidth * ratio + retainLeft);
  });

  //
  const getToday = () => {
    const today = new Date();
    return `${today.getFullYear()}-${today.getMonth() + 1}-${today.getDate()}`;
  };

  const $voteBtn = $('.js-vote-btn');
  let isLoading = false;

  $voteBtn.on('click', function () {
    if (isLoading) return;

    const today = getToday();
    const $this = $(this);
    const $voteNumber = $this.siblings('.vote-progress').find('.vote-number');
    const id = $this.closest('.vote-option').data('id');

    const day = localStorage.getItem('__day__');
    if (day !== today || day === null) {
      localStorage.setItem('__day__', today);
      localStorage.removeItem('voted');
    }

    const voted = Number(localStorage.getItem('voted'));
    if (voted !== 0 && voted >= canVote) {
      alert(`每天最多可投${canVote}票`);
      return;
    }

    isLoading = true;
    $.ajax({
      method: 'POST',
      url: `http://gmis.lvh.me:8080/vote_up/${id}`,
      dataType: 'json'
    })
    .done(data => {
      $voteNumber.text(data.total);
      localStorage.setItem('voted', voted + 1);
    })
    .fail(xhr => {
      console.log(xhr);
    })
    .always(() => {
      isLoading = false;
    });
  });
};

export default vote;
