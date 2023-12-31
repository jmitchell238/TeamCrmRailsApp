# frozen_string_literal: true

# Controller: ApplicationController
# Purpose:
# - Provide a base class for all controllers in the application
# File Location:
# - app/controllers/application_controller.rb
# Tests Location:
# - test/controllers/application_controller_test.rb
class ApplicationController < ActionController::Base
  include Pundit::Authorization

  private

  def authenticate_user!
    redirect_to root_path, alert: 'You must be signed in to do that.' unless user_signed_in?
  end

  def current_user
    Current.user ||= authenticate_user_from_session
  end
  helper_method :current_user

  def authenticate_user_from_session
    User.find_by(id: session[:user_id])
  end

  def user_signed_in?
    current_user.present?
  end
  helper_method :user_signed_in?

  def user_is_admin?
    current_user.admin?
  end
  helper_method :user_is_admin?

  def login(user)
    Current.user = user
    reset_session
    session[:user_id] = user.id
  end

  def logout(_user)
    Current.user = nil
    reset_session
  end
end
