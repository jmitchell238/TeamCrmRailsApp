# frozen_string_literal: true

# Controller: LapTimesController
# Purpose:
# - Provide a controller for the LapTime model
# File Location:
# - app/controllers/lap_times_controller.rb
# Tests Location:
# - test/controllers/lap_times_controller_test.rb
class LapTimesController < ApplicationController
  before_action :set_lap_time, only: %i[show edit update destroy]
  before_action :set_leaderboard, only: %i[new create]

  def index
    @lap_times = LapTime.all
  end

  def new
    @lap_time = LapTime.new
    @lap_time.user = current_user
    @lap_time.leaderboard = @leaderboard
  end

  def show
    @lap_time = LapTime.find(params[:id])
  end

  def edit
    @lap_time = LapTime.find(params[:id])
  end

  def update
    @lap_time = LapTime.find(params[:id])
    if @lap_time.update(lap_time_params)
      redirect_to @lap_time
    else
      render 'edit'
    end
  end

  def create
    @lap_time = LapTime.new(lap_time_params)

    if @lap_time.save
      redirect_to leaderboard_path(@leaderboard), notice: 'Lap time successfully created.'
    else
      render :new
    end
  end

  def destroy
    lap_time = LapTime.find(params[:id])

    authorize lap_time

    leaderboard = lap_time.leaderboard

    puts "Before destruction: #{lap_time.inspect}"
    lap_time.destroy
    puts "After destruction: #{lap_time.inspect}"

    redirect_to leaderboard_path(leaderboard), notice: 'Lap time successfully deleted.'
  rescue Pundit::NotAuthorizedError
    redirect_back(fallback_location: root_path, notice: 'You are not authorized to do that.')
  end

  private

  def lap_time_params
    params.require(:lap_time).permit(:user_id, :leaderboard_id, :lap_time)
  end

  def set_lap_time
    @lap_time = LapTime.find(params[:id])
  end

  def set_leaderboard
    @leaderboard = Leaderboard.find(params[:leaderboard_id])
  end

  def set_track
    @track = Track.find(params[:track_id])
  end
end
