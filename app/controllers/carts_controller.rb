class CartsController < ApplicationController
  before_action :set_line_items, only: [:edit]
  before_action :existing_cart, only: [:create]

  # GET /carts
  # GET /carts.json
  def index
    @carts = Cart.all
  end

  # GET /carts/1
  # GET /carts/1.json
  def show
    respond_to do |format|
      format.html
      format.js
      format.json { render json: @line_items }
    end
  end

  # GET /carts/new
  def new
    @cart = Cart.new
  end

  # GET /carts/1/edit
  def edit
  end 
  
  # BCK Defined Methods
  def line_items_attributes=(attributes)
    #{ }
  end
  
  
  def existing_cart
    # will fix this when users are implemented. one idea includes using this to modify the existing cart with the same method that creates on action
    Cart.find(params[:session_id])
  end
  
  # End BCK Defined Methods

  # POST /carts
  # POST /carts.json
  def create
    @cart = Cart.new(cart_params)
    respond_to do |format|
      if @cart.save
        format.html { redirect_to @cart, notice: 'Cart was successfully created.' }
        format.json { render :show, status: :created, location: @cart }
      else
        format.html { render :new }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carts/1
  # PATCH/PUT /carts/1.json
  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to @cart, notice: 'Cart was successfully updated.' }
        format.js { render :show, status: :ok, location: @cart }
      else
        format.html { render :edit }
        format.js { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    @cart.destroy
    respond_to do |format|
      format.html { redirect_to carts_url, notice: 'Cart was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    # Never trust parameters from the scary internet, only allow the white list through.
    def cart_params
      params.require(:cart).permit!.except(:session_id).merge!({:session_id => session_id})
    end
end