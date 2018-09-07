class ParksController < ApplicationController
  before_action :set_park, only: [:show, :update, :destroy]
  include JwtDecode
  # GET /parks
  def index
    expires_in 1.minute, public: true
    @parks = Park.all
    render json: @parks.to_json({:include => :coasters} )
  end

  # GET /parks/1
  def show
    render json: @park
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_park
      @park = Park.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def park_params
      params.fetch(:park, {})
    end
end
