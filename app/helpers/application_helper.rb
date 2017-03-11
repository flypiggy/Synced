module ApplicationHelper
  def page_id
    controller_names = controller_path.split('/')
    [controller_names, action_name].compact.flatten.join('-')
  end

  def active_when(name, value = controller_name)
    'active' if name == value
  end

  def device_mobile?
    browser.device.ipad? || browser.device.mobile?
  end
end
