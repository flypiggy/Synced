class Admin::Guests::AvatarsController < ApplicationController
  def create
    find_guest
    create_avatar
    redirect_to edit_admin_guest_path(@guest.id)
  end

  def destroy
    find_guest
    destroy_avatar
    redirect_to edit_admin_guest_path(@guest.id)
  end

  private

  def find_guest
    @guest = Guest.find(params[:guest_id])
  end

  def create_avatar
    @guest.avatars.create(avatar_params)
  end

  def destroy_avatar
    avatar = @guest.avatars.find(params[:id])
    flash[:notice] = '删除成功' if avatar.destroy
  end

  def avatar_params
    params.require(:avatar).permit(:file)
  end
end
