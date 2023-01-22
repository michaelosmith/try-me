# == Schema Information
#
# Table name: fitness_classes
#
#  id          :bigint           not null, primary key
#  category    :string
#  class_type  :string
#  image       :string
#  level       :string
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  mindbody_id :integer
#
require "test_helper"

class FitnessClassTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
