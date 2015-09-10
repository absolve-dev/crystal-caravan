class CatalogCard < ActiveRecord::Base
  belongs_to :catalog_set
  belongs_to :product
  
  mount_uploader :product_image, ProductImageUploader
end
