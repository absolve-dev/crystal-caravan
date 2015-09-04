require 'PermalinkValidator'

class Product < ActiveRecord::Base
  has_many :listings
  accepts_nested_attributes_for :listings
  
  belongs_to :categories
  
  mount_uploader :product_image, ProductImageUploader
  
  has_one :catalog_card
  
  validates :name, :presence=> true, :on => :create, :uniqueness => true
  validates :category_id, :presence => true
  validates :weight, :numericality => true
  validates :permalink, :presence => true, :permalink => true
end
