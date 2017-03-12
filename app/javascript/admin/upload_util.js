import $ from 'jquery';

function uploadImage(container_id, config) {
  const default_config = {
    upload_element: '.image_preview_area',
    template: '.image_upload_template',
    remove_button: '.remove_button',
    limit_count: 0,
    changeTemplateAfterSelectn() {
      return $(this.template);
    }
  };

  config = Object.assign(default_config, config);

  // 是否超过数量
  const checkLimitValid = function () {
    if (config.limit_count === 0) { return true; }
    return config.limit_count >= $image_area.find(config.upload_element).length;
  };

  // 读取文件helper method
  const readInputFile = function (input, complete) {
    if (input.files && input.files[0]) {
      const reader = new FileReader();
      reader.onload = function (e) {
        complete(e.target.result);
      };
      reader.readAsDataURL(input.files[0]);
    }
  };

  const $image_area = $(container_id);
  const $upload_element = $(config.upload_element);
  if (!checkLimitValid()) { $(config.template).addClass('disappear'); }
  let template;

  $upload_element.on('focusin', () => {
    template = $(config.template).clone(true);
  }).on('change', function () {
    const $this = $(this);
    const $input = $this.find('input[type=file]');
    const $img = $this.find('img');

    if (!$img.length) { return; }
    readInputFile($input[0], file_url => {
      // 选取图片后，预览
      $img.attr('src', file_url);
      // 添加新的temp
      const template_class = config.template.substr(1);
      if (!$this.hasClass(template_class)) { return; }
      $this.removeClass(template_class);
      config.changeTemplateAfterSelect($this);
      if (checkLimitValid()) { $image_area.append(template); }
    });
  });

  // 点击选择图片
  $upload_element.on('click', function (e) {
    const $this = $(this);
    const $target = $(e.target);
    const $input = $this.find('input[type=file]');

    if (!$target.is('img')) { return; }
    $input.focus().trigger('click');
  });

  // 点击删除
  $upload_element.on('click', function (e) {
    const $button = $(e.target);
    const $this = $(this);
    const $destroy_field = $this.find('input[type=checkbox]');
    const remove_button_class = config.remove_button.substr(1);
    if (!$button.hasClass(remove_button_class)) { return; }
    $destroy_field.prop('checked', true);
    $this.removeClass(config.upload_element.substr(1));
    $this.addClass('disappear');
  });
}

export default uploadImage;
