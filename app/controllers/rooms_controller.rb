class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]

  # GET /rooms
  # GET /rooms.json
  def index
    if !logged_in?
      flash.now[:danger] = 'You are not logged in. Please login to continue.'
    elsif !current_user.admin
      flash.now[:danger] = "You are not authorized to view this page."
    else
      @rooms = Room.all
      # Add booked field based on start and end date
    end
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show
    if !logged_in?
      flash.now[:danger] = 'You are not logged in. Please login to continue.'
    else
      @room = Room.find(params[:id])
      if current_user.admin
        # Get library member who has booked the room
      end
    end
  end

  # GET /rooms/new
  def new
    if !logged_in?
      flash.now[:danger] = 'You are not logged in. Please login to continue.'
    elsif !current_user.admin
      flash.now[:danger] = 'You are not authorized to view this page.'
    else
      @room = Room.new
    end
  end

  # GET /rooms/1/edit
  def edit
    if !logged_in?
      flash.now[:danger] = 'You are not logged in. Please login to continue.'
    else
      @room = Room.find(params[:id])
      if !current_user.admin
        flash.now[:danger] = "You are not authorized to view this page."
        @room = nil
      end
    end
  end

  # POST /rooms
  # POST /rooms.json
  def create
    @room = Room.new(room_params)
    if @room.save
      redirect_to @room, notice: 'Room was successfully created.'
    else
      render :new
    end

  end

  # PATCH/PUT /rooms/1
  # PATCH/PUT /rooms/1.json
  def update
    if @room.update(room_params)
      redirect_to @room, notice: 'Room was successfully updated.'
    else
      render :edit
    end

  end

  # DELETE /rooms/1
  # DELETE /rooms/1.json
  def destroy
    @room.destroy
    redirect_to rooms_url, notice: 'Room was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_room
    @room = Room.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def room_params
    params.require(:room).permit(:number, :building, :size)
  end
end
