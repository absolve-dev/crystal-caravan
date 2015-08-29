class Cart < ActiveRecord::Base
  has_many :line_items
  
  accepts_nested_attributes_for :line_items, allow_destroy: true
  
  validates :session_id, :presence => true
end
