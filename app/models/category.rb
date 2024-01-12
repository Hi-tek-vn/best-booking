# == Schema Information
#
# Table name: categories
#
#  id          :bigint           not null, primary key
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  is_overview :boolean          default(FALSE)
#  is_navbar   :boolean          default(FALSE)
#
# Indexes
#
#  index_categories_on_name  (name) UNIQUE
#
class Category < ApplicationRecord
  has_and_belongs_to_many :cases
  RANSACK_ATTRIBUTES = %w[name is_overview is_navbar].freeze

  scope :navbar, -> { where(is_navbar: true) }
  scope :overview, -> { where(is_overview: true) }
end
