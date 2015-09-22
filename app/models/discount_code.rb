class DiscountCode < ActiveRecord::Base
  def multiplier
    self.percentage && self.percentage > 0.0 ? self.percentage * 0.01 : false
  end
end
