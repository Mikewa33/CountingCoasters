class ModelLinesController < ApplicationController
  before_action :set_model_line, only: [:show, :update, :destroy]

  # GET /model_lines
  def index
    @model_lines = ModelLine.all

    render json: @model_lines
  end

  # GET /model_lines/1
  def show
    render json: @model_line
  end

  # POST /model_lines
  def create
    @model_line = ModelLine.new(model_line_params)

    if @model_line.save
      render json: @model_line, status: :created, location: @model_line
    else
      render json: @model_line.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /model_lines/1
  def update
    if @model_line.update(model_line_params)
      render json: @model_line
    else
      render json: @model_line.errors, status: :unprocessable_entity
    end
  end

  # DELETE /model_lines/1
  def destroy
    @model_line.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_model_line
      @model_line = ModelLine.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def model_line_params
      params.fetch(:model_line, {})
    end
end
