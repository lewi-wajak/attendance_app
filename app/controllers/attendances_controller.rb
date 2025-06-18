class AttendancesController < ApplicationController
  before_action :authenticate_user!

  def index
    @attendances = current_user.attendances.order(created_at: :desc)
    @today_attendance = current_user.attendances.find_by(
      created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day
    )
  end
  
def check_in
  current_user.attendances.create!(check_in: Time.zone.now, location: params[:location])
  redirect_to attendances_path, notice: "You have checked in."
end

def check_out
  attendance = current_user.attendances.find(params[:id])
  attendance.update!(check_out: Time.zone.now, location: params[:location])
  redirect_to attendances_path, notice: "You have checked out."
end

end
