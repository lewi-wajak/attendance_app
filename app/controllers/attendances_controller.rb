class AttendancesController < ApplicationController
  before_action :authenticate_user!

  def index
    @attendances = current_user.attendances.order(created_at: :desc)
    @today_attendance = current_user.attendances.find_by(
      created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day
    )
  end
  
def check_in
  attendance = current_user.attendances.new(
    check_in: Time.zone.now,
    latitude: params[:latitude],
    longitude: params[:longitude]
  )
  attendance.reverse_geocode
  attendance.save!
  redirect_to attendances_path, notice: "You have checked in."
end

def check_out
  attendance = current_user.attendances.find(params[:id])
  attendance.latitude = params[:latitude]
  attendance.longitude = params[:longitude]
  attendance.check_out = Time.zone.now
  attendance.reverse_geocode
  attendance.save!
  redirect_to attendances_path, notice: "You have checked out."
end

end
