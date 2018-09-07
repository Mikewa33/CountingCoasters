require 'test_helper'

class CoastersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @coaster = coasters(:one)
  end

  test "should get index" do
    get coasters_url, as: :json
    assert_response :success
  end

  test "should create coaster" do
    assert_difference('Coaster.count') do
      post coasters_url, params: { coaster: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show coaster" do
    get coaster_url(@coaster), as: :json
    assert_response :success
  end

  test "should update coaster" do
    patch coaster_url(@coaster), params: { coaster: {  } }, as: :json
    assert_response 200
  end

  test "should destroy coaster" do
    assert_difference('Coaster.count', -1) do
      delete coaster_url(@coaster), as: :json
    end

    assert_response 204
  end
end
