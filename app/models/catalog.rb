class Catalog < ActiveRecord::Base
  has_many :catalog_sets
  has_many :catalog_cards, through: :catalog_sets
end
