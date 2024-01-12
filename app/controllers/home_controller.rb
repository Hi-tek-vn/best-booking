# frozen_string_literal: true

class HomeController < ApplicationController
  skip_after_action :verify_policy_scoped

  def index
    @newest_cases = Case.newest
    @trending_cases = Case.trending
  end
end
  