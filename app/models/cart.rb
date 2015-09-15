class Cart < ActiveRecord::Base
  has_many :line_items
  
  accepts_nested_attributes_for :line_items, allow_destroy: true
  
  validates :session_id, :presence => true
  
  def persist_line_items
    for item in self.line_items
      item.persist
    end
  end
  
  def adjust_line_items
    for item in self.line_items
      item.create_adjustment
    end
  end
end
