class Offer < ApplicationRecord
  belongs_to :base_item, class_name: "Item"
  belongs_to :child_item, class_name: "Item", optional: true
  belongs_to :free_item, class_name: "Item", optional: true
  belongs_to :offer_applied_on_item_type, class_name: "ItemType", optional: true

  delegate :name, :image_url, to: :base_item, prefix: true
  delegate :name, :image_url, to: :child_item, prefix: true, allow_nil: true
  delegate :name, :image_url, to: :free_item, prefix: true, allow_nil: true
  delegate :name, to: :offer_applied_on_item_type, prefix: true, allow_nil: true
end
