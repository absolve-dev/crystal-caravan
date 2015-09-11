class ShippingService < ActiveRecord::Base
  has_many :shipping_methods
  
  accepts_nested_attributes_for :shipping_methods
end
