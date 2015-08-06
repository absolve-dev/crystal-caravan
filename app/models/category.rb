class Category < ActiveRecord::Base
  has_many :categories
  belongs_to :categories
  
  has_many :products
end
