class AddClassScheduleIdToFitnessClassSchedule < ActiveRecord::Migration[7.0]
  def change
    add_column :fitness_class_schedules, :mindbody_class_schedule_id, :integer
    add_column :fitness_class_schedules, :mindbody_id, :integer
  end
end
