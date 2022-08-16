class CreateSales < ActiveRecord::Migration[7.0]
  def change
    create_table :sales do |t|
      t.references :client, null: false, foreign_key: true
      t.integer :mindbody_sale_id
      t.string :mindbody_client_id
      t.datetime :date
      t.decimal :price, precision: 8, scale: 2
      t.decimal :tax, precision: 8, scale: 2
      t.decimal :total_amount, precision: 8, scale: 2
      t.string :description
      t.string :payment_type

      t.timestamps
    end
  end
end
