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

  def load_guests; end

  def load_guest; end

  def build_guest; end

  def guest_params; end
end
