class RenameTypeToClassTypeFitnessClass < ActiveRecord::Migration[7.0]
  def change
    rename_column :fitness_classes, :type, :class_type
  end
end
