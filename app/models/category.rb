require 'PermalinkValidator'

class Category < ActiveRecord::Base
  has_many :categories
  
  has_many :products
  
  mount_uploader :default_picture, CategoryImageUploader
  
  validates :name, :presence => true, :uniqueness => true
  validates :permalink, :presence => true, :permalink => true
end
