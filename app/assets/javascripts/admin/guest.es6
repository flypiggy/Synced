$(document).on('turbolinks:load', () => {
  $('.modal').modal({
    ready: function(modal, trigger) {
      $('.js_input_image').find('input[type=file]').change(function(){
        let $this        = $(this),
            container    = $this.closest('.js_input_image'),
            image        = container.find('img'),
            close_button = container.find('a.disappear');
        read_upload_file(this, function(file_url){
          image.attr('src', file_url);
          close_button.removeClass('disappear');
        })
      });
      $('#image_area').append(generate_upload_image_template());
    }
  })

  $(document).on('click', 'form', function(e){
    const $btn = $(e.target);
    if (!$btn.hasClass('js_remove_image')) return;
    const $input_image = $btn.closest('.js_input_image');
    $input_image.addClass('disappear');
    $input_image.find('input[type=checkbox]').prop('checked', true);
  })

  let generate_upload_image_template = function(){
    let count    = $('#image_area').find('.js_input_image').size() - 1,
        template = $('.upload_image_template').clone(true);
    template.removeClass('disappear upload_image_template');
    template.find('input[type=file]').attr('name', 'guest[avatars_attributes][' + count + '][file]');
    template.find('input[type=checkbox]').attr('name', 'guest[avatars_attributes][' + count + '][_destroy]');
    template.find('input[type=file]').change(function(){
      $('#image_area').append(generate_upload_image_template());
    })
    return template
  }

  let read_upload_file = function(input, complete){
    if (input.files && input.files[0]) {
      var reader = new FileReader();
      reader.onload = function (e) {
        complete(e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }
  }
})
