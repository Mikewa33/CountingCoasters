class ParksController < ApplicationController
  before_action :set_park, only: [:show, :set_visit_count]
  before_action :get_jwt_token, only: :show
  before_action :authenticate, only: :set_visit_count

  # GET /parks
  def index
    #expires_in 1.minutes, public: true
    @parks = Park.order(:id).all
    render json: @parks.to_json({:include => :coasters})
  end

  # GET /parks/1
  def show
    if @jwt
      #.new is a cheap hack to avoid checking multiple user_park nil checks
      user_park = @park.user_parks.where("user_id = ?", @jwt["sub"]).first || UserPark.new
      render json: @park.attributes.merge({has_visited: user_park.has_visited, visit_count: user_park.visit_count}).to_json({:include => :coasters})
    else
      puts @park.to_json
      render json: @park.to_json({:include => :coasters})
    end
  end
  #POST /parks/1/set_visit_count
  def set_visit_count
    user_park = @park.user_parks.where("user_id = ?", @jwt["sub"]).first || UserPark.new(user_id:  @jwt["sub"], park_id: @park.id)
    if params[:set_value]
      user_park.visit_count = params[:value]
    else
      if user_park.visit_count 
        user_park.visit_count = user_park.visit_count + params[:value]
      else
        user_park.visit_count = params[:value]
      end
    end
    user_park.save
    render json: @park.attributes.merge({has_visited: user_park.has_visited, visit_count: user_park.visit_count}).to_json({:include => :coasters})
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
