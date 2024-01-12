class CasePolicy < ApplicationPolicy
  def create?
    user.present?
  end
end