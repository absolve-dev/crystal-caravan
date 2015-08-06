class Product < ActiveRecord::Base
  has_many :listings
  
  belongs_to :categories
end
