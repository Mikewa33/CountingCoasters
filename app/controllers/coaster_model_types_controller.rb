class CoasterModelTypesController < ApplicationController
  before_action :set_coaster_model_type, only: [:show, :update, :destroy]

  # GET /coaster_model_types
  def index
    @coaster_model_types = CoasterModelType.all

    render json: @coaster_model_types
  end

  # GET /coaster_model_types/1
  def show
    render json: @coaster_model_type
  end

  # POST /coaster_model_types
  def create
    @coaster_model_type = CoasterModelType.new(coaster_model_type_params)

    if @coaster_model_type.save
      render json: @coaster_model_type, status: :created, location: @coaster_model_type
    else
      render json: @coaster_model_type.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /coaster_model_types/1
  def update
    if @coaster_model_type.update(coaster_model_type_params)
      render json: @coaster_model_type
    else
      render json: @coaster_model_type.errors, status: :unprocessable_entity
    end
  end

  # DELETE /coaster_model_types/1
  def destroy
    @coaster_model_type.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coaster_model_type
      @coaster_model_type = CoasterModelType.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def coaster_model_type_params
      params.fetch(:coaster_model_type, {})
    end
end
