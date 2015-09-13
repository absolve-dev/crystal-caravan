class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :set_order_for_checkout, only: [:new, :bill_info, :ship_info, :ship_options, :payment, :checkout]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  # Following checkout actions must check for proper pre-completion
  
  # POST /orders/bill_info
  def bill_info
    if @order.update(order_params)
      @order.update(order_status: :bill_info_completed) if @order[:order_status] < Order.order_statuses[:bill_info_completed]
      render json: @order, status: :ok
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end
  
  # POST /orders/ship_info
  def ship_info
    if @order.update(order_params)
      @order.update(order_status: :ship_info_completed) if @order[:order_status] < Order.order_statuses[:ship_info_completed]
      render json: @order, status: :ok
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end
  
  # POST /orders/ship_options
  def ship_options
    @order.update(order_status: :ship_options_completed) if @order[:order_status] < Order.order_statuses[:ship_options_completed]
    render json: @order, status: :ok
  end
  
  # POST /orders/payment
  def payment
    @order.update(order_status: :payment_completed) if @order[:order_status] < Order.order_statuses[:payment_completed]
    render json: @order, status: :ok
  end
  
  # POST /orders/checkout
  def checkout
    @order.update(order_status: :checkout_completed) if @order[:order_status] < Order.order_statuses[:checkout_completed]
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
