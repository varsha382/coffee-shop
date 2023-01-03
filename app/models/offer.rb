class Offer < ApplicationRecord
  belongs_to :base_item, class_name: "Item"
  belongs_to :child_item, class_name: "Item", optional: true
  belongs_to :free_item, class_name: "Item", optional: true
  belongs_to :offer_applied_on_item_type, class_name: "ItemType", optional: true
end
