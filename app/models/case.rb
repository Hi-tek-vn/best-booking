# == Schema Information
#
# Table name: cases
#
#  id                 :bigint           not null, primary key
#  case_type          :integer
#  case_relation      :integer
#  short_description  :string
#  case_description   :string
#  supporting_file    :string
#  claim_sum          :float            default(0.0)
#  total_funds        :float            default(0.0)
#  case_status        :integer
#  case_duration      :integer
#  know_defendant     :boolean
#  know_jurisdiction  :boolean
#  previous_judgement :boolean
#  legal_strategy     :boolean
#  signed_contract    :boolean
#  risk_level         :integer
#  plaintiff_payout   :integer
#  investor_payout    :integer
#  lix_payout         :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  author_id          :bigint
#
# Indexes
#
#  index_cases_on_author_id  (author_id)
#
class Case < ApplicationRecord
  CASE_TERM_AND_CONDITION = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce convallis pellentesque metus id lacinia. Nunc dapibus pulvinar auctor. Duis nec sem at orci commodo viverra id in ipsum. Fusce tellus nisl, vestibulum sed rhoncus at, pretium non libero. Cras vel lacus ut ipsum vehicula aliquam at quis urna. Nunc ac ornare ante. Fusce lobortis neque in diam vulputate quis semper sem elementum.
  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce convallis pellentesque metus id lacinia. Nunc dapibus pulvinar auctor. Duis nec sem at orci commodo viverra id in ipsum. Fusce tellus nisl, vestibulum sed rhoncus at, pretium non libero. Cras vel lacus ut ipsum vehicula aliquam at quis urna. Nunc ac ornare ante. Fusce lobortis neque in diam vulputate quis semper sem elementum.
  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce convallis pellentesque metus id lacinia. Nunc dapibus pulvinar auctor. Duis nec sem at orci commodo viverra id in ipsum. Fusce tellus nisl, "

  RANSACK_ATTRIBUTES = %w[
      case_type 
      case_relation 
      case_status 
      short_description 
      case_description 
      claim_sum
      total_funds
      case_status
      case_duration
      know_defendant
      know_jurisdiction
      previous_judgement
      legal_strategy
      signed_contract
      risk_level
      plaintiff_payout
      investor_payout
      lix_payout
      author_id
      case_finance_id
      categories_id
    ].freeze

    NON_SEARCHABLE_ATTRIBUTES = %w[supporting_file].freeze

  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_one :case_finance, required: false
  has_and_belongs_to_many :categories
  has_one_attached :supporting_file

  enum case_type: {
    commercial_litigation: 0,
    real_estate_litigation: 1,
    breach_of_contract: 2,
    shareholder_partnership_disputes: 3,
    conflict_with_intellectual_property: 4,
    personal_injury: 5,
    debt_recovery_claims: 6,
    other_type: 7
  }

  enum case_relation: {
    case_owner: 0,
    lawyer: 1,
    investigator: 2,
    accountant: 3,
    other_relation: 4
  }

  enum case_status: {
    case_started: 0,
    investigation_finished: 1,
    pleadings: 2,
    discovery: 3,
    pre_trial: 4,
    trial: 5,
    settlement: 6,
    appeal: 7,
    result_declared: 8,
    other_status: 9
  }

  after_create :update_system_calculation_and_payout

  validates :case_type, :case_relation, :case_status, presence: true
  validates :short_description, presence: true, length: { minimum: 1, maximum: 255 }
  validates :case_description, presence: true
  validates :case_duration, presence: true, numericality: { only_integer: true, greater_than: 0 }

  scope :newest, -> { includes(:categories).where(categories: { name: 'Newest' }).order(created_at: :desc) }
  scope :trending, -> { includes(:categories).where(categories: { name: 'Trending' }).order(created_at: :desc) }

  def ransackable_associations(auth_object = nil)
    Rails.logger.info("WITHIN RANSACK ASSOCIATION")
    super + %w[supporting_file]
  end

  def update_system_calculation_and_payout
    risk_level = calculate_risk_value
    set_payout_percentages(risk_level)
    save
  end

  private

  def calculate_risk_value
    [
      know_defendant,
      know_jurisdiction,
      previous_judgement,
      legal_strategy,
      signed_contract
    ].count(true)
  end

  def set_payout_percentages(risk_count)
    case risk_count
    when 0, 1
      update_columns(investor_payout: 40, plaintiff_payout: 50, lix_payout: 10, risk_level: risk_count)
    when 2, 3
      update_columns(investor_payout: 30, plaintiff_payout: 60, lix_payout: 10, risk_level: risk_count)
    when 4, 5
      update_columns(investor_payout: 20, plaintiff_payout: 70, lix_payout: 10, risk_level: risk_count)
    end
  end
end
