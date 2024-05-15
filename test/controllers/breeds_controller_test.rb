require "test_helper"

class BreedsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get breeds_index_url
    assert_response :success
  end
end
