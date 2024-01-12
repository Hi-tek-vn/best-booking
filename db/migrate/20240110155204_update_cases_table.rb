class UpdateCasesTable < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    change_column :cases, :claim_sum, :float, default: 0.0
    change_column :cases, :total_funds, :float, default: 0.0
  end
end
