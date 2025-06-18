class Attendance < ApplicationRecord
  belongs_to :user

  reverse_geocoded_by :latitude, :longitude,  address: :location
  after_validation :reverse_geocode  # this sets `location`
end
