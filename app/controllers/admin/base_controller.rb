class Admin::BaseController < ApplicationController
  include Pundit
  layout 'admin'

  after_action :verify_authorized
end
