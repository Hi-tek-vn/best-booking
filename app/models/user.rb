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

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User
  enum user_type: { investor: "investor", case_owner: "case_owner" }
  enum employment_status: { employer: "employer", company: "company", unemployed: "unemployed" }
  validates :uid, uniqueness: { scope: :provider }
  validates :user_type, inclusion: { in: %w(investor case_owner) }
  validate :validate_case_owner_employment_status, if: :case_owner?
  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "must be a valid email address" }
  validates :phone, presence: true, uniqueness: true, format: { with: /\A\d{10}\z/, message: "must be a valid 10-digit phone number" }

  before_validation :init_uid

  RANSACK_ATTRIBUTES = %w[id email first_name last_name username sign_in_count current_sign_in_at
                          last_sign_in_at current_sign_in_ip last_sign_in_ip provider uid
                          created_at updated_at].freeze

  has_many :cases, class_name: :case, foreign_key: "author_id"

  def self.from_social_provider(provider, user_params)
    where(provider:, uid: user_params['id']).first_or_create! do |user|
      user.password = Devise.friendly_token[0, 20]
      user.assign_attributes user_params.except('id')
    end
  end

  def full_name
    return username if first_name.blank?

    "#{first_name} #{last_name}"
  end

  def case_owner?
    user_type == "case_owner"
  end

  private

  def init_uid
    self.uid = email if uid.blank? && provider == 'email'
  end

  def validate_case_owner_employment_status
    binding.pry
    unless %w(employer company unemployed).include?(employment_status)
      errors.add(:case_owner_employment_status, "must be one of 'employer', 'company', or 'unemployed'")
    end
  end
end
