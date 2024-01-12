# == Schema Information
#
# Table name: case_finances
#
#  id                  :bigint           not null, primary key
#  case_id             :integer
#  current_share_price :float
#  curency             :string
#  day_high            :float
#  day_low             :float
#  alltime_high        :float
#  alltime_low         :float
#  payout_share_pc     :float
#  total_fund_required :float
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class CaseFinance < ApplicationRecord
  belongs_to :case
end
