class CategoriesController < ApplicationController
  before_action :set_category, only: [:show]

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.all
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    if @category.game_id
      @game = Game.find(@category.game_id)
    end
    @products = @category.products.reject{ |p| p.active == false }
  
  end
  
  helper_method :product_listing_text
  
  def product_listing_text(product)
    product.listings.each do |listing|
      if listing.price > 0.0 && listing.quantity > 0
        return "#{listing.name} - #{listing.price}"
      end
    end
    return "Out of Stock"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id].to_i) rescue Category.where(:permalink => params[:id]).first
    end
end
