ActiveAdmin.register Case do
  permit_params :case_type, :case_relation, :case_status, :short_description, :case_description,
                :supporting_file, :claim_sum, :total_funds, :case_duration, :know_defendant,
                :know_jurisdiction, :previous_judgement, :legal_strategy, :signed_contract,
                :risk_level, :plaintiff_payout, :investor_payout, :lix_payout, :author_id, category_ids: []

  form do |f|
    f.inputs 'Case Details' do
      f.input :case_type
      f.input :case_relation
      f.input :case_status
      f.input :categories, as: :select, collection: Category.all
      f.input :short_description
      f.input :case_description
      f.input :supporting_file, as: :file
      f.input :claim_sum
      f.input :total_funds
      f.input :case_duration
      f.input :know_defendant
      f.input :know_jurisdiction
      f.input :previous_judgement
      f.input :legal_strategy
      f.input :signed_contract
      f.input :risk_level
      f.input :plaintiff_payout
      f.input :investor_payout
      f.input :lix_payout
      f.input :author, as: :select, collection: User.all, include_blank: false
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :case_type
    column :case_relation
    column :case_status
    column 'Author' do |case_instance|
      case_instance.author.first_name
    end
    column :short_description
    column :claim_sum
    column :total_funds
    column :case_duration
    column :know_defendant
    column :know_jurisdiction
    column :previous_judgement
    column :legal_strategy
    column :signed_contract
    column :risk_level
    column :plaintiff_payout
    column :investor_payout
    column :lix_payout
    column 'Categories' do |case_instance|
      case_instance.categories.map(&:name).join(', ')
    end

    actions
  end

  show do
    attributes_table do
      row :id
      row :case_type
      row :case_relation
      row :case_status
      row 'Author' do |case_instance|
        case_instance.author.first_name
      end
      row :short_description
      row :case_description
      row :supporting_file do |case_instance|
        if case_instance.supporting_file.attached?
          link_to 'Download File', url_for(case_instance.supporting_file), download: true
        else
          'No file attached'
        end
      end
      row :claim_sum
      row :total_funds
      row :case_duration
      row :know_defendant
      row :know_jurisdiction
      row :previous_judgement
      row :legal_strategy
      row :signed_contract
      row :risk_level
      row :plaintiff_payout
      row :investor_payout
      row :lix_payout
      row 'Categories' do |case_instance|
        case_instance.categories.map(&:name).join(', ')
      end
    end
  end
end