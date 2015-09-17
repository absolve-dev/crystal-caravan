require 'PermalinkValidator'

class Game < ActiveRecord::Base
  has_many :categories
  
  mount_uploader :default_picture, CategoryImageUploader
  
  validates :name, :presence => true, :uniqueness => true
  validates :permalink, :presence => true, :permalink => true
end
