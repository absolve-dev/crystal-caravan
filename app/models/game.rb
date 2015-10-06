require 'PermalinkValidator'

class Game < ActiveRecord::Base
  has_many :categories
  
  mount_uploader :default_image, ThumbnailImageUploader
  
  validates :name, :presence => true, :uniqueness => true
  validates :permalink, :presence => true, :permalink => true
  
  def to_param
    self.permalink ? "#{id}-#{self.permalink}" : "{id}"
  end
end
