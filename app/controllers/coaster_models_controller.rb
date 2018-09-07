class CoasterModelsController < ApplicationController
  before_action :set_coaster_model, only: [:show, :update, :destroy]

  # GET /coaster_models
  def index
    @coaster_models = CoasterModel.all

    render json: @coaster_models
  end

  # GET /coaster_models/1
  def show
    render json: @coaster_model
  end

  # POST /coaster_models
  def create
    @coaster_model = CoasterModel.new(coaster_model_params)

    if @coaster_model.save
      render json: @coaster_model, status: :created, location: @coaster_model
    else
      render json: @coaster_model.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /coaster_models/1
  def update
    if @coaster_model.update(coaster_model_params)
      render json: @coaster_model
    else
      render json: @coaster_model.errors, status: :unprocessable_entity
    end
  end

  # DELETE /coaster_models/1
  def destroy
    @coaster_model.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coaster_model
      @coaster_model = CoasterModel.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def coaster_model_params
      params.fetch(:coaster_model, {})
    end
end
