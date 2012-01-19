require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get ask" do
    get :ask
    assert_response :success
  end

  test "should get bio" do
    get :bio
    assert_response :success
  end

  test "should get give" do
    get :give
    assert_response :success
  end

  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get watch" do
    get :watch
    assert_response :success
  end

end
