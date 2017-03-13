class Admin::EventsController < Admin::BaseController
  def index
    load_events
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to admin_events_path
    else
      render :new
    end
  end

  def edit
    load_event
    @event
  end

  def update
    load_event
    @event.update(event_params)
    render :edit
  end

  def destroy
    load_event
    @event.destroy
    redirect_to admin_events_path
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :event_type, :status, :start_date, :end_date, :short_name)
  end

  def load_events
    @events = Event.order(created_at: :desc).page(params[:page]).per(10)
  end

  def load_event
    @event = Event.find(params[:id])
  end
end
