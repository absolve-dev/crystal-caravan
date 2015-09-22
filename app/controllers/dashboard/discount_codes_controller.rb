class Dashboard::DiscountCodesController < ApplicationController
  before_action :set_discount_code, only: [:show, :edit, :update, :destroy]
  before_action :set_form_path, only: [:new, :edit]

  # GET /discount_codes
  # GET /discount_codes.json
  def index
    @discount_codes = DiscountCode.all
  end

  # GET /discount_codes/1
  # GET /discount_codes/1.json
  def show
  end

  # GET /discount_codes/new
  def new
    @discount_code = DiscountCode.new
  end

  # GET /discount_codes/1/edit
  def edit
  end

  # POST /discount_codes
  # POST /discount_codes.json
  def create
    @discount_code = DiscountCode.new(discount_code_params)
    if @discount_code.save
      redirect_to dashboard_discount_code_path(@discount_code), notice: 'Discount code was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /discount_codes/1
  # PATCH/PUT /discount_codes/1.json
  def update
    if @discount_code.update(discount_code_params)
      redirect_to dashboard_discount_code_path(@discount_code), notice: 'Discount code was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /discount_codes/1
  # DELETE /discount_codes/1.json
  def destroy
    @discount_code.destroy
    redirect_to dashboard_discount_codes_url, notice: 'Discount code was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_discount_code
      @discount_code = DiscountCode.find(params[:id])
    end
    
    def set_form_path
      @form_path = params[:action] == 'new' ? dashboard_discount_codes_path : dashboard_discount_code_path      
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def discount_code_params
      params.require(:discount_code).permit(:name, :code, :percentage, :deduction, :usage_limit)
    end
end
