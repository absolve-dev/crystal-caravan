class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :cancel, :edit, :update, :destroy]
  before_action :set_order_for_checkout, only: [:new, :bill_info_form, :bill_info_update, :ship_info_form, :ship_info_update, :ship_options_form, :ship_options_update, :payment_form, :payment_update, :checkout_form, :checkout_update]

  # GET /orders/1
  # GET /orders/1.json
  def show
    authenticate_user!
    user_signed_in? && @order.email == current_user.email ? @allowed = true : @allowed = false
    @cart = @order.cart
  end
  
  # GET /orders/1/cancel
  def cancel
    OrderMailer.cancelled(@order).deliver_now
    @order.cancel
    redirect_to order_path(@order), notice: 'Status was successfully changed'
  end

  # GET /orders/new
  def new
    if @cart.line_items.length < 1
      redirect_to show_cart_path, alert: "Cart cannot be empty for checkout."
    else
      redirect_to :order_bill_info_form
    end
  end
  
  # GET /orders/bill_info
  def bill_info_form
  end
  
  # GET /orders/ship_info
  def ship_info_form
    return redirect_backwards_in_checkout if @order[:order_status] < Order.order_statuses[:bill_info_completed]
  end
  
  # GET /orders/ship_options
  def ship_options_form
    return redirect_backwards_in_checkout if @order[:order_status] < Order.order_statuses[:ship_info_completed]
    @shipping_methods = ShippingMethod.all.collect do |method| 
      method.shipping_service.active && method.active ? { :name => "#{method.shipping_service.name} - #{method.name} - #{method.price}", :id => method.id } : nil
    end.compact
  end
  
  # GET /orders/payment
  def payment_form
    redirect_backwards_in_checkout if @order[:order_status] < Order.order_statuses[:ship_options_completed]
  end
  
  # GET /orders/checkout
  def checkout_form
    redirect_backwards_in_checkout if @order[:order_status] < Order.order_statuses[:payment_completed]
  end
  
  # POST /orders/bill_info
  def bill_info_update
    if @order.update(order_params)
      @order.update(order_status: :bill_info_completed) if @order[:order_status] < Order.order_statuses[:bill_info_completed]
      redirect_to :order_ship_info_form
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end
  
  # POST /orders/ship_info
  def ship_info_update
    if @order.update(order_params)
      @order.update(order_status: :ship_info_completed) if @order[:order_status] < Order.order_statuses[:ship_info_completed]
      redirect_to :order_ship_options_form
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end
  
  # POST /orders/ship_options
  def ship_options_update
    if @order.update(order_params)
      @order.update(order_status: :ship_options_completed) if @order[:order_status] < Order.order_statuses[:ship_options_completed]
      redirect_to :order_payment_form
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end
  
  # POST /orders/payment
  def payment_update
    @order.update(discount_code: params[:order][:discount_code])
    
    payment = @order.payment.destroy if @order.payment
    payment = Payment.create(:order_id => @order.id, :amount => @order.total)
    
    stripe_params = payment.stripe_params(order_params)
    
    if stripe_params.is_a?(String)
      return redirect_to :order_payment_form, :alert => stripe_params
    end
    
    payment_success = payment.stripe_create(stripe_params)
    
    if payment_success
      @order.update(order_status: :payment_completed) if @order[:order_status] < Order.order_statuses[:payment_completed]
      redirect_to :order_checkout_form, :notice => "Credit card information was successfully verified."
    else
      redirect_to :order_payment_form, :alert => payment[:response_message]
    end
  end
  
  # POST /orders/checkout
  def checkout_update
    # check if line items are valid
    check = @cart.check_stock
    if check.is_a?(Array) && check.length > 0
      redirect_to :order_checkout_form, alert: check.join(" ")
    else
      @order.persist_shipping
      @cart.persist_line_items
      @cart.adjust_line_items(@order.id)
      OrderMailer.placed(@order).deliver_now
      @order.update(order_status: :checkout_completed) if @order[:order_status] < Order.order_statuses[:checkout_completed]
      @cart.update(:active => false)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end
    
    def set_order_for_checkout
      @order = Order.where(:cart_id => @cart.id).first
      @order ||= Order.new(:cart_id => @cart.id)
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.permit(
        # billing info
        :first_name_billing, :last_name_billing, :company_billing, :address_line_one_billing, :address_line_two_billing, :city_billing, :country_billing, :state_billing, :zip_billing, :phone_billing,
        # shipping info
        :first_name_shipping, :last_name_shipping, :company_shipping, :address_line_one_shipping, :address_line_two_shipping, :city_shipping, :country_shipping, :state_shipping, :zip_shipping, :phone_shipping, :email,
        # shipping options
        :shipping_method_id,
        # payment options
        :card_number, :card_exp_month, :card_exp_year, :card_cvc, :discount_code
      )
    end
    
    def redirect_backwards_in_checkout
      case @order[:order_status]
      when Order.order_statuses[:empty]
        redirect_to :order_bill_info_form, alert: "Please complete billing information."
      when Order.order_statuses[:bill_info_completed]
        redirect_to :order_ship_info_form, alert: "Please complete shipping information."
      when Order.order_statuses[:ship_info_completed]
        redirect_to :order_ship_options_form, alert: "Please choose shipping options."
      when Order.order_statuses[:ship_options_completed]
        redirect_to :order_payment_form, alert: "Please enter payment information."
      end
    end
end
