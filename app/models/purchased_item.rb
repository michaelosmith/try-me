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
class PurchasedItem < ApplicationRecord
  belongs_to :sale
  has_one :client, through: :sale


  scope :is_service, -> { where(is_service: true) }
  scope :not_service, -> { where(is_service: false) }

  # Broadcast changes in realtime with Hotwire
  after_create_commit  -> { broadcast_prepend_later_to :purchased_items, partial: "purchased_items/index", locals: { purchased_item: self } }
  after_update_commit  -> { broadcast_replace_later_to self }
  after_destroy_commit -> { broadcast_remove_to :purchased_items, target: dom_id(self, :index) }
end
