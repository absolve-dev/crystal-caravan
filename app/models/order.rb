class Order < ActiveRecord::Base
  # Only append to the end of this enum
  enum order_status: [
    :empty,
    :bill_info_completed,
    :ship_info_completed,
    :ship_options_completed,
    :payment_completed,
    :checkout_completed
  ]
end
