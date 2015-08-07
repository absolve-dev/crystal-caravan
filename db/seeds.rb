# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Products and Categories seeds
category_one = Category.create({name:'Big Boy',permalink:'big-boy'})

category_two = Category.create({name:'Little Man',permalink:'little-man',category_id:category_one.id})

product_one = Product.create({name:'Little Thing',permalink:'little-thing', category_id:category_two.id})

listing_one = Listing.create({name:'Brand New',price:1.0,product_id:product_one.id})