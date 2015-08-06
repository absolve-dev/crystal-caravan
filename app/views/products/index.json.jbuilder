json.array!(@products) do |product|
  json.extract! product, :id, :name, :category_id, :permalink, :description, :short_description, :active, :weight, :created, :update_id
  json.url product_url(product, format: :json)
end
