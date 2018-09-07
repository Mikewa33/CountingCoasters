require 'test_helper'

class CoasterModelTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @coaster_model_type = coaster_model_types(:one)
  end

  test "should get index" do
    get coaster_model_types_url, as: :json
    assert_response :success
  end

  test "should create coaster_model_type" do
    assert_difference('CoasterModelType.count') do
      post coaster_model_types_url, params: { coaster_model_type: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show coaster_model_type" do
    get coaster_model_type_url(@coaster_model_type), as: :json
    assert_response :success
  end

  test "should update coaster_model_type" do
    patch coaster_model_type_url(@coaster_model_type), params: { coaster_model_type: {  } }, as: :json
    assert_response 200
  end

  test "should destroy coaster_model_type" do
    assert_difference('CoasterModelType.count', -1) do
      delete coaster_model_type_url(@coaster_model_type), as: :json
    end

    assert_response 204
  end
end
