class ChangeClientContractToDate < ActiveRecord::Migration[7.0]
  def change
    remove_column :client_contracts, :start_date
    remove_column :client_contracts, :end_date

    add_column :client_contracts, :start_date, :date
    add_column :client_contracts, :end_date, :date
  end
end
