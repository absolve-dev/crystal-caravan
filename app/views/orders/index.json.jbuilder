json.array!(@orders) do |order|
  json.extract! order, :id, :first_name_billing, :last_name_billing, :company_billing, :address_line_one_billing, :address_line_two_billing, :city_billing, :country_billing, :state_billing, :zip_billing, :phone_billing, :first_name_shipping, :last_name_shipping, :company_shipping, :address_line_one_shipping, :address_line_two_shipping, :city_shipping, :country_shipping, :state_shipping, :zip_shipping, :phone_shipping
  json.url order_url(order, format: :json)
end
