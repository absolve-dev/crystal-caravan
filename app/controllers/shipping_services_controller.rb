class ShippingServicesController < ApplicationController
  before_action :set_shipping_service, only: [:show, :edit, :update, :destroy]

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

    respond_to do |format|
      if @shipping_service.save
        format.html { redirect_to @shipping_service, notice: 'Shipping service was successfully created.' }
        format.json { render :show, status: :created, location: @shipping_service }
      else
        format.html { render :new }
        format.json { render json: @shipping_service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shipping_services/1
  # PATCH/PUT /shipping_services/1.json
  def update
    respond_to do |format|
      if @shipping_service.update(shipping_service_params)
        format.html { redirect_to @shipping_service, notice: 'Shipping service was successfully updated.' }
        format.json { render :show, status: :ok, location: @shipping_service }
      else
        format.html { render :edit }
        format.json { render json: @shipping_service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shipping_services/1
  # DELETE /shipping_services/1.json
  def destroy
    @shipping_service.destroy
    respond_to do |format|
      format.html { redirect_to shipping_services_url, notice: 'Shipping service was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shipping_service
      @shipping_service = ShippingService.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shipping_service_params
      params.require(:shipping_service).permit(:name, :active, :created_at, :updated_at)
    end
end
