class CoasterCompaniesController < ApplicationController
  before_action :set_coaster_company, only: [:show, :update, :destroy]

  # GET /coaster_companies
  def index
    @coaster_companies = CoasterCompany.all

    render json: @coaster_companies
  end

  # GET /coaster_companies/1
  def show
    render json: @coaster_company
  end

  # POST /coaster_companies
  def create
    @coaster_company = CoasterCompany.new(coaster_company_params)

    if @coaster_company.save
      render json: @coaster_company, status: :created, location: @coaster_company
    else
      render json: @coaster_company.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /coaster_companies/1
  def update
    if @coaster_company.update(coaster_company_params)
      render json: @coaster_company
    else
      render json: @coaster_company.errors, status: :unprocessable_entity
    end
  end

  # DELETE /coaster_companies/1
  def destroy
    @coaster_company.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coaster_company
      @coaster_company = CoasterCompany.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def coaster_company_params
      params.fetch(:coaster_company, {})
    end
end
