class Dashboard::CatalogsController < ApplicationController
  before_action :set_catalog, only: [:show, :edit, :update, :destroy]
  before_action :set_form_path, only: [:new, :edit]
  before_action :set_libraries, only: [:new, :edit]
  
  # GET /catalogs
  # GET /catalogs.json
  def index
    @catalogs = Catalog.all
  end

  # GET /catalogs/1
  # GET /catalogs/1.json
  def show
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

    respond_to do |format|
      if @catalog.save
        format.html { redirect_to dashboard_catalog_path(@catalog), notice: 'Catalog was successfully created.' }
      else
        format.html { render :new }
      end
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
    
    def set_libraries
      require 'catalog_lib/LibraryHandler'
      handler = LibraryHandler.new
      @libraries = handler.libraries.collect { |l| [l,l] } # usage for select field
    end
end