class Order < ActiveRecord::Base
  belongs_to :cart
  
  has_one :payment
  
end
