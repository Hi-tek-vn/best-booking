# == Schema Information
#
# Table name: currencies
#
#  id         :bigint           not null, primary key
#  code       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Currency < ApplicationRecord
end
