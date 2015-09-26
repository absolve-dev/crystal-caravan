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
    if @category.category_id
      @parent_category = Category.find(@category.category_id)
    end
    @sub_categories = @category.categories
    @products = @category.products
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to dashboard_category_path(@category), notice: 'Category was successfully created.' }
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
        format.html { redirect_to dashboard_category_path(@category), notice: 'Category was successfully updated.' }
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
