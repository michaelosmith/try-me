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
require "test_helper"

class ClientContractTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
