require 'PermalinkValidator'

class Product < ActiveRecord::Base
  has_many :listings
  accepts_nested_attributes_for :listings
  
  belongs_to :categories
  
  mount_uploader :default_picture, ProductImageUploader
  
  validates :name, :presence=> true, :on => :create
  validates :permalink, :presence => true, :permalink => true
  validates :category_id, :presence => true
  validates :weight, :presence => true, :numericality => true
end
