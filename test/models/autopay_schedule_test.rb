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
require "test_helper"

class AutopayScheduleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
