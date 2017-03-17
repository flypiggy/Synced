class Admin::Events::GuestsController < Admin::BaseController
  before_action :load_event
  def index
    @events_guests = @event.events_guests.rank(:rank_order)
  end

  def create
    load_guest
    @event.guests << @guest
    render json: @guest
  rescue ActiveRecord::RecordInvalid => e
    render json: { message: e.message }, status: 422
  end

  def destroy
    load_guest
    @event.guests.delete @guest
  end

  def update
    load_events_guest
    @events_guest.update(events_guest_params)
  end

  private

  def events_guest_params
    params.require(:events_guest).permit(:rank_order_position, :show)
  end

  def load_events_guest
    @events_guest = @event.events_guests.find_by!(guest_id: params[:id])
  end

  def load_event
    @event = Event.includes(events_guests: :guest).find_by(id: params[:event_id])
    authorize @event
  end

  def load_guest
    @guest = Guest.find(params[:id])
  end
end
