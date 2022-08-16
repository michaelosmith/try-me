class CreatePurchasedItems < ActiveRecord::Migration[7.0]
  def change
    create_table :purchased_items do |t|
      t.references :sale, null: false, foreign_key: true
      t.integer :mindbody_purchased_item_id
      t.boolean :is_service
      t.string :description
      t.string :contract_id
      t.integer :quantity
      t.decimal :unti_price, precision: 8, scale: 2
      t.decimal :tax, precision: 8, scale: 2
      t.decimal :amount, precision: 8, scale: 2

      t.timestamps
    end
  end
end
