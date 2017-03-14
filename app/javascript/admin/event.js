import $ from 'jquery';
import _ from 'lodash';

const event = () => {
  $(document).on('turbolinks:load', () => {
    // const event_id = $('#search_input').data('id');
    const event_id = '93919e38-186d-42d0-88de-6b36aa80f306';

    $('#search_input').on('input', function () {
      const text = $(this).val();
      $.ajax({
        method: 'GET',
        data: { 'q[name_cont]': text },
        url: '/admin/guests',
        dataType: 'json'
      }).done(data => {
        const temp = renderSearchResult(data);
        $('.js_search_result ul').replaceWith(temp);
        // render and replace search result
      }).fail(() => {
        // refresh and retry
      });
    });

    const renderSearchResult = elements => {
      const temp = _.template(
        '<ul>' +
          '<% _.forEach(result, function(ele){ %>' +
            '<li data-id=\'<%-ele.id%>\'><%-ele.name%></li>' +
          '<% }) %>' +
        '</ul>'
      );
      return temp({ result: elements });
    };

    const renderDisplayRow = element => {
      const html = $('.template').clone()
                                 .removeClass('hide template')
                                 .wrap('<p/>')
                                 .parent()
                                 .html();
      const temp = _.template(html);
      return temp({ ele: element });
    };

    // add a guest to event
    $('.js_search_result').on('click', 'li', e => {
      const guest_id = $(e.target).data('id');
      $.ajax({
        method: 'POST',
        data: { id: guest_id },
        url: `/admin/events/${event_id}/guests`,
        dataType: 'json'
      }).success(data => {
        $('.js_display').prepend(renderDisplayRow(data));
      }).fail(xhr => {
        if (xhr.status === 422) {
          alert(xhr.responseJSON.message);
        } else {
          // need refresh and try again
          console.log('need refresh and try again');
        }
      }).always(() => {

      });
    });

    // remove a guest form event
    $('.js_display').on('click', '.btn', function (e) {
      const guest_id = $(e.target).data('id');
      const current_dom = $(this).closest('tr');
      current_dom.remove();
      $.ajax({
        method: 'DELETE',
        data: { id: guest_id },
        url: `/admin/events/${event_id}/guests/${guest_id}`,
        dataType: 'json'
      }).success(() => {

      }).fail(() => {
        // alert error need reload
      });
    });
  });
};

export default event;
