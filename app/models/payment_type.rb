# == Schema Information
#
# Table name: payment_types
#
#  id         :bigint           not null, primary key
#  type       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class PaymentType < ApplicationRecord
  has_many :payments
end
