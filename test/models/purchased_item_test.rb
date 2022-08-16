# == Schema Information
#
# Table name: purchased_items
#
#  id                         :bigint           not null, primary key
#  amount                     :decimal(8, 2)
#  description                :string
#  is_service                 :boolean
#  quantity                   :integer
#  tax                        :decimal(8, 2)
#  unti_price                 :decimal(8, 2)
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  contract_id                :string
#  mindbody_purchased_item_id :integer
#  sale_id                    :bigint           not null
#
# Indexes
#
#  index_purchased_items_on_sale_id  (sale_id)
#
# Foreign Keys
#
#  fk_rails_...  (sale_id => sales.id)
#
require "test_helper"

class PurchasedItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
