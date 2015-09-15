class Order < ActiveRecord::Base
  # Only append to the end of this enum
  enum order_status: [
    :empty,
    :bill_info_completed,
    :ship_info_completed,
    :ship_options_completed,
    :payment_completed,
    :checkout_completed,
    :fulfilled
  ]
  
  belongs_to :cart # only for foreign-key dependency. does not semantically make sense
  has_many :stock_adjustments
  
  def fulfill_order
    for item in self.cart.line_items
      item.listing.quantity -= item.quantity
      item.listing.save
    end
    self.destroy_stock_adjustments
  end
  
  def destroy_stock_adjustments
    for adjustment in self.stock_adjustments
      adjustment.destroy
    end
  end
end
