class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  # GET /bookings
  # GET /bookings.json
  def index
    @bookings = Booking.all
  end

  # GET /bookings/1
  # GET /bookings/1.json
  def show
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
        if existingBookings.present?
          flash.now[:danger] = 'An existing booking exists for the slot.'
        elsif @booking.save
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
    @room = Room.find_by(number: params[:room])
    if @booking.email != current_user.email and !current_user.admin

    end
    redirect_to home_path, notice: 'Booking was successfully destroyed.'
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
