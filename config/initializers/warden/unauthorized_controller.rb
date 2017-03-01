class UnauthorizedController < ActionController::Metal
  include ActionController::UrlFor
  include ActionController::Redirecting
  include Rails.application.routes.url_helpers
  include Rails.application.routes.mounted_helpers

  def self.call(env)
    @respond ||= action(:respond)
    @respond.call(env)
  end

  def respond
    session[:unauthorized_user] = env['warden'].message
    redirect_to login_path
  end
end
