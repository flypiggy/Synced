class ApplicationController < ActionController::Base
  before_action :app_meta
  protect_from_forgery with: :exception

  def app_meta
    site = '机器之心'
    description = '机器之心全球机器智能峰会'
    set_meta_tags charset: 'UTF-8'
    set_meta_tags site: site
    set_meta_tags viewport: 'initial-scale=1.0,maximum-scale=1.0,width=device-width'
    set_meta_tags renderer: 'webkit|ie-comp'
    set_meta_tags description: description
    set_meta_tags keywords: ['Gmis', '机器之心', '全球机器智能峰会']
    set_meta_tags reverse: true
    set_meta_tags og: {
      url: request.original_url,
      description: description
    }
    set_meta_tags twitter: {
      url: request.original_url,
      description: description
    }
  end
end
