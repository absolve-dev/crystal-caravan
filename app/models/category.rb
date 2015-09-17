require 'PermalinkValidator'

class Category < ActiveRecord::Base
  belongs_to :game
  
  has_many :products
  
  mount_uploader :default_picture, CategoryImageUploader
  
  validates :name, :presence => true, :uniqueness => true
  validates :permalink, :presence => true, :permalink => true
end
