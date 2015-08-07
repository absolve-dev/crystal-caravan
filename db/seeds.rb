# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Products and Categories seeds
category_one = Category.create({name:'Big Boy'})

category_two = Category.create({name:'Little Man',category_id:category_one.id})

product_one = Product.create({name:'Little Thing', category_id:category_two.id})

listing_one = Listing.create({name:'Brand New',price:1.0,product_id:product_one.id})

    # Seeds for Cart and LineItems
    cart_products = Array.new

    cart_listings = Array.new

    cart_category = Category.create({name:'Test Category'}, category_id:10501)

    for i in 0..10
        cart_products[i] = Product.create({name:"Test Product #{i}", category_id:cart_category.id})
        cart_listings[i] = Listing.create({name:"Test Listing #{i}", product_id:cart_products[i].id})
    end

# Cart and LineItem seeds

cart_one = Cart.create({session_id:91007})

line_items = Array.new

for i in 0..10
    line_items[i] = LineItem.create({listing_id:cart_listings[i].id, cart_id:cart_one.id})
end