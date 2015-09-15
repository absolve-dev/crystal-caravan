class Dashboard::ShippingServicesController < ApplicationController
  before_action :set_shipping_service, only: [:show, :edit, :update, :destroy]
  before_action :set_form_path, only: [:new, :edit, :update]

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
    build_empty_shipping_method
  end

  # GET /shipping_services/1/edit
  def edit
    build_empty_shipping_method
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
    @shipping_service.shipping_methods[-1].destroy if @shipping_service.shipping_methods.last.name == '' || @shipping_service.shipping_methods.last.price == nil
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
  
  # DELETE /shipping_services/shipping_method_destroy/:method_id
  # redirect to EDIT
  def destroy_shipping_method
    shipping_method = ShippingMethod.find(params[:method_id])
    service_id = shipping_method.shipping_service_id
    shipping_method.destroy
    redirect_to edit_dashboard_shipping_service_path(service_id)
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shipping_service
      @shipping_service = ShippingService.find(params[:id])
    end
    
    def build_empty_shipping_method
      @shipping_service.shipping_methods.new
    end
    
    def set_form_path
      @form_path = params[:action] == 'new' ? dashboard_shipping_services_path : dashboard_shipping_service_path      
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def shipping_service_params
      params.require(:shipping_service).permit!
    end
end
