class YgoPriceApiController < ApplicationController
  require 'YgoPriceAPI'
  
  def index
  end

  def sets
    api = YgoPriceAPI.new
    sets_data = api.get_all_sets
    respond_to do |format|
      format.any{ render json: sets_data, content_type: 'application/json' }
    end
  end

  def set
    api = YgoPriceAPI.new
    set_data = api.get_set_data(params[:set_name])
    respond_to do |format|
      format.any{ render json: set_data, content_type: 'application/json' } if set_data
    end
  end

  def card
    api = YgoPriceAPI.new
    card_data = api.get_single_card(params[:card_name])
    respond_to do |format|
      format.any{ render json: card_data, content_type: 'application/json' } if card_data
    end
  end
  
  def update
    respond_to do |format|
      format.json{ }
    end
  end
end
