class AddSomeColumnsToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :is_offer_on_amount, :boolean
    add_column :orders, :amount, :float
    add_column :orders, :total_tax, :float
    add_column :orders, :free_items, :string
  end
end
