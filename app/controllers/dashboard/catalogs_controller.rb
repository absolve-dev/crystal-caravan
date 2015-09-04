class Dashboard::CatalogsController < ApplicationController
  before_action :set_catalog, only: [:show, :edit, :update, :destroy, :sync, :wipe]
  before_action :set_handler, only: [:new, :show, :edit, :sync]
  before_action :set_libraries, only: [:new, :edit]
  before_action :set_form_path, only: [:new, :edit]
  
  # GET /catalogs
  # GET /catalogs.json
  def index
    @catalogs = Catalog.all
  end

  # GET /catalogs/1
  # GET /catalogs/1.json
  def show
    @api_sets = @handler.get_sets
    @db_sets = @catalog.catalog_sets
  end

  # GET /catalogs/new
  def new
    @catalog = Catalog.new
  end

  # GET /catalogs/1/edit
  def edit
  end

  # POST /catalogs
  # POST /catalogs.json
  def create
    @catalog = Catalog.new(catalog_params)
    if @catalog.save
      redirect_to dashboard_catalog_path(@catalog), notice: 'Catalog was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /catalogs/1
  # PATCH/PUT /catalogs/1.json
  def update
    if @catalog.update(catalog_params)
      redirect_to dashboard_catalog_path(@catalog), notice: 'Catalog was successfully updated.'
    else
      render :edit
    end
  end
  
  def sync
    require 'json'
    def default_permalink(name)
      name.downcase.gsub(/[^a-z0-9]+/, '-').gsub(/^-*|-*$/, '')
    end
    for set in @handler.get_sets
      current_set = CatalogSet.where(:name => set, :catalog_id => @catalog.id).first
      current_set ||= CatalogSet.create(:catalog_id => @catalog.id, :name => set)
      
      # Link to a category
      current_category = Category.where(:name => set).first
      current_category ||= Category.create(:name => set, :permalink => default_permalink(set))
      current_set.category_id = current_category.id 
      current_set.save
      
      for card in @handler.get_set(set)
        # Create or modify a card in the database
        current_card = CatalogCard.where(:name => card[:name], :catalog_set_id => current_set.id).first
        current_card ||= CatalogCard.create(:catalog_set_id => current_set.id, :name => card[:name])
        card_data = card[:data].merge(@handler.get_card(card[:name]))
        card_data.delete('name')
        current_card.card_data_json = card_data.to_json
        card_image = @handler.get_card_image(card[:name])
        current_card.remote_product_image_url = card_image if card_image
        
        # Link to a product
        current_product = Product.where(:name => card[:name]).first
        current_product ||= Product.create(:name => card[:name], :category_id => current_set.category_id, :permalink => default_permalink(card[:name]), :weight => 0.1)
        current_card.product_id = current_product.id
        current_card.save
      end
    end
  end
  
  def wipe
    for set in @catalog.catalog_sets
      for card in set.catalog_cards
        card.destroy
      end
      set.destroy
    end
  end
  
  def set
    @set = CatalogSet.find(params[:set_id])
  end
  
  def card
    @card = CatalogCard.find(params[:card_id])
  end

  # DELETE /catalogs/1
  # DELETE /catalogs/1.json
  def destroy
    @catalog.destroy
    redirect_to dashboard_catalogs_url, notice: 'Catalog was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_catalog
      @catalog = Catalog.find(params[:id])
    end
    
    def set_form_path
      @form_path = params[:action] == 'new' ? dashboard_catalogs_path : dashboard_catalog_path      
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def catalog_params
      params[:catalog].permit(:library_name, :name)
    end
    
    def set_handler
      require 'catalog_lib/LibraryHandler'
      @handler = LibraryHandler.new
      @handler.set_library(@catalog.library_name) if params[:id]
    end
    
    def set_libraries
      @libraries = @handler.libraries.collect { |l| [l,l] } # usage for select field
    end
    
    def encode_sql(str)
      str.gsub('"', '""')
    end
    
end