# frozen_string_literal: true

# Controller: SessionsController
# Purpose:
# - Provide a controller for the Session model
# - This controller handles the functionality of the Session portion of the application.
# File Location:
# - app/controllers/sessions_controller.rb
# Tests Location:
# - test/controllers/sessions_controller_test.rb
class SessionsController < ApplicationController
  def new; end

  def create
    if (user = User.authenticate_by(email: params[:email], password: params[:password]))
      login user
      redirect_to root_path, notice: 'Logged in!'
    else
      flash.now[:alert] = 'Invalid email or password'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout current_user
    redirect_to root_url, notice: 'Logged out!'
  end
end
