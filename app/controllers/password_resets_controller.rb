# frozen_string_literal: true

# Controller: PasswordResetsController
# Purpose:
# - Provide a controller for the PasswordResets model
# - This controller handles the functionality of the PasswordReset portion of the application.
# File Location:
# - app/controllers/password_resets_controller.rb
# Tests Location:
# - test/controllers/password_resets_controller_test.rb
class PasswordResetsController < ApplicationController
  before_action :set_user_by_token, only: %i[edit update]
  before_action :user_not_signed_in!, only: %i[new create]

  def new; end

  def create
    if (user = User.find_by(email: params[:email]))
      PasswordMailer.with(
        user:,
        token: user.generate_token_for(:password_reset)
      ).password_reset.deliver_later
    end

    redirect_to root_path, notice: 'Check your email to reset your password.'
  end

  def edit; end

  def update
    if @user.update(password_params)
      redirect_to new_session_path, notice: 'Password Reset Successful. Please sign in.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def set_user_by_token
    @user = User.find_by_token_for(:password_reset, params[:token])
    redirect_to new_password_reset_path alert: 'Invalid Token. Please try again.' unless @user.present?
  end

  def user_not_signed_in!
    redirect_to root_path, alert: 'You must be signed out to do that.' if user_signed_in?
  end
end
