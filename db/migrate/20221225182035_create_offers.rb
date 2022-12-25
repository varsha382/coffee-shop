class CreateOffers < ActiveRecord::Migration[7.0]
  def change
    create_table :offers do |t|
      t.string :name
      t.boolean :is_offer_on_amount
      t.float :amount
      t.float :percent

      t.timestamps
    end
  end
end
