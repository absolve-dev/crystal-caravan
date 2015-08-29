# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Products and Categories seeds

category_one_image = File.open(File.join(Rails.application.root, 'db', 'seeds_images', 'big-boy.jpg'), 'rb')
category_one = Category.create({name:'Big Boy',permalink:'big-boy',default_picture:category_one_image})

category_two = Category.create({name:'Little Man',permalink:'little-man',category_id:category_one.id})

product_one_image = File.open(File.join(Rails.application.root, 'db', 'seeds_images', 'little-thing.jpg'), 'rb')
product_one = Product.create({name:'Little Thing',permalink:'little-thing', category_id:category_two.id,weight:5.67,default_picture:product_one_image})


listing_one = Listing.create({name:'Brand New',price:1.00,product_id:product_one.id,quantity:12})

# Seeds for Cart and LineItems
cart_products = Array.new

cart_listings = Array.new

cart_category = Category.create({name:'Test Category', permalink:'test-category-1'})

for i in 0..10
    cart_products[i] = Product.create({name:"Test Product #{i}", permalink:"test-product-#{i}", category_id:cart_category.id, weight:i+0.01})
    cart_listings[i] = Listing.create({name:"Test Listing #{i}", product_id:cart_products[i].id, price:1.1+i.to_f, quantity:i})
end

# Cart and LineItem seeds

cart_one = Cart.create({session_id:"909090"})

line_items = Array.new

for i in 0..10
    line_items[i] = LineItem.create({quantity:i+1, listing_id:cart_listings[i].id, cart_id:cart_one.id})
end