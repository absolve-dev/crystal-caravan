class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :cancel, :edit, :update, :destroy]
  before_action :set_order_for_checkout, only: [:new, :bill_info_form, :bill_info_update, :ship_info_form, :ship_info_update, :ship_options_form, :ship_options_update, :payment_form, :payment_update, :checkout_form, :checkout_update]

  # GET /orders/1
  # GET /orders/1.json
  def show
    authenticate_user!
    user_signed_in? && @order.email == current_user.email ? @allowed = true : @allowed = false
  end
  
  # GET /orders/1/cancel
  def cancel
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
  end
  
  # GET /orders/ship_options
  def ship_options_form
    @shipping_methods_select = ShippingMethod.all.collect do |method| 
      method.shipping_service.active && method.active ? ["#{method.shipping_service.name} #{method.name} - #{method.price}", method.id] : nil
    end.compact
  end
  
  # GET /orders/payment
  def payment_form
  end
  
  # GET /orders/checkout
  def checkout_form
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
    @order.update(order_status: :payment_completed) if @order[:order_status] < Order.order_statuses[:payment_completed]
    @order.update(discount_code: params[:order][:discount_code])
    redirect_to :order_checkout_form
  end
  
  # POST /orders/checkout
  def checkout_update
    @order.update(order_status: :checkout_completed) if @order[:order_status] < Order.order_statuses[:checkout_completed]
    @cart.persist_line_items
    @cart.adjust_line_items(@order.id)
    @cart.update(:active => false)
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
      params.require(:order).permit!.except(:order_status)
    end
end
