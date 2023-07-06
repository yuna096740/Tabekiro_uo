require "test_helper"

class Public::TagsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_tags_show_url
    assert_response :success
  end
end
