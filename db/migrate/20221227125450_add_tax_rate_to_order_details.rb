class AddTaxRateToOrderDetails < ActiveRecord::Migration[7.0]
  def change
    add_column :order_details, :tax_rate, :float
  end
end
