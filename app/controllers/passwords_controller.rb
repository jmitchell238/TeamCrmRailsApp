# frozen_string_literal: true

# Controller: PasswordsController
# Purpose:
# - Provide a controller for the Password model
# - This controller handles the functionality of the Password portion of the application.
# File Location:
# - app/controllers/passwords_controller.rb
# Tests Location:
# - test/controllers/passwords_controller_test.rb
class PasswordsController < ApplicationController
  before_action :authenticate_user!

  def edit; end

  def update
    if current_user.update(password_params)
      redirect_to edit_password_path, notice: 'Password updated!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def password_params
    params.require(:user).permit(
      :password,
      :password_confirmation,
      :password_challenge
    ).with_defaults(password_challenge: '')
  end
end
