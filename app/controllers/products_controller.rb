class ProductsController < ApplicationController
  before_action :set_product, only: [:show]

  # GET /products
  # GET /products.json
  def index
    @products = Product.all.reject{ |p| p.active == false }
  end
  # no route, but still here in case needed in the future

  # GET /products/1
  # GET /products/1.json
  def show
    require "json"
    @card_data = JSON.parse( @product.catalog_card.card_data_json ) rescue false
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id].to_i)
    end
end
