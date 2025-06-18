class Admin::DashboardController < ApplicationController
 before_action :authenticate_user!
  before_action :require_admin

  def index
    @attendances = Attendance.includes(:user).order(created_at: :desc)
  end

  private

  def require_admin
    redirect_to root_path, alert: "Access denied" unless current_user.has_role?(:admin)
  end
end
