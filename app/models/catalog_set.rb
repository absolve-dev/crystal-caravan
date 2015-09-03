class CatalogSet < ActiveRecord::Base
  has_many :catalog_cards
  belongs_to :catalogs
end
