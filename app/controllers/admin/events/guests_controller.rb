class Admin::Events::GuestsController < Admin::BaseController
  before_action :load_event
  def index
    @events_guests = @event.events_guests.rank(:rank_order)
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

  def update_order
    load_events_guest
    @events_guest.update(rank_order_position: params[:rank_order_position])
  end

  def update_show
    load_events_guest
    @events_guest.update(show: params[:show])
  end

  private

  def load_events_guest
    @events_guest = EventsGuest.find_by(event_id: params[:event_id], guest_id: params[:id])
  end

  def load_event
    @event = Event.includes(events_guests: :guest).find_by(id: params[:event_id])
    authorize @event, :index?
  end

  def load_guest
    @guest = Guest.find_by(id: params[:id])
  end
end
