class CreateClients < ActiveRecord::Migration[7.0]
  def change
    create_table :clients do |t|
      t.string :mindbody_id
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :photo
      t.string :gender
      t.date :date_of_birth
      t.boolean :member
      t.datetime :mindbody_profile_created
      t.datetime :mindbody_profile_updated
      t.integer :account_id

      t.timestamps
    end
  end
end
