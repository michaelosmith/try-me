class SyncFitnessClassScheduleJob
  include Sidekiq::Job

  def perform
    mb = Mindbody::Service.new(
      Rails.application.credentials.mindbody[:api_key],
      Rails.application.credentials.mindbody[:site_id],
      ENV['auth_token']
    )

    requests = mb.get_classes

    requests.each do |fitness_class_schedules|
      if fitness_class_schedules.present?
        fitness_class_schedules.each do |fitness_class_schedule|
          fitness_class = FitnessClass.find_by(mindbody_id: fitness_class_schedule[:ClassDescription][:Id])
          if fitness_class.present?
            fitness_class.fitness_class_schedules.create!(
              mindbody_id: fitness_class_schedule[:Id],
              mindbody_class_schedule_id: fitness_class_schedule[:ClassScheduleId],
              book_online_capacity: fitness_class_schedule[:WebCapacity],
              capacity: fitness_class_schedule[:MaxCapacity],
              start_date: fitness_class_schedule[:StartDateTime],
              start_time: fitness_class_schedule[:StartDateTime],
              end_time: fitness_class_schedule[:EndDateTime]
            )
          end
        end
      end
    end
  end
end