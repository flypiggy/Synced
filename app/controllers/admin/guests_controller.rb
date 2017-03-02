class Admin::GuestsController < Admin::BaseController
  def index
    load_guests
  end

  def new
    build_guest
  end

  def create
    build_guest_with_params
    save_guest
  end

  def edit
    load_guest
  end

  def update
    load_guest
    update_guest
  end

  def destroy
    load_guest
    destroy_guest
  end

  private

  def load_guests
    @guests = Guest.all.order(:created_at).page(params[:page]).per(10)
  end

  def load_guest
    @guest = Guest.find(params[:id])
  end

  def build_guest
    @guest = Guest.new
  end

  def build_guest_with_params
    @guest = Guest.new(guest_params)
  end

  def update_guest
    if @guest.update(guest_params)
      flash.now[:notice] = '更新成功'
    else
      flash.now[:error] = @guest.errors.full_messages
    end
    render :edit
  end

  def save_guest
    if @guest.save
      flash[:notice] = '创建成功'
      redirect_to params[:continue] ? new_admin_guest_path : admin_guests_path
    else
      flash.now[:error] = @guest.errors.full_messages
      render :new
    end
  end

  def destroy_guest
    @guest.destroy
    flash[:notice] = '删除成功'
    redirect_to admin_guests_path
  end

  def guest_params
    params.require(:guest).permit(:name, :company, :title)
  end
end
