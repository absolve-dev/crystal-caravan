class LineItemsController < ApplicationController
  before_action :set_line_item, only: [:show, :edit, :update, :destroy]
  before_action :set_line_items, only: [:destroy]

  # POST /line_items
  # POST /line_items.json
  def create
    @line_item = LineItem.where({ :listing_id => params[:line_item][:listing_id], :cart_id => @cart.id }).first
    
    if @line_item
      @line_item.quantity += params[:line_item][:quantity].to_i
    else
      @line_item ||= LineItem.new(line_item_params)
    end

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to show_cart_path, notice: "'#{@line_item.listing.product.name} - #{@line_item.listing.name}' was successfully added to your cart." }
        format.json { render json: @line_item }
      else
        format.html { redirect_to product_path(@line_item.listing.product), alert: @line_item.errors.full_messages.to_sentence }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    @line_item.destroy
    redirect_to(show_cart_path, notice: "'#{@line_item.listing.product.name} - #{@line_item.listing.name}' was successfully removed from your cart.")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_item_params
      params.require(:line_item).permit(:quantity, :listing_id).merge(:cart_id => @cart.id)
    end
end
