class Booking < ApplicationRecord
  validates :email, :room, :start, presence: true

  def self.refreshEndDates
    Booking.all.each do |booking|
      if booking.end.blank?
        if ((DateTime.now - booking.start.to_datetime) * 24).to_i >= 2
          booking.end = DateTime.now
          booking.save
        end
      end
    end
  end

  def self.search(booking)
    refreshEndDates
    where("room = ? and start = ? and (end IS NULL or end = '')", booking.room, booking.start)
  end

  def self.searchUserBookedRoom(room)
    refreshEndDates
    booking = where("room = ? and (end IS NULL or end = '')", room)
    if booking.present?
      booking.each do |b|
        return b.email
      end
    end
    nil
  end
end
