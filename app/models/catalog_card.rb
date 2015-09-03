class CatalogCard < ActiveRecord::Base
  belongs_to :catalog_sets
  
  mount_uploader :product_image, ProductImageUploader
end
