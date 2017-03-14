class Admin::Events::GuestsController < Admin::BaseController
  before_action :load_event
  def index
    @guests = @event.guests
    @q = Guest.ransack(params[:q])
  end

  def create
    load_guest
    events_guest = @event.events_guests.new(guest_id: params[:id])
    if events_guest.save
      render json: @guest
    else
      render json: { message: events_guest.errors.full_messages.join(',') }, status: 422
    end
  end

  def destroy
    event_guest = @event.events_guests.find_by(guest_id: params[:id])
    event_guest.destroy
  end

  private

  def load_event
    @event = Event.find_by(id: params[:event_id])
  end

  def load_guest
    @guest = Guest.find_by(id: params[:id])
  end
end
