class Admin::GuestsController < Admin::BaseController
  layout :choice_layout
  def index
    load_guests
  end

  def new
    @guest = Guest.new
  end

  def create
    @guest = Guest.new(guest_params)
    @guest.save
  end

  def edit
    load_guest
  end

  def update
    load_guest
    @guest.update(guest_params)
  end

  def destroy
    load_guest
    @guest.destroy
  end

  private

  def load_guests
    @guests = Guest.order(created_at: :desc).page(params[:page]).per(10)
  end

  def load_guest
    @guest = Guest.find(params[:id])
  end

  def guest_params
    params.require(:guest).permit(:name, :company, :title)
  end

  def choice_layout
    action_name == 'index' && 'admin'
  end
end
