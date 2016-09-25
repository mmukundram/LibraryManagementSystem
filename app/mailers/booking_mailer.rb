class BookingMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.booking_mailer.new_booking.subject
  #
  def new_booking(booking, user)
    @booking = booking
    @user = user

    mail to: @user.email, subject: "New Booking by #{@booking.email}"
  end
end
