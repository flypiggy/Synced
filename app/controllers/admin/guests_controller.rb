class Admin::GuestsController < Admin::BaseController
  def index
    load_guests
  end

  def new
    build_guest
  end

  def create
    if save_guest
      create_avatar
      flash[:notice] = '创建成功'
      redirect_to params[:continue] ? new_admin_guest_path : admin_guests_path
    else
      flash.now[:error] = @guest.errors.full_messages
      render :new
    end
  end

  def edit
    load_guest
  end

  def update
    load_guest
    if update_guest
      create_avatar
      flash.now[:notice] = '更新成功'
    else
      flash.now[:error] = @guest.errors.full_messages
    end
    render :edit
  end

  def destroy
    load_guest
    flash[:notice] = '删除成功' if destroy_guest
    redirect_to admin_guests_path
  end

  private

  def load_guests
    @guests = Guest.all.order(created_at: :desc).page(params[:page]).per(10)
  end

  def load_guest
    @guest = Guest.find(params[:id])
  end

  def build_guest
    @guest = Guest.new
  end

  def update_guest
    @guest.update(guest_params)
  end

  def save_guest
    @guest = Guest.new(guest_params)
    @guest.save
  end

  def create_avatar
    @avatar = @guest.avatars.create(avatar_params) if params[:avatar]
  end

  def destroy_guest
    @guest.destroy
  end

  def guest_params
    params.require(:guest).permit(:name, :company, :title)
  end

  def avatar_params
    params.require(:avatar).permit(:file)
  end
end
