class AddMindbodyIdToFitnessClass < ActiveRecord::Migration[7.0]
  def change
    add_column :fitness_classes, :mindbody_id, :integer
  end
end
