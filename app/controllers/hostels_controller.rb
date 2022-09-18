class HostelsController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:show]
  before_action :set_hostel, only: %i[ show edit update destroy approve unapprove ]

  # GET /hostels
  def index
    # if params[:name]
    #   @hostels = Hostel.where('name ILIKE ?', "%#{params[:name]}%") # case-insensitive
    # else
    #   # @hostels = Hostel.all

    #   # @q = Hostel.ransack(params[:q])
    #   # @hostels = @q.result.includes(:user)

    # end

    @ransack_hostels = Hostel.published.approved.ransack(params[:hostels_search], search_key: :hostels_search)
    # @hostels = @ransack_hostels.result.includes(:user)
    @pagy, @hostels = pagy(@ransack_hostels.result.includes(:user))
  end

  def created 
    @pagy, @hostels = pagy(Hostel.where(user: current_user))
    render 'index'
  end

  def unapproved
    @pagy, @hostels = pagy(Hostel.unapproved.where(user: current_user))
    render 'index'
  end

  def approve
    authorize @hostel, :approve?
    @hostel.update_attribute(:approved, true)
    redirect_to @hostel, notice: "Hotel approved and visible!"
  end

  def unapprove
    authorize @hostel, :approve?
    @hostel.update_attribute(:approved, false)
    redirect_to @hostel, notice: "Hotel unapproved and hidden!"
  end

  def show
    authorize @hostel
    @rooms = @hostel.rooms
    @enrollment_with_reviews = @hostel.enrollments.reviewed
  end

  # GET /hostels/new
  def new
    @hostel = Hostel.new
    authorize @hostel
  end

  # GET /hostels/1/edit
  def edit
    authorize @hostel
  end

  # POST /hostels
  def create
    @hostel = Hostel.new(hostel_params)
    authorize @hostel
    @hostel.user = current_user

    if @hostel.save
      redirect_to @hostel, notice: "Hotel was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /hostels/1
  def update
    authorize @hostel
    if @hostel.update(hostel_params)
      redirect_to @hostel, notice: "Hotel was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /hostels/1
  def destroy
    authorize @hostel
    @hostel.destroy
    redirect_to hostels_url, notice: "Hotel was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hostel
      @hostel = Hostel.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def hostel_params
      params.require(:hostel).permit(:name, :address, :description, :published, :avatar)
    end
end
