# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @user = policy_scope(User)
    @cases = Case.all.where(author_id: current_user.id) if current_user
  end
end
