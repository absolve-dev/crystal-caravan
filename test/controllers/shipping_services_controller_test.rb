require 'test_helper'

class ShippingServicesControllerTest < ActionController::TestCase
  setup do
    @shipping_service = shipping_services(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shipping_services)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shipping_service" do
    assert_difference('ShippingService.count') do
      post :create, shipping_service: { active: @shipping_service.active, created_at: @shipping_service.created_at, name: @shipping_service.name, updated_at: @shipping_service.updated_at }
    end

    assert_redirected_to shipping_service_path(assigns(:shipping_service))
  end

  test "should show shipping_service" do
    get :show, id: @shipping_service
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @shipping_service
    assert_response :success
  end

  test "should update shipping_service" do
    patch :update, id: @shipping_service, shipping_service: { active: @shipping_service.active, created_at: @shipping_service.created_at, name: @shipping_service.name, updated_at: @shipping_service.updated_at }
    assert_redirected_to shipping_service_path(assigns(:shipping_service))
  end

  test "should destroy shipping_service" do
    assert_difference('ShippingService.count', -1) do
      delete :destroy, id: @shipping_service
    end

    assert_redirected_to shipping_services_path
  end
end
