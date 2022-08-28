# == Schema Information
#
# Table name: client_contracts
#
#  id                   :bigint           not null, primary key
#  autopay_status       :string
#  end_date             :date
#  name                 :string
#  start_date           :date
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  client_id            :bigint           not null
#  mindbody_contract_id :integer
#
# Indexes
#
#  index_client_contracts_on_client_id  (client_id)
#
# Foreign Keys
#
#  fk_rails_...  (client_id => clients.id)
#
class ClientContract < ApplicationRecord
  belongs_to :client
  has_many :autopay_schedules

  scope :contract_purchases, ->(contract) { PurchasedItem.is_service.where(contract_id: contract.mindbody_contract_id) }

  # Broadcast changes in realtime with Hotwire
  # after_create_commit  -> { broadcast_prepend_later_to :client_contracts, partial: "client_contracts/index", locals: { client_contract: self } }
  # after_update_commit  -> { broadcast_replace_later_to self }
  # after_destroy_commit -> { broadcast_remove_to :client_contracts, target: dom_id(self, :index) }
end
