class CreateTaxRates < ActiveRecord::Migration[7.0]
  def change
    create_table :tax_rates do |t|
      t.float :rate
      t.references :item_type

      t.timestamps
    end
  end
end
