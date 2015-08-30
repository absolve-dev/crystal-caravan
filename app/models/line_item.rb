class LineItem < ActiveRecord::Base
  belongs_to :carts
  
  validates :cart_id, :listing_id, :presence => true
end