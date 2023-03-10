class CreateOrderDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :order_details do |t|
      t.references :order, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.float :amount
      t.float :total_tax
      t.float :total_amount
      t.integer :quantity
      t.boolean :is_free_item, default: :false
      t.float :discount_amount

      t.timestamps
    end
  end
end
