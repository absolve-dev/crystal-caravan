class ShippingService < ActiveRecord::Base
  has_many :shipping_methods
  
  accepts_nested_attributes_for :shipping_methods, :reject_if => lambda { |a| a[:name].blank? || a[:price].blank? }
end
