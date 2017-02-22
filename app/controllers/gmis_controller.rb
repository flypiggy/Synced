class GmisController < ApplicationController
  layout false

  def index
    render template: 'gmis/2017'
  end

  def show
    render template: "gmis/#{params[:year]}"
  end
end
