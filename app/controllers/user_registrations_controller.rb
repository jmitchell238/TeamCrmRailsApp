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
  before_action :authenticate_user!
  before_action :set_user_registration, only: %i[show edit update destroy]

  def index
    @user_registrations = UserRegistration.all
  end

  def show
    @user_registration = UserRegistration.find(params[:id])
  end

  def edit
    @user_registration = UserRegistration.find(params[:id])
  end

  def update
    @user_registration = UserRegistration.find(params[:id])

    if @user_registration.update(user_registration_params)
      redirect_to @user_registration, notice: 'User registration updated.'
    else
      render :edit
    end
  end

  def new
    @user_registration = UserRegistration.new
  end

  def create
    if params[:round_id].nil? && params[:tournament_id].nil?
      redirect_to tournaments_url, alert: 'Unable to register.'
    end

    if params[:round_id].exists? && params[:tournament_id].exists?
      @round = Round.find(params[:round_id])
      @tournament = Tournament.find(params[:tournament_id])
      @user_registration = @round.user_registrations.new(user: current_user)

      unless @tournament.user_registrations.where(user: current_user).exists?
        @user_registration = @tournament.user_registrations.new(user: current_user)
      end

      if @user_registration.save
        redirect_to @round, notice: 'Thank you for registering!'
      else
        redirect_to @round, alert: 'Unable to register.'
      end
    end

    unless params[:tournament_id].nil?
      @tournament = Tournament.find(params[:tournament_id])
      @user_registration = @tournament.user_registrations.new(user: current_user)

      if @user_registration.save
        redirect_to @tournament, notice: 'Thank you for registering!'
      else
        redirect_to @tournament, alert: 'Unable to register.'
      end
    end
  end

  def destroy
    @user_registration = UserRegistration.find(params[:id])
    @user_registration.destroy
    redirect_to tournaments_url, notice: 'You have been unregistered.'
  end


  def user_registration_params
    params.require(:user_registration).permit(:tournament_id, :round_id, :user_id)
  end

  def set_user_registration
    @user_registration = UserRegistration.find(params[:id])
  end
end
