class RenameColumnTypeToItemTypeIntoItems < ActiveRecord::Migration[7.0]
  def change
    add_reference :items, :item_type, index: true
    remove_column :items, :type, :string
  end
end
