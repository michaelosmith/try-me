# == Schema Information
#
# Table name: fitness_classes
#
#  id         :bigint           not null, primary key
#  category   :string
#  image      :string
#  level      :string
#  name       :string
#  type       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class FitnessClassTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
