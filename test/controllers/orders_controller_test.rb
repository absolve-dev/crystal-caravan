require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  setup do
    @order = orders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create order" do
    assert_difference('Order.count') do
      post :create, order: { address_line_one_billing: @order.address_line_one_billing, address_line_one_shipping: @order.address_line_one_shipping, address_line_two_billing: @order.address_line_two_billing, address_line_two_shipping: @order.address_line_two_shipping, city_billing: @order.city_billing, city_shipping: @order.city_shipping, company_billing: @order.company_billing, company_shipping: @order.company_shipping, country_billing: @order.country_billing, country_shipping: @order.country_shipping, first_name_billing: @order.first_name_billing, first_name_shipping: @order.first_name_shipping, last_name_billing: @order.last_name_billing, last_name_shipping: @order.last_name_shipping, phone_billing: @order.phone_billing, phone_shipping: @order.phone_shipping, state_billing: @order.state_billing, state_shipping: @order.state_shipping, zip_billing: @order.zip_billing, zip_shipping: @order.zip_shipping }
    end

    assert_redirected_to order_path(assigns(:order))
  end

  test "should show order" do
    get :show, id: @order
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @order
    assert_response :success
  end

  test "should update order" do
    patch :update, id: @order, order: { address_line_one_billing: @order.address_line_one_billing, address_line_one_shipping: @order.address_line_one_shipping, address_line_two_billing: @order.address_line_two_billing, address_line_two_shipping: @order.address_line_two_shipping, city_billing: @order.city_billing, city_shipping: @order.city_shipping, company_billing: @order.company_billing, company_shipping: @order.company_shipping, country_billing: @order.country_billing, country_shipping: @order.country_shipping, first_name_billing: @order.first_name_billing, first_name_shipping: @order.first_name_shipping, last_name_billing: @order.last_name_billing, last_name_shipping: @order.last_name_shipping, phone_billing: @order.phone_billing, phone_shipping: @order.phone_shipping, state_billing: @order.state_billing, state_shipping: @order.state_shipping, zip_billing: @order.zip_billing, zip_shipping: @order.zip_shipping }
    assert_redirected_to order_path(assigns(:order))
  end

  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete :destroy, id: @order
    end

    assert_redirected_to orders_path
  end
end
