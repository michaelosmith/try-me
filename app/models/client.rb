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
#  status                   :string
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


  sql = <<-SQL
    SELECT
      SUM(sales.total_amount) / COUNT(DISTINCT clients.mindbody_id) as avg_lifetime_value
    FROM clients
      INNER JOIN sales ON sales.client_id = clients.id
      INNER JOIN purchased_items ON purchased_items.sale_id = sales.id
    WHERE
      purchased_items.is_service = TRUE;
  SQL

  scope :current_or_has_been_member, -> { joins(:client_contracts).distinct }
  scope :lifetime_value, ->(client) { Sale.client_lifetime_sales(client.id) }
  scope :avg_lifetime_value, -> { Sale.service_sale.select(:total_amount).sum(:total_amount).to_f / self.current_or_has_been_member.count.to_f }
  scope :avg_client_value, -> { ActiveRecord::Base.connection.execute(sql)[0]["avg_lifetime_value"].to_f }

  
  # Class methods


  # Instance methods
  def has_had_contract?
    ClientContract.where(client_id: self.id).any?
  end


  # Broadcast changes in realtime with Hotwire
  # after_create_commit  -> { broadcast_prepend_later_to :clients, partial: "clients/index", locals: { client: self } }
  # after_update_commit  -> { broadcast_replace_later_to self }
  # after_destroy_commit -> { broadcast_remove_to :clients, target: dom_id(self, :index) }
end
