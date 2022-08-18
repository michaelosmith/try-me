class ChangeAutoPayScheduleToDate < ActiveRecord::Migration[7.0]
  def change
    drop_table :autopay_schedules

    create_table :autopay_schedules do |t|
      t.date :date
      t.decimal :charge, precision: 8, scale: 2
      t.integer :mindbody_id
      t.references :client_contract, null: false, foreign_key: true

      t.timestamps
    end
  end
end
