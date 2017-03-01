class SessionsController < ApplicationController
  def new
    redirect_to root_path if current_user
  end

  def create
    warden.authenticate!
    redirect_to redirect_url
  end
end
