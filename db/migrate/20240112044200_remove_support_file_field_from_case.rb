class RemoveSupportFileFieldFromCase < ActiveRecord::Migration[7.0]
  def change
    remove_column :cases, :supporting_file
  end
end
