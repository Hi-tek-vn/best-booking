# == Schema Information
#
# Table name: payments
#
#  id             :bigint           not null, primary key
#  user_id        :integer
#  payment_type   :string
#  account_name   :string
#  card_number    :string
#  ccv            :integer
#  expiry_date    :datetime
#  account_number :string
#  bitcoin_id     :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :payment_type, primary_key: :id, foreign_key: :payment_type
end
