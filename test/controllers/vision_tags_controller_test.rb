require "test_helper"

class VisionTagsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get vision_tags_index_url
    assert_response :success
  end
end
