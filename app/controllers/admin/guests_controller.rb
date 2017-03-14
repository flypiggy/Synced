class Admin::GuestsController < Admin::BaseController
  def index
    load_guests
    respond_to do |format|
      format.html
      format.js { render json: @guests }
    end
  end

  def new
    @guest = Guest.new
    authorize @guest
  end

  def create
    @guest = Guest.new(guest_params)
    authorize @guest
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
    authorize :guest
    @q = Guest.ransack(params[:q])
    @guests = @q.result.order(created_at: :desc).page(params[:page]).per(10)
  end

  def load_guest
    @guest = Guest.find(params[:id])
    authorize @guest
  end

  def guest_params
    params.require(:guest).permit(:name, :company, :title, avatars_attributes: [:id, :file, :default, :_destroy])
  end
end
