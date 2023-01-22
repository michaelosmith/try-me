class SyncFitnessClassJob
  include Sidekiq::Job

  def perform
    mb = Mindbody::Service.new(
      Rails.application.credentials.mindbody[:api_key],
      Rails.application.credentials.mindbody[:site_id],
      ENV['auth_token']
    )

    requests = mb.get_class_descriptions

    requests.each do | fitness_classes|
      fitness_classes.each do |fitness_class|
        FitnessClass.create!(
          mindbody_id: fitness_class[:Id],
          name: fitness_class[:Name],
          category: fitness_class[:Category],
          class_type: fitness_class[:SessionType][:Name],
          level: fitness_class[:Level],
          image: fitness_class[:ImageURL],
          description: fitness_class[:Description]
        )
      end
    end
  end
end