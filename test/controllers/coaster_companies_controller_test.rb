require 'test_helper'

class CoasterCompaniesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @coaster_company = coaster_companies(:one)
  end

  test "should get index" do
    get coaster_companies_url, as: :json
    assert_response :success
  end

  test "should create coaster_company" do
    assert_difference('CoasterCompany.count') do
      post coaster_companies_url, params: { coaster_company: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show coaster_company" do
    get coaster_company_url(@coaster_company), as: :json
    assert_response :success
  end

  test "should update coaster_company" do
    patch coaster_company_url(@coaster_company), params: { coaster_company: {  } }, as: :json
    assert_response 200
  end

  test "should destroy coaster_company" do
    assert_difference('CoasterCompany.count', -1) do
      delete coaster_company_url(@coaster_company), as: :json
    end

    assert_response 204
  end
end
