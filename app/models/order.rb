
class Order < ActiveRecord::Base
  
  validates_each :first_name_billing, :last_name_billing, :address_line_one_billing, :city_billing, :country_billing, :state_billing, :zip_billing, :on => :update do |record, attr, value|
    record.errors.add(attr, "is required.") if value == ""
  end
  
  validates :email, :format => { :with => /@/, :message => "is not a valid email address." }
  
  validates_each :first_name_shipping, :last_name_shipping, :address_line_one_shipping, :city_shipping, :country_shipping, :state_shipping, :zip_shipping, :on => :update do |record, attr, value|
    record.errors.add(attr, "is required.") if record[:order_status] >= Order.order_statuses[:bill_info_completed] && value == ""
  end
  
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
  
  has_one :payment
  
  def persist_shipping
    self.persisted_shipping_service_name = self.shipping_method.shipping_service.name
    self.persisted_shipping_method_name = self.shipping_method.name
    self.persisted_shipping_method_price = self.shipping_method.price
    self.save
  end
  
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
    self.payment.stripe_refund
    self.update(:order_status => :cancelled)
  end
  
  def destroy_stock_adjustments
    for adjustment in self.stock_adjustments
      adjustment.destroy
    end
  end
  
  # only total with line_items
  def sub_total
    self.cart.sub_total
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