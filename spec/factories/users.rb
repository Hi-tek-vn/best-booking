# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                                     :integer          not null, primary key
#  email                                  :string
#  encrypted_password                     :string           default(""), not null
#  reset_password_token                   :string
#  reset_password_sent_at                 :datetime
#  allow_password_change                  :boolean          default(FALSE), not null
#  sign_in_count                          :integer          default(0), not null
#  current_sign_in_at                     :datetime
#  last_sign_in_at                        :datetime
#  current_sign_in_ip                     :inet
#  last_sign_in_ip                        :inet
#  first_name                             :string           default("")
#  last_name                              :string           default("")
#  username                               :string           default("")
#  created_at                             :datetime         not null
#  updated_at                             :datetime         not null
#  provider                               :string           default("email"), not null
#  uid                                    :string           default(""), not null
#  tokens                                 :json
#  phone                                  :text             default("")
#  user_type                              :string
#  investor_income_response               :boolean          default(FALSE)
#  investor_net_worth_response            :boolean          default(FALSE)
#  investor_executive_response            :boolean          default(FALSE)
#  investor_business_development_response :boolean          default(FALSE)
#  case_owner_behalf                      :boolean          default(FALSE)
#  case_owner_address                     :string
#  case_owner_employment_status           :string
#  case_owner_passport                    :string
#  case_owner_dob                         :string
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_uid_and_provider      (uid,provider) UNIQUE
#

FactoryBot.define do
  factory :user do
    email    { Faker::Internet.unique.email }
    password { Faker::Internet.password(min_length: 8) }
    username { Faker::Internet.unique.user_name }
    uid      { Faker::Internet.uuid }
  end
end
