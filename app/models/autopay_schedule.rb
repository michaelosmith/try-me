# == Schema Information
#
# Table name: autopay_schedules
#
#  id                   :bigint           not null, primary key
#  charge               :decimal(8, 2)
#  date                 :date
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  client_contract_id   :bigint           not null
#  mindbody_contract_id :integer
#
# Indexes
#
#  index_autopay_schedules_on_client_contract_id  (client_contract_id)
#
# Foreign Keys
#
#  fk_rails_...  (client_contract_id => client_contracts.id)
#
class AutopaySchedule < ApplicationRecord
  belongs_to :client_contract

  scope :upcoming_autopays, -> { where('date BETWEEN ? AND ?', Date.now, 14.days.from_now) }

  # Broadcast changes in realtime with Hotwire
  after_create_commit  -> { broadcast_prepend_later_to :autopay_schedules, partial: "autopay_schedules/index", locals: { autopay_schedule: self } }
  after_update_commit  -> { broadcast_replace_later_to self }
  after_destroy_commit -> { broadcast_remove_to :autopay_schedules, target: dom_id(self, :index) }
end
