class Booking < ApplicationRecord
  validates :email, :room, :start, presence: true
  attr_accessor :start_date, :start_time

  def self.search(booking)
    where("room = ? and start = ? and (end IS NULL or end = '')", booking.room, booking.start)
  end
end
