class CalendarsController < ApplicationController
  def index
    @bookings = Booking.all
  end
end
