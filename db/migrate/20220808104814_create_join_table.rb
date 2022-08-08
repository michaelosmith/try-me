class CreateJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_join_table :fitness_class_schedules, :clients, table_name: 'fitness_class_bookings' do |t|
      # t.index [:fitness_class_schedule_id, :client_id]
      # t.index [:client_id, :fitness_class_schedule_id]
      # t.integer :fitness_class_schedule_id
      # t.integer :client_id
    end
  end
end
