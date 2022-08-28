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
class Sale < ApplicationRecord
  belongs_to :client
  has_many :purchased_items, dependent: :destroy

  scope :service_sale, -> { joins(:purchased_items).merge(PurchasedItem.is_service) }
  scope :retail_sale, -> { joins(:purchased_items).merge(PurchasedItem.not_service) }
  # scope :client_lifetime_value, ->(client) { service_sale.where(client_id: client.id).select(:total_amount).sum(:total_amount).to_f }

  # Broadcast changes in realtime with Hotwire
  # after_create_commit  -> { broadcast_prepend_later_to :sales, partial: "sales/index", locals: { sale: self } }
  # after_update_commit  -> { broadcast_replace_later_to self }
  # after_destroy_commit -> { broadcast_remove_to :sales, target: dom_id(self, :index) }
end
