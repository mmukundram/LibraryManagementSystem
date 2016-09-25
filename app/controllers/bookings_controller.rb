class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  # GET /bookings
  # GET /bookings.json
  def index
    if current_user.admin
      if params[:booking][:email].blank? and params[:booking][:room].blank?
        @bookings = Booking.all.order("start")
      elsif @bookings = Booking.findByUserAndRoom(params[:booking][:email], params[:booking][:room])
      end
    else
      @bookings = Booking.findByUser(current_user.email)
    end
  end

  # GET /bookings/1
  # GET /bookings/1.json
  def show
    @booking = Booking.find(params[:id])
  end

  # GET /bookings/new
  def new
    @room = Room.find_by(number: params[:room])
    @booking = Booking.new
    @booking.room = @room.number
    if !current_user.admin
      @booking.email = current_user.email
    end
  end

  # GET /bookings/1/edit
  def edit
  end

  # POST /bookings
  # POST /bookings.json
  def create
    @booking = Booking.new(booking_params)

    flag = true
    user = User.find_by(email: @booking.email)
    if user.blank?
      flash.now[:danger] = 'No user with that email exists'
    elsif user.admin
      flash.now[:danger] = 'An admin can only book on behalf of a library member, not (him|her)self or another admin.'
    elsif @booking.start.blank?
      flash.now[:danger] = 'Please enter a valid booking date and time'
    elsif @booking.start.to_i < DateTime.now.to_i
      flash.now[:danger] = 'You cannot book a room in the past.'
    elsif @booking.start.to_i >= (Date.today + 8).to_datetime.to_i
      flash.now[:danger] = 'You cannot book a room more than a week in advance.'
    else
      @booking.team.split(",").each do |str|
        str.chomp!()
        str.strip!()
        user = User.find_by(email: str)
        if user.blank?
          flag = false
          flash.now[:danger] = "No user with email " + str + " exists."
          break
        end
      end
      if flag
        existingBookings = Booking.search(@booking)
        userBooking = Booking.findActiveBookingByUser(@booking)
        if existingBookings.present?
          flash.now[:danger] = 'An existing booking exists for the slot.'
        elsif !current_user.admin and userBooking.present? and !user.privilege
          flash.now[:danger] = 'You have another active booking at the same time (contact the admin for the privilege to book multiple rooms at the same time)'
        elsif @booking.save
          // Send email here
          redirect_to @booking, notice: 'Booking was successfully created.'
          return
        end
      end
    end
    @room = Room.find_by(number: @booking.room)
    render :new
  end

  # PATCH/PUT /bookings/1
  # PATCH/PUT /bookings/1.json
  def update
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  def destroy
    @booking = Booking.find(params[:id])
    @booking.end = Booking.getEndTime(@booking.start)
    if @booking.save
      redirect_to home_path, notice: 'Booking was successfully released.'
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_booking
    @booking = Booking.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def booking_params
    params.require(:booking).permit(:room, :email, :start, :end, :team)
  end

end
