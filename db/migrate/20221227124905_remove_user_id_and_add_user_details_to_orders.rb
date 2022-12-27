class RemoveUserIdAndAddUserDetailsToOrders < ActiveRecord::Migration[7.0]
  def change
    remove_reference :orders, :user
    add_column :orders, :customer_name, :string
    add_column :orders, :customer_contact_number, :string
  end
end
