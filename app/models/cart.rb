class Cart < ActiveRecord::Base
  has_many :line_items
  
  accepts_nested_attributes_for :line_items, allow_destroy: true
  
  validates :session_id, :presence => true
  
  def check_stock
    errors = self.line_items.collect do |item|
      item.valid?
      item.errors ? "#{item.errors.full_messages.to_sentence}" : nil
    end.compact
    errors.length > 0 ? errors : true
  end
  
  def persist_line_items
    for item in self.line_items
      item.persist
    end
  end
  
  def adjust_line_items(order_id)
    for item in self.line_items
      item.create_adjustment(order_id)
    end
  end
end
