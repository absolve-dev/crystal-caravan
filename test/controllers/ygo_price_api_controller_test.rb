require 'test_helper'

class YgoPriceApiControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get sets" do
    get :sets
    assert_response :success
  end

  test "should get set" do
    get :set
    assert_response :success
  end

  test "should get card" do
    get :card
    assert_response :success
  end

end
