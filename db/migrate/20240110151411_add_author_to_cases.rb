class AddAuthorToCases < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    add_reference :cases, :author, index: { algorithm: :concurrently }
  end
end
