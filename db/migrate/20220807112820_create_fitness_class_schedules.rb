class CreateFitnessClassSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :fitness_class_schedules do |t|
      t.references :fitness_class, null: false, foreign_key: true
      t.date :start_date
      t.time :start_time
      t.time :end_time
      t.integer :capacity
      t.integer :book_online_capacity
      t.integer :waitlist_capacity

      t.timestamps
    end
  end
end
