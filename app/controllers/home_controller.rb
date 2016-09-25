class HomeController < ApplicationController
  def index
    if !logged_in?
      flash.now[:danger] = 'You are not logged in. Please login to continue.'
    end
  end

  def history
    @booking = Booking.new
    if !logged_in?
      flash.now[:danger] = 'You are not logged in. Please login to continue.'
    elsif !current_user.admin
      flash.now[:danger] = 'You are not authorized to view this page.'
    end
  end
end
