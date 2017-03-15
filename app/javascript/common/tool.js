import $ from 'jquery';
import _ from 'lodash';

export const scrollTop = () => window.pageYOffset || document.documentElement.scrollTop || document.body.scrollTop || 0;

// path can be single string or array
// eg: runPage('admin-guests-index', fn)
// or: runPage(['page-a', 'page-b'], video)
export const runPage = (path, fn) => {
  const pageID = $('body').attr('id');
  const map = {
    string: () => pageID === path,
    object: () => path.some(x => x === pageID)
  };
  const isAllow = map[typeof path]();

  if (isAllow) {
    fn();
  }
};

// element_id is container of the sort item list
// item_class is sort item's class
// you need to define the getUrl function and getParam function
export const addSortUtil = config => {
  const default_config = {
    element_id: '#sortable',
    item_class: '.sitem',
    getParams: () => {},
    getUrl: () => {}
  };
  config = Object.assign(default_config, config);
  $(config.element_id).sortable({
    axis: 'y',
    items: '.sitem',
    helper: (event, row) => {
      row.children().each(function () {
        // weird
        $(this).width($(this).width());
      });
      return row;
    },
    update: (event, ui) => {
      const position = ui.item.index();
      $.ajax({
        method: 'PATCH',
        data: config.getParams(ui.item, position),
        url: config.getUrl($(config.element_id), ui.item),
        dataType: 'json'
      }).fail(() => {
        // alert erro need reload
      });
    }
  });
};

// need a serch_util as container, need a search_input as input field , need a result dom to display search result.
export const searchUtil = config => {
  const default_config = {
    element_id: '#search_util',
    input_id: '#search_input',
    result_id: '#search_result',
    search_url: '',
    getSelectedUrl: () => {},
    afterSelectItem: () => {}
  };

  config = Object.assign(default_config, config);

  const emptySearchResult = () => {
    $(config.result_id).empty();
  };

  $('body').on('click', event => {
    if (!$(event.target).closest('.search_util').length) {
      emptySearchResult();
    }
  });

  $(config.input_id).on('input focus', function () {
    const text = $(this).val();
    if (text === '') {
      emptySearchResult();
      return;
    }
    $.ajax({
      method: 'GET',
      data: { 'q[name_cont]': text },
      url: config.search_url,
      dataType: 'json'
    }).done(data => {
      renderSearchResult(data);
    }).fail(() => {
      // refresh and retry
    });
  });

  // render search result
  const renderSearchResult = elements => {
    const temp = _.template(
      '<div id=\'search_result\'>' +
        '<div class=\'collection\'>' +
          '<% _.forEach(result, function(ele){ %>' +
            '<a class=\'collection-item\' data-id=\'<%-ele.id%>\'>' +
              '<img class=\'circle\' src=\'<%-ele.default_avatar.file.url%>\'>' +
              '<span><%-ele.name%></span>' +
            '</a>' +
          '<% }) %>' +
        '</div>' +
      '</div>'
    );
    const html = temp({ result: elements });
    $(config.result_id).replaceWith(html);
  };

  // select one element
  $(config.element_id).on('click', '#search_result a', e => {
    const select_item_id = $(e.target).data('id');
    $.ajax({
      method: 'POST',
      data: { id: select_item_id },
      url: config.getSelectedUrl(),
      dataType: 'json'
    }).success(data => {
      config.afterSelectItem(data);
    }).fail(xhr => {
      if (xhr.status === 422) {
        alert(xhr.responseJSON.message);
      } else {
        console.log('need refresh and try again');
      }
    });
  });
};
