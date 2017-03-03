class Admin::GuestsController < Admin::BaseController
  def index
    load_guests
  end

  def new
    @guest = Guest.new
  end

  def create
    @guest = Guest.new(guest_params)
    if @guest.save
      redirect_to params[:continue] ? new_admin_guest_path : admin_guests_path
    else
      render :new
    end
  end

  def edit
    load_guest
  end

  def update
    load_guest
    @guest.update(guest_params)
    render :edit
  end

  def destroy
    load_guest
    @guest.destroy
    redirect_to admin_guests_path
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
end
