class Cart < ActiveRecord::Base
  has_many :line_items
  
  validates :session_id, :presence => true
end
