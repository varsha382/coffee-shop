class CreateOfferedItems < ActiveRecord::Migration[7.0]
  def change
    create_table :offered_items do |t|
      t.string :type
      t.float :quantity
      t.references :item, null: false, foreign_key: true
      t.references :offer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
