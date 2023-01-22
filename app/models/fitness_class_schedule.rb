# == Schema Information
#
# Table name: fitness_class_schedules
#
#  id                         :bigint           not null, primary key
#  book_online_capacity       :integer
#  capacity                   :integer
#  end_time                   :time
#  start_date                 :date
#  start_time                 :time
#  waitlist_capacity          :integer
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  fitness_class_id           :bigint           not null
#  mindbody_class_schedule_id :integer
#  mindbody_id                :integer
#
# Indexes
#
#  index_fitness_class_schedules_on_fitness_class_id  (fitness_class_id)
#
# Foreign Keys
#
#  fk_rails_...  (fitness_class_id => fitness_classes.id)
#
class FitnessClassSchedule < ApplicationRecord
  belongs_to :fitness_class
  has_many :fitness_class_bookings
  has_many :clients, through: :fitness_class_bookings

  # validates :name, presence: :true
  # validates :description, presence: :true

  # Broadcast changes in realtime with Hotwire
  # after_create_commit  -> { broadcast_prepend_later_to :fitness_class_schedules, partial: "fitness_class_schedules/index", locals: { fitness_class_schedule: self } }
  # after_update_commit  -> { broadcast_replace_later_to self }
  # after_destroy_commit -> { broadcast_remove_to :fitness_class_schedules, target: dom_id(self, :index) }
end
