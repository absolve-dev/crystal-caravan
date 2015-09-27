class ListingQuantityValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    # cannot attempt to set line item quantity higher than the quantity of current product
    if value && record.listing.quantity < value
      record.errors[attribute] << "desired is more than available. Only #{record.listing.quantity} are available of '#{record.listing.product.name} - #{record.listing.name}'."
    end
  end
end

class LineItem < ActiveRecord::Base
  belongs_to :cart
  
  validates :cart_id, :listing_id, :presence => true
  
  belongs_to :listing
  
  validates :quantity, :presence => true, :listing_quantity => true
  
  def persist
    self.persisted_name = self.listing.product.name
    self.persisted_listing_name = self.listing.name
    self.persisted_price = self.listing.price
    self.save
  end
  
  def create_adjustment(order_id)
    StockAdjustment.create(:listing_id => self.listing.id, :quantity => self.quantity, :order_id => order_id)
  end
end