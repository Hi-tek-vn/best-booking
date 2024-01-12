ActiveAdmin.register Category do
  permit_params :name, :is_navbar, :is_overview
  remove_filter :cases

  form do |f|
    f.inputs 'Category Details' do
      f.input :name
      f.input :is_overview
      f.input :is_navbar
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :name
    column :is_overview
    column :is_navbar

    actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :is_overview
      row :is_navbar
    end
  end
end