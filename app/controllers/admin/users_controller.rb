class Admin::UsersController < ApplicationController
   before_action :authenticate_user!
  before_action :require_admin

  def index
    @users = User.all
  end

  def update_role
    user = User.find(params[:id])
    if params[:role_action] == "promote"
      user.add_role(:admin)
    elsif params[:role_action] == "demote"
      user.remove_role(:admin)
    end
    redirect_to admin_users_path, notice: "User role updated"
  end

  private

  def require_admin
    redirect_to root_path, alert: "Access denied" unless current_user.has_role?(:admin)
  end
end
