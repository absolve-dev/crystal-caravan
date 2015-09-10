class ShippingService < ActiveRecord::Base
  has_many :shipping_methods
end
