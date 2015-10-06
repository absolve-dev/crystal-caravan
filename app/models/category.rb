require 'PermalinkValidator'

class Category < ActiveRecord::Base
  belongs_to :game
  
  has_many :products
  
  mount_uploader :default_image, ThumbnailImageUploader
  
  validates :name, :presence => true, :uniqueness => true
  validates :permalink, :presence => true, :permalink => true
  
  def to_param
    self.permalink ? "#{id}-#{self.permalink}" : "{id}"
  end
end
