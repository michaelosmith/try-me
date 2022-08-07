# == Schema Information
#
# Table name: fitness_class_schedules
#
#  id                   :bigint           not null, primary key
#  book_online_capacity :integer
#  capacity             :integer
#  end_time             :time
#  start_date           :date
#  start_time           :time
#  waitlist_capacity    :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  fitness_class_id     :bigint           not null
#
# Indexes
#
#  index_fitness_class_schedules_on_fitness_class_id  (fitness_class_id)
#
# Foreign Keys
#
#  fk_rails_...  (fitness_class_id => fitness_classes.id)
#
require "test_helper"

class FitnessClassScheduleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
