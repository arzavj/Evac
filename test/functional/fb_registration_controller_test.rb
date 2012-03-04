require 'test_helper'

class FbRegistrationControllerTest < ActionController::TestCase
  test "should get FbLogin" do
    get :FbLogin
    assert_response :success
  end

end
