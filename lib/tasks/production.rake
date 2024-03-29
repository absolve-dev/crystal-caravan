namespace :production do

  task :admin_seed => :environment do
  
    admin_angelo = Admin.create(:email => 'alirazan@absolvegaming.com', :password => 'adminaccount', :password_confirmation => 'adminaccount')
    admin_brian = Admin.create(:email => 'bhuynh@absolvegaming.com', :password => 'adminaccount', :password_confirmation => 'adminaccount')

  end
  
  task :update_ygo => :environment do
  
    require 'json'
    
    def default_permalink(name)
      name.downcase.gsub(/[^a-z0-9]+/, '-').gsub(/^-*|-*$/, '')
    end
    
    ygo_catalog = Catalog.where(:library_name => "Yu-Gi-Oh!").first
    ygo_catalog ||= Catalog.create(:name => "Yu-Gi-Oh!", :library_name => "Yu-Gi-Oh!")
  
    require 'catalog_lib/LibraryHandler'
    handler = LibraryHandler.new
    handler.set_library(ygo_catalog.library_name)
    
    ygo_logo = File.open(File.join(Rails.application.root, 'db', 'production_default', 'ygo_logo.png'), 'rb')
    current_game = ygo_catalog.game
    current_game ||= Game.create(:name => ygo_catalog.name, :permalink => default_permalink(ygo_catalog.name), :default_image => ygo_logo)
    ygo_catalog.game_id = current_game.id
    ygo_catalog.save
  
    for set in handler.get_sets
      current_set = CatalogSet.where(:name => set, :catalog_id => ygo_catalog.id).first
      current_set ||= CatalogSet.create(:catalog_id => ygo_catalog.id, :name => set)
    
      # Link to a category
      current_category = current_set.category
      current_category ||= Category.create(:name => set, :permalink => default_permalink(set), :game_id => current_game.id)
      current_set.category_id = current_category.id 
      current_set.save
    
      for card in handler.get_set(set)
        
        card_data = card[:data].merge(handler.get_card(card[:name]))
        card_data.delete('name')
        
        # Re-code card data
        recoded_card_data = Hash.new
        recoded_card_data["Card Number"] = card_data[:print_tag] if card_data[:print_tag]
        recoded_card_data["Rarity"] = card_data[:rarity] if card_data[:rarity]
        recoded_card_data["Card Type"] = card_data["card_type"].capitalize if card_data["card_type"]
        recoded_card_data["Card Sub-Type"] = card_data["property"].capitalize if card_data["property"]
        recoded_card_data["Attribute"] = card_data["family"].capitalize if card_data["family"]
        recoded_card_data["Type"] = card_data["type"].capitalize if card_data["type"]
        recoded_card_data["Level"] = card_data["level"] if card_data["level"]
        recoded_card_data["ATK/DEF"] = "#{card_data['atk']} / #{card_data['def']}" if card_data["atk"] && card_data["def"]
        recoded_card_data["Card Text"] = card_data["text"] if card_data["text"]
        
        # Create or modify a card in the database
        current_card = CatalogCard.where(:name => card[:name], :catalog_set_id => current_set.id).first
        current_card = nil if current_card && current_card.card_data_json && JSON.parse(current_card.card_data_json)["Rarity"] != recoded_card_data["Rarity"]
        current_card ||= CatalogCard.create(:catalog_set_id => current_set.id, :name => card[:name])
        
        current_card.card_data_json = recoded_card_data.to_json
        unless current_card.remote_product_image_url
          card_image = handler.get_card_image(card[:name])
          current_card.remote_product_image_url = card_image if card_image
        end
      
        # Link to a product
        current_product = current_card.product
        current_product ||= Product.create(:name => card[:name], :category_id => current_set.category_id, :permalink => default_permalink(card[:name]), :weight => 0.1)
        current_card.product_id = current_product.id
        current_card.save
      end
      
    end
    
    puts "YGO database sync complete!"
    
  end
  
end