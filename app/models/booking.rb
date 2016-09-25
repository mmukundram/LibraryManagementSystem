class Booking < ApplicationRecord
  validates :email, :room, :start, presence: true

  def self.getEndTime(start)
    if DateTime.now < start
      start
    elsif ((DateTime.now - booking.start.to_datetime) * 24).to_i >= 2
      booking.start.to_datetime + (2/24.0)
    else
      DateTime.now
    end
  end

  def self.refreshEndDates
    Booking.all.each do |booking|
      if booking.end.blank?
        if ((DateTime.now - booking.start.to_datetime) * 24).to_i >= 2
          booking.end = Booking.getEndTime(booking.start)
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
    booking = where("room = ? and start <= ? and (end IS NULL or end = '')", room, DateTime.now)
    if booking.present?
      booking.each do |b|
        return b.email
      end
    end
    nil
  end

  def self.findByUser(email)
    where("email = ?", email).order("start")
  end

  def self.findByUserAndRoom(email, room)
    if email.blank?
      where("room = ?", room).order("start")
    elsif room.blank?
      where("email = ?", email).order("start")
    else
      where("room = ? and email = ?", room, email).order("start")
    end
  end

  def self.findActiveBookingByUser(booking)
    where("email = ? and start = ? and (end IS NULL or end = '')", booking.email, booking.start)
  end
end
