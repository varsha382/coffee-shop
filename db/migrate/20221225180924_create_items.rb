class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :type
      t.string :name
      t.float :amount
      t.references :tax_rate, null: false, foreign_key: true

      t.timestamps
    end
  end
end
