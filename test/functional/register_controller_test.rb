require 'test_helper'

class RegisterControllerTest < ActionController::TestCase
  test "should get Registration" do
    get :Registration
    assert_response :success
  end

end
