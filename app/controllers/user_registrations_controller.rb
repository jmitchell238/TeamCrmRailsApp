# frozen_string_literal: true

# Controller: UserRegistrationsController
# Purpose:
# - Provide a controller for the UserRegistration model
# - This controller handles the functionality of the UserRegistration portion of the application.
# File Location:
# - app/controllers/user_registrations_controller.rb
# Tests Location:
# - test/controllers/user_registrations_controller_test.rb
class UserRegistrationsController < ApplicationController
  def create
    @tournament = Tournament.find(params[:tournament_id])
    @user_registration = @tournament.user_registrations.new(user: current_user)

    if @user_registration.save
      redirect_to @tournament, notice: 'Thank you for registering!'
    else
      redirect_to @tournament, alert: 'Unable to register.'
    end
  end

  def destroy
    @user_registration = UserRegistration.find(params[:id])
    @user_registration.destroy
    redirect_to tournaments_url, notice: 'You have been unregistered.'
  end

  # No new or edit actions, as registrations are succinct operations
end
