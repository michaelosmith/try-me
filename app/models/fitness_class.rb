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
class FitnessClass < ApplicationRecord
  has_many :fitness_class_schedules

  has_rich_text :description

  validates :name, presence: :true
  # validates :description, presence: :true

  # Broadcast changes in realtime with Hotwire
  # after_create_commit  -> { broadcast_prepend_later_to :fitness_classes, partial: "fitness_classes/index", locals: { fitness_class: self } }
  # after_update_commit  -> { broadcast_replace_later_to self }
  # after_destroy_commit -> { broadcast_remove_to :fitness_classes, target: dom_id(self, :index) }
end
