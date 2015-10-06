# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Admin
admin = Admin.create(:email => 'rootmin@nimtoors.com', :password => 'toorgang', :password_confirmation => 'toorgang')

# User
user = User.create(:email => 'rootmin@nimtoors.com', :password => 'toorgang' , :password_confirmation => 'toorgang')
user2 = User.create(:email => 'rootmin2@nimtoors.com', :password => 'toorgang' , :password_confirmation => 'toorgang')

# Game
game_image = File.open(File.join(Rails.application.root, 'db', 'seeds_images', 'biggest-boy.jpg'), 'rb')
game = Game.create(:name => 'Test Game 1', :permalink => 'test-game-1', :default_image => game_image)


# Categories
category_image = File.open(File.join(Rails.application.root, 'db', 'seeds_images', 'big-boy.jpg'), 'rb')
categories = Array.new
(1..5).each do |x|
  category = Category.create(:name => "Test Category #{x}", :permalink => "test-category-#{x}", :game_id => game.id, :default_image => category_image)
  categories.push(category)
end

# Products
product_image = File.open(File.join(Rails.application.root, 'db', 'seeds_images', 'little-boy.jpg'), 'rb')
products = Array.new
categories.each do |category|
  (1..7).each do |x|
    product = Product.create(:name => "Test Product #{category.id}-#{x}", :permalink =>"test-product-#{category.id}-#{x}", :category_id => category.id, :weight => 0.1, :product_image => product_image)
    products.push(product)
  end
end

# Listings
listings = Array.new
products.each do |product|
  (1..3).each do |x|
    listing = Listing.create(:name => "Listing #{x}", :product_id => product.id, :price => x, :quantity => x)
    listing.errors.each{ |x| puts x}
    listings.push(listing)
  end
end

# Shipping Service
ship_service = ShippingService.create(:name => "Test Ship Service", :active => true)

# Shipping Method
ship_method = ShippingMethod.create(:name => "Test Ship Method", :price => 1, :active => true, :shipping_service_id => ship_service.id)

# Cart
cart = Cart.create(:session_id => "Test Cart", :active => true)

# Line Items
line_items = Array.new
listings.each do |listing|
  line_item = LineItem.create(:cart_id => cart.id, :listing_id => listing.id, :quantity => 1)
  line_items.push(line_item)
end

# Order - Persist and Adjust
order = Order.create(:email => user.email, :order_status => :checkout_completed, :cart_id => cart.id, :shipping_method_id => ship_method.id)
cart.persist_line_items
cart.adjust_line_items(order.id)

# Discount Codes
discount_percentage = DiscountCode.create(:name => "Percentage Test Code", :code => "percent", :percentage => 50)
discount_deduct = DiscountCode.create(:name => "Deduction Test Code", :code => "deduct", :deduction => 5.0)
discount_usage = DiscountCode.create(:name => "Usage Test Code", :code => "usage", :usage_limit => 1)