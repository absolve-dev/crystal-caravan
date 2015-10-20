require 'PermalinkValidator'

class Product < ActiveRecord::Base
  has_many :listings
  accepts_nested_attributes_for :listings, :allow_destroy => true
  
  belongs_to :category
  
  mount_uploader :product_image, ProductImageUploader
  
  has_one :catalog_card
  
  validates :name, :presence => true, :on => :create
  validates :category_id, :presence => true
  validates :weight, :numericality => true
  validates :permalink, :presence => true, :permalink => true
  
  # create default listings
  after_create do
    if self.collectible
      # Near Mint
      Listing.create(:name => "Near Mint", :product_id => self.id, :price => 0.0, :quantity => 0)
      # Played
      Listing.create(:name => "Played", :product_id => self.id, :price => 0.0, :quantity => 0)
    end
  end
  
  def to_param
    self.permalink ? "#{id}-#{self.permalink}" : "{id}"
  end
  
end
