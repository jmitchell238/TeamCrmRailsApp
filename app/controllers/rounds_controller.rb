# frozen_string_literal: true

# Controller: RoundsController
# Purpose:
# - Provide a controller for the Round model
# - This controller handles the functionality of the Round portion of the application.
# File Location:
# - app/controllers/rounds_controller.rb
# Tests Location:
# - test/controllers/rounds_controller_test.rb
class RoundsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tournament, only: %i[show register unregister remove_user_registration]
  before_action :set_round, only: %i[show edit update destroy register unregister remove_user_registration]


  def index
    @rounds = Round.all
    @user_time_zone = Time.find_zone(cookies[:user_time_zone]) || 'UTC'
  end

  def show
    @round = Round.find(params[:id])
    @track = Track.find(@round.track_id) if @round.track_id
    @tournament = Tournament.find(@round.tournament_id)
    @user_time_zone = Time.find_zone(cookies[:user_time_zone]) || 'UTC'
  end

  def new
    @round = Round.new
    @user_time_zone = Time.find_zone(cookies[:user_time_zone]) || 'UTC'
  end

  def create
    @round = Round.new(round_params)
    @user_time_zone = Time.find_zone(cookies[:user_time_zone]) || 'UTC'
    if @round.save
      redirect_to @round, notice: 'Round was successfully created.'
    else
      render :new
    end
  end

  def edit
    @round = Round.find(params[:id])
    @user_time_zone = Time.find_zone(cookies[:user_time_zone]) || 'UTC'
  end

  def update
    @round = Round.find(params[:id])

    if @round.update(round_params)
      redirect_to @round, notice: 'Round was successfully updated.'
    else
      render :edit
    end
  end

  def update_registration_status
    @round = Round.find(params[:id])
    registration_status = params[:registration_status] == 'true'

    @round.registration_open = registration_status
    @round.save

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @round.destroy
    redirect_to rounds_url, notice: 'Round was successfully destroyed.'
  end

  def round_registrations
    @round = Round.find(params[:id])
    @tournament = Tournament.find(@round.tournament_id)
    @registrations = UserRegistration.where(round_id: @round.id)
  end

  def round_datetime_format(datetime)
    datetime.in_time_zone(@user_time_zone).strftime('%B %e, %Y - Time: %l:%M %p %Z')
  end
  helper_method :round_datetime_format

  def round_date_format(datetime)
    datetime.in_time_zone(@user_time_zone).strftime('%B %e, %Y')
  end
  helper_method :round_date_format

  def round_time_format(datetime)
    datetime.in_time_zone(@user_time_zone).strftime('%l:%M %p %Z')
  end
  helper_method :round_time_format

  def register
    # Find or create a user registration for the current user and the round
    @user_registration = current_user.user_registrations.new(round: @round, tournament: @tournament)

    if @user_registration.save
      # Registration successful
      redirect_to round_path(@round), notice: 'Successfully registered for the round.'
    else
      # Registration failed
      # Check the flash message for errors
      flash[:alert] = 'Registration failed. ' + @user_registration.errors.full_messages.join(', ')
      redirect_to round_path(@round)
    end
  end

  def unregister
    @user_registration = current_user.user_registrations.find_by(round: @round)

    if @user_registration&.destroy
      redirect_to @round, notice: 'Successfully unregistered from the round.'
    else
      redirect_to @round, alert: 'Unregistration failed.'
    end
  end

  def remove_user_registration
    @user_registration = UserRegistration.find(params[:user_registration_id])

    if @user_registration.destroy
      redirect_to tournament_round_path(@tournament, @round), notice: 'User removed from registration.'
    else
      redirect_to tournament_round_path(@tournament, @round), alert: 'Failed to remove user from registration.'
    end
  end

  private

  def set_tournament
    @tournament = Tournament.find(params[:tournament_id])
  end

  def set_round
    @round = Round.find(params[:id])
  end

  def round_params
    params.require(:round).permit(:tournament_id, :track_id, :name, :number, :round_date, :registration_open)
  end
end
