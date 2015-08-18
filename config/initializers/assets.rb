# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

# Precompile class css/js files
Rails.application.config.assets.precompile += %w( static_pages.css )
Rails.application.config.assets.precompile += %w( static_pages.js )

Rails.application.config.assets.precompile += %w( categories.css )
Rails.application.config.assets.precompile += %w( categories.js )

Rails.application.config.assets.precompile += %w( products.css )
Rails.application.config.assets.precompile += %w( products.js )


Rails.application.config.assets.precompile += %w( carts.css )
Rails.application.config.assets.precompile += %w( carts.js )
