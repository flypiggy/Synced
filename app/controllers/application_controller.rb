class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  def render_404
    respond_to do |format|
      format.html { render file: Rails.root.join('public', '404'), layout: false, status: :not_found }
      format.js { head :not_found }
    end
  end

  private

  def redirect_url
    session[:redirect_url] || root_path
  end

  def current_user
    warden.user
  end

  def warden
    request.env['warden']
  end
end
