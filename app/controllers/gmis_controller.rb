class GmisController < ApplicationController
  layout false

  before_action :gmis_meta
  skip_before_action :verify_authenticity_token

  def index
    render template: 'gmis/2017'
  end

  def show
    render template: "gmis/#{params[:year]}"
  end

  def gmis_meta
    set_meta_tags title: 'Gmis'
  end
end
