require "test_helper"

class CvControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get cv_index_url
    assert_response :success
  end
end
