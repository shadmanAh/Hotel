class RoomsController < ApplicationController
  before_action :set_room, only: %i[ show edit update destroy ]

  # GET /rooms
  def index
    @rooms = Room.all
  end

  # GET /rooms/1
  def show
    # authorize @room
    @rooms = @hostel.rooms
  end

  # GET /rooms/new
  def new
    @room = Room.new
    @hostel = Hostel.friendly.find(params[:hostel_id])
  end

  # GET /rooms/1/edit
  def edit
    # authorize @room
  end

  def book
    @room.update_attribute(:book, true)
    redirect_to @room, notice: "Room booked for you!"
  end

  # POST /rooms
  def create
    @room = Room.new(room_params)
    @hostel = Hostel.friendly.find(params[:hostel_id])
    @room.hostel_id = @hostel.id
    authorize @room
    if @room.save
      redirect_to hostel_room_path(@hostel, @room), notice: "Room was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /rooms/1
  def update
    # authorize @room
    if @room.update(room_params)
      redirect_to hostel_room_path(@hostel, @room), notice: "Room was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /rooms/1
  def destroy
    # authorize @room
    @room.destroy
    redirect_to hostel_path(@hostel), notice: "Room was successfully destroyed."
  end

  private
    def set_room
      @hostel = Hostel.friendly.find(params[:hostel_id])
      @room = Room.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def room_params
      params.require(:room).permit(:title, :short_description, :description, :price, :capacity, :size, :bed, :book, :check_in, :check_out, :view)
    end
end
