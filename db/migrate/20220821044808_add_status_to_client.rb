class AddStatusToClient < ActiveRecord::Migration[7.0]
  def change
    add_column :clients, :status, :string
  end
end
