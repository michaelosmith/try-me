module FitnessClassScheduleHelper

  def fitness_class_bookings_count(fitness_class_schedule)
    fitness_class_schedule.fitness_class_bookings.count
  end
end