class ShippingMethod < ActiveRecord::Base
  belongs_to :shipping_service
  
  validates :name, :presence => true
  validates :price, :presence => true, :numericality => true
end
