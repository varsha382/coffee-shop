class Item < ApplicationRecord
  belongs_to :tax_rate
  has_one_attached :image
end
