class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def set_line_items
    @line_items = { }
    for line_item in @cart.line_items do
      listing = Listing.find(line_item.listing_id)
      product = Product.find(listing.product_id)
      
      @total_items = (@total_items or 0) + line_item.quantity
      @total_price = (@total_items or 0.0) + (listing.price * line_item.quantity.to_f)
      
      @line_items[line_item[:id]] = { :listing_name => listing.name, :product_name => product.name, :image_url => product.default_picture.path, :price => listing.price }

    end
  end
  
  # initialize dashboard if required
  before_action :initialize_dashboard
  
  def initialize_dashboard
    self.class.layout '/layouts/dashboard.html.erb' if self.class.to_s.include? 'Dashboard::'
    authenticate_admin!
  end
  
  # initialize cart on every page
  before_action :set_cart
  
  def set_cart
      @cart = Cart.where({:session_id => session_id}).first
      @cart ||= Cart.create({:session_id => session_id})
  end
  
  def session_id
    session.id
  end
end
