# == Schema Information
#
# Table name: sales
#
#  id                 :bigint           not null, primary key
#  date               :datetime
#  description        :string
#  payment_type       :string
#  price              :decimal(8, 2)
#  tax                :decimal(8, 2)
#  total_amount       :decimal(8, 2)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  client_id          :bigint           not null
#  mindbody_client_id :string
#  mindbody_sale_id   :integer
#
# Indexes
#
#  index_sales_on_client_id  (client_id)
#
# Foreign Keys
#
#  fk_rails_...  (client_id => clients.id)
#
require "test_helper"

class SaleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
