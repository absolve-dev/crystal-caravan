class ListingQuantityValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    # cannot attempt to set line item quantity higher than the quantity of current product
    if value && record.listing.quantity < value
      if record.listing.quantity > 0
        record.errors[attribute] << "desired is more than available. Only #{record.listing.quantity} is/are in stock for '#{record.listing.product.name} - #{record.listing.name}'."
      else
        record.errors[attribute] << "desired is more than available. '#{record.listing.product.name} - #{record.listing.name}' is currently out of stock."
      end
    end
  end
end

class LineItem < ActiveRecord::Base
  belongs_to :cart
  
  validates :cart_id, :listing_id, :presence => true
  
  belongs_to :listing
  
  validates :quantity, :presence => true, :numericality => {:greater_than => 0}, :listing_quantity => true
  
  def persist
    self.persisted_name = self.listing.product.name
    self.persisted_listing_name = self.listing.name
    self.persisted_price = self.listing.price
    self.save
  end
  
  def is_in_stock?
    self.quantity && self.listing.quantity >= self.quantity ? true : false
  end
  
  def create_adjustment(order_id)
    StockAdjustment.create(:listing_id => self.listing.id, :quantity => self.quantity, :order_id => order_id)
  end
end