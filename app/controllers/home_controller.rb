# frozen_string_literal: true

class HomeController < ApplicationController
  include HomeHelper

  skip_after_action :verify_policy_scoped
  before_action :set_active_tab

  def index
    @newest_cases = Case.newest
    @trending_cases = Case.trending
  end

  def new_case
    skip_authorization
    @cases = Case.newest
  end

  def trading_case
    skip_authorization
    @cases = Case.trending
  end

  private

  def set_active_tab
    @active_tab = action_name
  end
end
