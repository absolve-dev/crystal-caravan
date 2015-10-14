class Payment < ActiveRecord::Base
  
  enum status: [
    :failed,
    :authorized,
    :captured,
    :refunded
  ]
  
  belongs_to :order
  
end
