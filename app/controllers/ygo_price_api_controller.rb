class YgoPriceApiController < ApplicationController
  require 'YgoPriceAPI'
  
  def index
  end

  def sets
    respond_to do |format|
      format.json{ }
    end
  end

  def set
    respond_to do |format|
      format.json{ }
    end
  end

  def card
    respond_to do |format|
      format.json{ }
    end
  end
  
  def update
    respond_to do |format|
      format.json{ }
    end
  end
end
