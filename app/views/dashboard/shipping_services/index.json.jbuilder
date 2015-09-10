json.array!(@shipping_services) do |shipping_service|
  json.extract! shipping_service, :id, :name, :active, :created_at, :updated_at
  json.url shipping_service_url(shipping_service, format: :json)
end
