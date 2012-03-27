require 'test_helper'

class TokControllerTest < ActionController::TestCase
  test "should get ChatRoom" do
    get :ChatRoom
    assert_response :success
  end

end
