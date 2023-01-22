class SyncFitnessClassBookingsJob
  include Sidekiq::Job

  def perform
    mb = Mindbody::Service.new(
      Rails.application.credentials.mindbody[:api_key],
      Rails.application.credentials.mindbody[:site_id],
      ENV['auth_token']
    )

    clients = Client.all

    clients.each do |client|
      requests = mb.get_client_schedule(client.mindbody_id)

      requests.each do |fitness_class_bookings|
        if fitness_class_bookings.present?
          if fitness_class_bookings.is_a?(Array)
            fitness_class_bookings.each do |fitness_class_booking|
              fitness_class = FitnessClassSchedule.find_by(mindbody_id: fitness_class_booking[:ClassId].to_i)
              if fitness_class.present?
                FitnessClassBooking.create!(client_id: client.id, fitness_class_schedule_id: fitness_class.id)
              end
            end
          else
            fitness_class = FitnessClassSchedule.find_by(mindbody_id: fitness_class_bookings[:ClassId].to_i)
            if fitness_class.present?
              FitnessClassBooking.create!(client_id: client.id, fitness_class_schedule_id: fitness_class.id)
            end
          end
        end
      end
    end
  end
end