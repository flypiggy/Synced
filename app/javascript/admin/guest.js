import uploadImage from './upload_util';

const guest = () => {
  $(document).on('turbolinks:load', () => {
    $('.guest_form_modal').modal({
      ready: function(modal, trigger) {
        uploadImage('#image_area', {
          limit_count: 6,
          changeTemplateAfterSelect: (template)=>{
            let count = $('#image_area').find('.image_preview_area').size() - 1;
            template.find('input[type=file]').attr('name', 'guest[avatars_attributes][' + count + '][file]');
            template.find('input.js_delete_image').attr('name', 'guest[avatars_attributes][' + count + '][_destroy]');
            template.find('input.js_set_to_default').attr('name', 'guest[avatars_attributes][' + count + '][default]');
            template.find('.remove_button').removeClass('disappear');
            template.find('.js_set_default_btn').removeClass('disappear');
          }
        });

        /* 设定默认头像 */
        $('.image_preview_area').on('click', function(e){
          const $this = $(this),
                $target= $(e.target);
          if (!$target.hasClass('js_set_default_btn')) { return };
          const check_box = $this.find('.js_set_to_default');
          $('.js_set_to_default').prop('checked', false);
          check_box.prop('checked', true);
          $('.image_preview_area').removeClass('default_avatar');
          $this.addClass('default_avatar');
        })
      }
    })
  })
};

export default guest;
