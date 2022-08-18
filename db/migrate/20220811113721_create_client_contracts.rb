class CreateClientContracts < ActiveRecord::Migration[7.0]
  def change
    create_table :client_contracts do |t|
      t.references :client, null: false, foreign_key: true
      t.string :name
      t.string :autopay_status
      t.time :start_date
      t.time :end_date
      # t.references :autpay_schedule, null: false, foreign_key: true

      t.timestamps
    end
  end
end
