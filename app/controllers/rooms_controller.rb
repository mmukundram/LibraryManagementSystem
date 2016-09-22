class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]

  def schedule
    # Show schedule of all rooms
  end

  def history
    # Show booking history of room
  end

  def search
    if params[:room].blank?
      @room = Room.new
    else
      @room = Room.new(room_params)
    end
    if params[:room] and (params[:room][:number] or params[:room][:building] or params[:room][:size])
      @rooms = Room.search(params[:room])
      if !@rooms.present?
        @rooms = nil
      else
        @rooms.each do |room|
          set_size_text room
        end
      end
    end
  end

  # GET /rooms
  # GET /rooms.json
  def index
    if !logged_in?
      flash.now[:danger] = 'You are not logged in. Please login to continue.'
    end

    if current_user.admin
      @rooms = Room.all
    end
    if params[:number] or params[:building] or params[:size]
      @rooms = Room.search(params).order("number ASC")
    end
    if @rooms
      @rooms.each do |room|
        set_size_text room
      end
    end
    # Add booked field based on start and end date
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show
    if !logged_in?
      flash.now[:danger] = 'You are not logged in. Please login to continue.'
    else
      @room = Room.find(params[:id])
      set_size_text @room
      if current_user.admin
        # Get library member who has booked the room
        # Show booking history button
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
      set_size_text @room
      if !current_user.admin
        flash.now[:danger] = "You are not authorized to view this page."
        @room = nil
      else
        # Admin can change status of room (book/release for member)
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

  def set_size_text (room)
    if room
      if room.size == 4
        room.sizetext = 'Small (4)'
      elsif room.size == 6
        room.sizetext = 'Medium (6)'
      else
        room.sizetext = 'Large (12)'
      end
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_room
    @room = Room.find_by_id(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def room_params
    params.require(:room).permit(:number, :building, :size)
  end
end
