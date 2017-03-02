class Admin::GuestsController < Admin::BaseController
  def index
    load_guests
  end

  def new
    build_guest
  end

  def create
    build_guest
  end

  def edit
    load_guest
  end

  def update
    load_guest
    build_guest
  end

  def destroy
    load_guest
  end

  private

  def load_guests
    @guests = Guest.all.page(params[:page]).per(10)
  end

  def load_guest
    @guest = Guest.find(params[:id])
  end

  def build_guest; end

  def guest_params; end
end
