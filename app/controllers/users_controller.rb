# frozen_string_literal: true

# Controller: UsersController
# Purpose:
# - Provide a controller for the User model
# - This controller handles the functionality of the User portion of the application.
# File Location:
# - app/controllers/users_controller.rb
# Tests Location:
# - test/controllers/users_controller_test.rb
class UsersController < ApplicationController
  before_action :authenticate_user!, except: %i[new index show create]
  before_action :set_user, only: %i[show edit update]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    if current_user.admin?
      @user = User.new(user_params)

      if @user.save
        redirect_to member_portal_path, notice: 'User created.'
      else
        render :new
      end
    else
      redirect_to users_path, notice: 'You are not authorized to do that.'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to @user, notice: 'User updated.'
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])

    if @user.destroy
      redirect_to users_path, notice: 'User deleted.'
    else
      redirect_to users_path, notice: 'User could not be deleted.'
    end
  end

  def admin?
    @user = User.find(params[:id])

    @user.roles.include?(User.admin)
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :gamer_tag, :admin, roles: [])
  end

  def set_user
    @user = User.find(params[:id])
  end
end
