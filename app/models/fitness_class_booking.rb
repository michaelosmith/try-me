# == Schema Information
#
# Table name: fitness_class_bookings
#
#  client_id                 :bigint           not null
#  fitness_class_schedule_id :bigint           not null
#
class FitnessClassBooking < ApplicationRecord
  belongs_to :client
  belongs_to :fitness_class_schedule

  # validates :client_id, uniqueness: { scope: :fitness_class_schedule_id, message: ": A booking already exists for this client in this class." }
  # validates :fitness_class_schedule_id, uniqueness: { scope: :client_id, message: ": A booking already exists for this client in this class." }

  # after_create_commit -> {
  #   broadcast_update_later_to self.fitness_class_schedule,
  #   target: "#{dom_id(self.fitness_class_schedule)}_bookings_count",
  #   html: self.fitness_class_schedule.clients.count
  # }

  # after_destroy_commit -> {
  #   broadcast_update_later_to self.fitness_class_schedule,
  #   target: "#{dom_id(self.fitness_class_schedule)}_bookings_count",
  #   html: self.fitness_class_schedule.clients.count,
  #   locals: { fitness_class_booking: nil }
  # }
end
