import $ from 'jquery';
import _ from 'lodash';
import 'flatpickr';
import 'flatpickr/dist/flatpickr.min.css';

import { addSortUtil, searchUtil } from '../common/tool';

const event = () => {
  $(document).on('turbolinks:load', () => {
    const event_id = $('.wrapper-content').data('event-id');
    $('.selector').flatpickr({
      enableTime: true
    });

    searchUtil({
      search_url: '/admin/guests',
      getSelectedUrl: () => { return `/admin/events/${event_id}/guests`; },
      afterSelectItem: data => { $('.js_display').prepend(renderDisplayRow(data)); }
    });

    addSortUtil({
      getParams: (item, item_position) => {
        return { events_guest: { rank_order_position: item_position } };
      },
      getUrl: (element, item) => {
        const guest_id = item.data('id');
        return `/admin/events/${event_id}/guests/${guest_id}`;
      }
    });

    const renderDisplayRow = element => {
      const html = $('.template').clone()
                                 .removeClass('hide template')
                                 .wrap('<p/>')
                                 .parent()
                                 .html();
      const temp = _.template(html);
      return temp({ ele: element });
    };

    // patch showing or not showing
    $('.js_display').on('click', 'input', function () {
      const $this = $(this);
      const current_tr = $this.closest('tr');
      const guest_id = current_tr.data('id');
      const showing = $this.prop('checked');
      $.ajax({
        method: 'PATCH',
        url: `/admin/events/${event_id}/guests/${guest_id}`,
        data: { events_guest: { show: showing } },
        dataType: 'json'
      }).fail(() => {
        alert('error need reload');
      });
    });

    // remove a guest form event
    $('.js_display').on('click', '.btn', function () {
      const current_tr = $(this).closest('tr');
      const guest_id = current_tr.data('id');
      current_tr.remove();
      $.ajax({
        method: 'DELETE',
        url: `/admin/events/${event_id}/guests/${guest_id}`,
        dataType: 'json'
      }).fail(() => {
        alert('error need reload');
      });
    });
  });
};

export default event;
