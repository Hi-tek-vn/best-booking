class AddActiveCategories < ActiveRecord::Migration[7.0]
  def change
    add_column :categories, :is_overview, :boolean, default: false
    add_column :categories, :is_navbar, :boolean, default: false
  end
end
