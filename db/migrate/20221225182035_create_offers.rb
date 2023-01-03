class CreateOffers < ActiveRecord::Migration[7.0]
  def change
    create_table :offers do |t|
      t.integer "base_item_id"
      t.integer "child_item_id"
      t.integer "base_item_quantity"
      t.integer "child_item_quantity"
      t.boolean "is_discount_available"
      t.integer "discount_percent"
      t.integer "offer_applied_on_item_type_id"
      t.integer "free_item_id"
      t.integer "free_item_quantity"
      t.string "code", unique: true
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  end
end
