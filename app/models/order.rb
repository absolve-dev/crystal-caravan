class Order < ActiveRecord::Base
  # Only append to the end of this enum
  enum order_status: [
    :empty,
    :bill_info_completed,
    :ship_info_completed,
    :ship_options_completed,
    :payment_completed,
    :checkout_completed,
    :fulfilled,
    :cancelled
  ]
  
  belongs_to :cart # only for foreign-key dependency. does not semantically make sense
  has_many :stock_adjustments
  
  belongs_to :shipping_method
   
  def discount_code_valid?
    self.discount_code && get_discount ? true : false
  end
    
  def get_discount
    DiscountCode.where(:code => self.discount_code).first
  end
  
  def fulfill_order
    for item in self.cart.line_items
      item.listing.quantity -= item.quantity
      item.listing.save
    end
    self.destroy_stock_adjustments
  end
  
  def cancel
    self.destroy_stock_adjustments
    self.update(:order_status => :cancelled)
  end
  
  def destroy_stock_adjustments
    for adjustment in self.stock_adjustments
      adjustment.destroy
    end
  end
  
  # only total with line_items
  def sub_total
    sub_total = 0.0
    for item in self.cart.line_items
      sub_total += item.listing.price * item.quantity
    end
    sub_total
  end
  
  def sub_total_after_discount
    apply_discount(self.sub_total) if discount_code_valid?
  end
  
  def total
    total = self.sub_total
    total = apply_discount(total) if self.discount_code_valid?
    total + self.shipping_method.price
  end
  
  private
    def apply_discount(sub_total)
      discounted = sub_total
      discount = get_discount
      
      # apply percentage
      discounted *= discount.multiplier if discount.multiplier
      
      # apply deduction
      discounted -= discount.deduction if discount.deduction && discount.deduction > 0.0
      
      # account for below zero
      discounted = 0.0 if discounted < 0.0
      
      discounted
    end
end
