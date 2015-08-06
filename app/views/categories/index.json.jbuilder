json.array!(@categories) do |category|
  json.extract! category, :id, :name, :category_id, :description, :permalink, :created, :update_id
  json.url category_url(category, format: :json)
end
