class Listing < ActiveRecord::Base
  belongs_to :product
  
  validates :name, :presence => true
  validates :product_id, :presence => true
  validates :price, :presence => true, :numericality => true
  validates :quantity, :presence => true, :numericality => {greater_than_or_equal_to: 0}
  
end
