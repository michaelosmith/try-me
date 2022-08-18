class AddMindbodyContractIdToAutopaySchedule < ActiveRecord::Migration[7.0]
  def change
    rename_column :autopay_schedules, :mindbody_id, :mindbody_contract_id
  end
end
