class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :type
      t.string :name
      t.float :amount

      t.timestamps
    end
  end
end
