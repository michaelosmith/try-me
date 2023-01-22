class SyncClientJob
  include Sidekiq::Job

  def perform
    mb = Mindbody::Service.new(
      Rails.application.credentials.mindbody[:api_key],
      Rails.application.credentials.mindbody[:site_id],
      ENV['auth_token']
    )

    requests = mb.get_all_clients

    requests.each do |clients|
      clients.each do |client|
        client = Client.create!(
          mindbody_id: client[:Id],
          first_name: client[:FirstName],
          last_name: client[:LastName],
          email: client[:Email],
          photo: client[:PhotoUrl],
          gender: client[:Gender],
          date_of_birth: client[:BirthDate],
          status: client[:Status],
          mindbody_profile_created: client[:CreationDate],
          mindbody_profile_updated: client[:LastModifiedDateTime],
          account_id: 1
        )
      end
    end
  end
end