class CreateJoinTableCasesCategories < ActiveRecord::Migration[7.0]
  def change
    create_join_table :cases, :categories do |t|
      # t.index [:case_id, :category_id]
      # t.index [:category_id, :case_id]
    end
  end
end
