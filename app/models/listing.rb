class Listing < ActiveRecord::Base
  belongs_to :product
  has_many :stock_adjustments
  
  validates :name, :presence => true
  validates :product_id, :presence => true
  validates :price, :presence => true, :numericality => true
  validates :quantity, :presence => true, :numericality => {greater_than_or_equal_to: 0}
  
  def adjusted_quantity
    total_adjustments = self.stock_adjustments.sum(:quantity)
    self.quantity - total_adjustments
  end
end
