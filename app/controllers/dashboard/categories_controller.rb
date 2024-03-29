class Dashboard::CategoriesController < ApplicationController
  
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :set_form_path, only: [:new, :edit, :create, :update]
  
  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.all
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    @products = @category.products
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
    @products = @category.products.reject{ |p| p.active == false }
  end
  
  helper_method :number_and_rarity
  
  def number_and_rarity(product)
    catalog_data = JSON.parse( product.catalog_card.card_data_json ) rescue false
    catalog_data ? { :card_number => catalog_data["Card Number"], :rarity => catalog_data["Rarity"] } : false
  end
  
  helper_method :lowest_listing
  
  def lowest_listing(product)
    product.listings.each do |listing|
      if listing.price > 0.0 && listing.quantity > 0
        return listing
      end
    end
    return false
  end
  
  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to edit_dashboard_category_path(@category), notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to edit_dashboard_category_path(@category), notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    redirect_to dashboard_categories_url, notice: 'Category was successfully destroyed.'
  end
    
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end
    
    def set_form_path
      if params[:action] == 'new' || params[:action] == 'create'
        @form_path = dashboard_categories_path
      else
        @form_path = dashboard_category_path  
      end    
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name, :category_id, :description, :permalink, :update_id, :default_picture)
    end
    
end
