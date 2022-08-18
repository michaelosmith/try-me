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

  has_many :fitness_class_bookings, dependent: :destroy
  has_many :fitness_class_schedules, through: :fitness_class_bookings
  has_many :sales, dependent: :destroy
  has_many :purchased_items, through: :sales
  has_many :client_contracts
  has_many :autopay_schedules, through: :client_contracts

  scope :lifetime_value, ->(client) { Sale.service_sale.where(client_id: client.id).select(:total_amount).sum(:total_amount).to_f }


  def self.avg_lifetime_value
    Sale.service_sale.select(:total_amount).sum(:total_amount).to_f / self.count
  end
  # Broadcast changes in realtime with Hotwire
  after_create_commit  -> { broadcast_prepend_later_to :clients, partial: "clients/index", locals: { client: self } }
  after_update_commit  -> { broadcast_replace_later_to self }
  # after_update_commit  -> { broadcast_replace_later_to :client, partial: client, locals: { client: self } }
  after_destroy_commit -> { broadcast_remove_to :clients, target: dom_id(self, :index) }
end
