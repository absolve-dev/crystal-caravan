json.array!(@games) do |game|
  json.extract! game, :id, :name, :created_at, :updated_at, :description, :permalink, :default_picture
  json.url game_url(game, format: :json)
end
