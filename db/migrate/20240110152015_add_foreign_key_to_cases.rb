class AddForeignKeyToCases < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    add_foreign_key :cases, :users, column: :author_id, validate: false
  end
end
