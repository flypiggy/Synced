$(document).on('turbolinks:load', () => {
  $('.sponsor_form_modal').modal({
    ready: function(modal, trigger) {
      uploadImage('#image_area', {
        limit_count: 6,
        changeTemplateAfterSelect: (template)=>{
          let count = $('#image_area').find('.image_preview_area').size() - 1;
          template.find('input[type=file]').attr('name', 'sponsor[logos_attributes][' + count + '][file]');
          template.find('input[type=checkbox]').attr('name', 'sponsor[logos_attributes][' + count + '][_destroy]');
          template.find('.remove_button').removeClass('disappear');
        }
      });
    }
  })
})

