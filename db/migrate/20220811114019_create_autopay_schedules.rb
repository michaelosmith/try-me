class CreateAutopaySchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :autopay_schedules do |t|
      t.time :date
      t.integer :charge
      t.integer :mindbody_id
      t.references :client_contract, null: false, foreign_key: true

      t.timestamps
    end
  end
end
