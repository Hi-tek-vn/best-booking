# frozen_string_literal: true

class ApplicationController < ActionController::Base
  layout :layout_by_resource
  include Pundit::Authorization
  include ActiveStorage::SetCurrent

  after_action :verify_authorized,
               except: :index,
               unless: -> { devise_controller? || active_admin_controller? || active_admin_devise_sessions_controller? }
  after_action :verify_policy_scoped,
               only: :index,
               unless: -> { devise_controller? || active_admin_controller? }
  # Prevent CSRF attacks by raising an exception.
  before_action :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :exception

  def active_admin_controller?
    is_a?(ActiveAdmin::BaseController)
  end

  private

  private

  def active_admin_devise_sessions_controller?
    controller_path == 'active_admin/devise/sessions'
  end
  
  def layout_by_resource
    if devise_controller?
      "authentication"
    else
      "application"
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: 
    [:user_type, 
    :phone, 
    :first_name, 
    :investor_income_response, 
    :investor_net_worth_response, 
    :investor_executive_response,
    :investor_business_development_response,
    :case_owner_behalf,
    :case_owner_address,
    :employment_status,
    :case_owner_passport,
    :case_owner_dob
  ])
  end
end
