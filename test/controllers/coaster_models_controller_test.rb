require 'test_helper'

class CoasterModelsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @coaster_model = coaster_models(:one)
  end

  test "should get index" do
    get coaster_models_url, as: :json
    assert_response :success
  end

  test "should create coaster_model" do
    assert_difference('CoasterModel.count') do
      post coaster_models_url, params: { coaster_model: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show coaster_model" do
    get coaster_model_url(@coaster_model), as: :json
    assert_response :success
  end

  test "should update coaster_model" do
    patch coaster_model_url(@coaster_model), params: { coaster_model: {  } }, as: :json
    assert_response 200
  end

  test "should destroy coaster_model" do
    assert_difference('CoasterModel.count', -1) do
      delete coaster_model_url(@coaster_model), as: :json
    end

    assert_response 204
  end
end
