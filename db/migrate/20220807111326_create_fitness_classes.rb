class CreateFitnessClasses < ActiveRecord::Migration[7.0]
  def change
    create_table :fitness_classes do |t|
      t.string :name
      t.string :category
      t.string :type
      t.string :level
      t.string :image

      t.timestamps
    end
  end
end
