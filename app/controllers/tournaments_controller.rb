# frozen_string_literal: true

# Controller: TournamentsController
# Purpose:
# - Provide a controller for the Tournament model
# - This controller handles the functionality of the Tournament portion of the application.
# File Location:
# - app/controllers/tournaments_controller.rb
# Tests Location:
# - test/controllers/tournaments_controller_test.rb
class TournamentsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_tournament, only: %i[show edit update destroy]

  def index
    @tournaments = Tournament.all
    @user_time_zone = cookies[:user_time_zone] || 'UTC'
  end

  def show
    @tournament = Tournament.find(params[:id])
    @user_time_zone = Time.find_zone(cookies[:user_time_zone]) || 'UTC'  end

  def new
    @tournament = Tournament.new
    @tournament.user_id = current_user.id
    @user_time_zone = cookies[:user_time_zone] || 'UTC'
  end

  def create
    @tournament = Tournament.new(tournament_params)
    @tournament.user_id = current_user.id
    puts "Start Date before save: #{params[:tournament][:start_date].to_datetime}"
    @tournament.start_date = params[:tournament][:start_date].in_time_zone(cookies[:user_time_zone] || 'UTC')
    puts "Start Date after save: #{@tournament.start_date}"
    if @tournament.save
      redirect_to @tournament, notice: 'Tournament was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @tournament.update(tournament_params)
      redirect_to @tournament, notice: 'Tournament was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @tournament.destroy
    redirect_to tournaments_url, notice: 'Tournament was successfully destroyed.'
  end

  private

  def set_tournament
    @tournament = Tournament.find(params[:id])
  end

  def tournament_params
    params.require(:tournament).permit(:name, :description, :start_date, :number_of_rounds, :user_id)
  end
end
