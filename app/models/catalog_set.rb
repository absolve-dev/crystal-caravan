class CatalogSet < ActiveRecord::Base
  belongs_to :catalog
  has_many :catalog_cards
  belongs_to :category
end
