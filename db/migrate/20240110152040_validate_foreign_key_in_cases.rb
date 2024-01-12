class ValidateForeignKeyInCases < ActiveRecord::Migration[7.0]
  def change
    validate_foreign_key :cases, :users
  end
end
