require 'test_helper'

class ModelLinesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @model_line = model_lines(:one)
  end

  test "should get index" do
    get model_lines_url, as: :json
    assert_response :success
  end

  test "should create model_line" do
    assert_difference('ModelLine.count') do
      post model_lines_url, params: { model_line: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show model_line" do
    get model_line_url(@model_line), as: :json
    assert_response :success
  end

  test "should update model_line" do
    patch model_line_url(@model_line), params: { model_line: {  } }, as: :json
    assert_response 200
  end

  test "should destroy model_line" do
    assert_difference('ModelLine.count', -1) do
      delete model_line_url(@model_line), as: :json
    end

    assert_response 204
  end
end
