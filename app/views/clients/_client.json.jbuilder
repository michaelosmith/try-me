json.extract! client, :id, :mindbody_id, :first_name, :last_name, :email, :photo, :gender, :date_of_birth, :member, :mindbody_profile_created, :mindbody_profile_updated, :account_id, :created_at, :updated_at
json.url client_url(client, format: :json)
