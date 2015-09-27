class CartsController < ApplicationController
  # No need for set_cart, the cart is set at the controller level

  # GET /cart
  # GET /cart.json
  def cart
    respond_to do |format|
      format.html
      format.json { render json: @cart.line_items }
    end
  end

  # PATCH/PUT /carts/1
  # PATCH/PUT /carts/1.json
  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to show_cart_path, notice: 'Cart was successfully updated.' }
        format.json { render :show, status: :ok, location: @cart }
      else
        format.html { redirect_to show_cart_path, alert: @cart.errors.full_messages.to_sentence }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    # Never trust parameters from the scary internet, only allow the white list through.
    def cart_params
      params.require(:cart).permit!.except(:session_id).merge!({:session_id => session_id})
    end
end