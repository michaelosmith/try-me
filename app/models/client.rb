# == Schema Information
#
# Table name: clients
#
#  id                       :bigint           not null, primary key
#  date_of_birth            :date
#  email                    :string
#  first_name               :string
#  gender                   :string
#  last_name                :string
#  member                   :boolean
#  mindbody_profile_created :datetime
#  mindbody_profile_updated :datetime
#  photo                    :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  account_id               :integer
#  mindbody_id              :string
#
class Client < ApplicationRecord

  acts_as_tenant :account
  # Broadcast changes in realtime with Hotwire
  after_create_commit  -> { broadcast_prepend_later_to :clients, partial: "clients/index", locals: { client: self } }
  after_update_commit  -> { broadcast_replace_later_to self }
  after_destroy_commit -> { broadcast_remove_to :clients, target: dom_id(self, :index) }
end
