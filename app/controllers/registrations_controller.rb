# frozen_string_literal: true

# Controller: RegistrationsController
# Purpose:
# - Provide a controller for the User model
# - This controller handles the functionality of the User portion of the application.
# File Location:
# - app/controllers/registrations_controller.rb
# Tests Location:
# - test/controllers/registrations_controller_test.rb
class RegistrationsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(registration_params)
    if @user.save
      login @user
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def registration_params
    params.require(:user).permit(:email, :gamer_tag, :password, :password_confirmation)
  end
end
