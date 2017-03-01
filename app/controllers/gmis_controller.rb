class GmisController < ApplicationController
  layout false

  def index
    @event = Event.includes(votes: [:vote_items]).find_by(short_name: 'gmis2017')
    render template: 'gmis/2017'
  end

  def show
    render template: "gmis/#{params[:year]}"
  end
end
