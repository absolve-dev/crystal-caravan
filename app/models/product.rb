require 'PermalinkValidator'

class Product < ActiveRecord::Base
  has_many :listings
  
  belongs_to :categories
  
  mount_uploader :default_picture, ProductImageUploader
  
  validates :name, :presence => true
  validates :permalink, :presence => true, :permalink => true
  validates :category_id, :presence => true
  validates :weight, :presence => true, :numericality => true
end
