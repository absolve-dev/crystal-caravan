class LineItem < ActiveRecord::Base
  belongs_to :carts
  
  validates :cart_id, :listing_id, :presence => true
  
  belongs_to :listing
  
  def persist
    self.persisted_name = self.listing.product.name
    self.persisted_listing_name = self.listing.name
    self.persisted_price = self.listing.price
    self.save
  end
  
  def create_adjustment
    StockAdjustment.create(:listing_id => self.listing.id, :quantity => self.quantity)
  end
end