class ItemType < ApplicationRecord
  has_many :items
  has_one :tax_rate
end
