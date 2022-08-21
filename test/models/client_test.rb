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
require "test_helper"

class ClientTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
