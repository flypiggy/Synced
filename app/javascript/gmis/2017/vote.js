import $ from 'jquery';
import { isMobileUA } from 'mdetect';
import { scrollTop } from '../../common/tool';

const vote = () => {
  const $voteContent = $('#js-vote-content');
  const $voteOption = $voteContent.find('.vote-option');
  const retainLeft = 100;
  const retainRight = 20;
  const canVote = 5; // Max can be vote everyday

  // Set length according to the number of vote
  const votes = $voteOption.map(function () {
    return Number($(this).data('vote'));
  });

  const maxVote = Math.max(...votes);
  const maxWidth = (isMobileUA() ? $voteOption.innerWidth() : 310) - retainLeft - retainRight;

  $voteOption.each(function () {
    const $this = $(this);
    const vote = Number($this.data('vote'));
    const ratio = vote / maxVote;

    $(window).on('scroll', arrive);

    function arrive() {
      if (scrollTop() >= $this.offset().top - $(window).height()) {
        const $voteNumber = $this.find('.vote-number');
        $this.find('.vote-progress')
          .animate({ width: maxWidth * ratio + retainLeft }, 1000, 'linear');

        const timer = setInterval(() => {
          const val = Number($voteNumber.text()) + 2;
          if (val <= vote) {
            $voteNumber.text(val);
          } else {
            $voteNumber.text(vote);
            clearInterval(timer);
          }
        }, 1000 / vote * 2);

        $(window).off('scroll', arrive);
      }
    }
  });

  //
  const getToday = () => {
    const today = new Date();
    return `${today.getFullYear()}-${today.getMonth() + 1}-${today.getDate()}`;
  };

  const $voteBtn = $voteContent.find('.vote-btn');
  let isLoading = false;

  $voteBtn.on('click', function () {
    if (isLoading) return;

    const today = getToday();
    const $this = $(this);
    const $voteNumber = $this.siblings('.vote-progress').find('.vote-number');
    const url = $this.closest('.vote-option').data('url');

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
      url,
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
