class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item

  delegate :name, to: :item, prefix: :item
end
