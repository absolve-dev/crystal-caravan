class Dashboard::ShippingServicesController < ApplicationController
  before_action :set_shipping_service, only: [:show, :edit, :update, :destroy]
  before_action :set_form_path, only: [:new, :edit]

  # GET /shipping_services
  # GET /shipping_services.json
  def index
    @shipping_services = ShippingService.all
  end

  # GET /shipping_services/1
  # GET /shipping_services/1.json
  def show
  end

  # GET /shipping_services/new
  def new
    @shipping_service = ShippingService.new
  end

  # GET /shipping_services/1/edit
  def edit
  end

  # POST /shipping_services
  # POST /shipping_services.json
  def create
    @shipping_service = ShippingService.new(shipping_service_params)

    if @shipping_service.save
      redirect_to dashboard_shipping_service_path(@shipping_service), notice: 'Shipping service was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /shipping_services/1
  # PATCH/PUT /shipping_services/1.json
  def update
    if @shipping_service.update(shipping_service_params)
      redirect_to dashboard_shipping_service_path(@shipping_service), notice: 'Shipping service was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /shipping_services/1
  # DELETE /shipping_services/1.json
  def destroy
    @shipping_service.destroy
    redirect_to dashboard_shipping_services_path, notice: 'Shipping service was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shipping_service
      @shipping_service = ShippingService.find(params[:id])
    end
    
    def set_form_path
      @form_path = params[:action] == 'new' ? dashboard_shipping_services_path : dashboard_shipping_service_path      
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def shipping_service_params
      params.require(:shipping_service).permit(:name, :active, :created_at, :updated_at)
    end
end
