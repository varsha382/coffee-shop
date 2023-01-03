class AddSomeColumnsToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :amount, :float
    add_column :orders, :total_tax, :float
    add_column :orders, :total_discount, :float
  end
end
