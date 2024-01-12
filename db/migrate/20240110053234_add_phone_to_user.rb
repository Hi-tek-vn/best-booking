class AddPhoneToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :phone, :text, default: ""
    add_column :users, :user_type, :string
    add_column :users, :investor_income_response, :boolean, default: false
    add_column :users, :investor_net_worth_response, :boolean, default: false
    add_column :users, :investor_executive_response, :boolean, default: false
    add_column :users, :investor_business_development_response, :boolean, default: false
    add_column :users, :case_owner_behalf, :boolean, default: false
    add_column :users, :case_owner_address, :string
    add_column :users, :case_owner_employment_status, :string
    add_column :users, :case_owner_passport, :string
    add_column :users, :case_owner_dob, :string
  end
end
