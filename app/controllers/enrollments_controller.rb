class EnrollmentsController < ApplicationController
  before_action :set_enrollment, only: %i[ show edit update destroy ]

  # GET /enrollments
  def index
    # @enrollments = Enrollment.all
    # @pagy, @enrollments = pagy(Enrollment.all)

    @q = Enrollment.ransack(params[:q])
    @pagy, @enrollments = pagy(@q.result.includes(:user))

    authorize @enrollments
  end

  # GET /enrollments/1
  def show
  end

  # GET /enrollments/new
  def new
    @hostel = Hostel.friendly.find(params[:hostel_id])
    @enrollment = Enrollment.new
  end

  # GET /enrollments/1/edit
  def edit
    authorize @enrollment
  end

  # POST /enrollments
  def create
    # @enrollment.hostel_id = @hostel.id
    @hostel = Hostel.friendly.find('65')
    @enrollment = Enrollment.new(enrollment_params)
    # @enrollment.user_id = current.user_id

    if @enrollment.save
      redirect_to @enrollment, notice: "Enrollment was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /enrollments/1
  def update
    authorize @enrollment
    if @enrollment.update(enrollment_params)
      redirect_to @enrollment, notice: "Enrollment was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /enrollments/1
  def destroy
    authorize @enrollment
    @enrollment.destroy
    redirect_to enrollments_url, notice: "Enrollment was successfully destroyed."
  end

  
  private
      
    # Use callbacks to share common setup or constraints between actions.
    def set_enrollment
      @enrollment = Enrollment.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def enrollment_params
      params.require(:enrollment).permit(:rating, :review, :hostel_id, :user_id)
    end
end
