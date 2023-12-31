# frozen_string_literal: true

# Controller: LeaderboardsController
# Purpose:
# - Provide a controller for the Leaderboard model
# - This controller handles the functionality of the Leaderboard portion of the application.
# File Location:
# - app/controllers/leaderboards_controller.rb
# Tests Location:
# - test/controllers/leaderboards_controller_test.rb
class LeaderboardsController < ApplicationController
  before_action :set_leaderboard, only: %i[show edit update destroy]
  before_action :set_track, only: %i[new create]

  # GET /leaderboards
  def index
    @leaderboards = Leaderboard.where(leaderboard_params)
  end

  # Example method to fetch tracks based on track_type
  def tracks_by_type
    if params[:track_type]
      @tracks = Track.where(track_type: params[:track_type])
    else
      @tracks = Track.none
    end

    respond_to(&:turbo_stream)
  end

  # GET /leaderboards_by_track_type
  def leaderboards_by_track_type
    if params[:track_type]
      @_track_type = params[:track_type]
      @leaderboards = Leaderboard.where(track_type: @_track_type)
      @track_names = @leaderboards.distinct.pluck(:track_name)
    else
      # Handle the case when track_type is not provided
      @track_names = [] # or any default value you prefer
    end

    respond_to(&:turbo_stream)
  end

  # GET /leaderboards_by_track
  def leaderboards_by_track
    # Lookup and send back the leaderboards for the given track_id
    @leaderboards = Leaderboard.where(track_name: params[:track_name])

    respond_to(&:turbo_stream)
  end

  # GET /track_leaderboards_by_track_condition
  def track_leaderboards_by_track_condition
    @leaderboards = Leaderboard.where(track_name: params[:track_name], track_condition: params[:track_condition])
    @leaderboard = @leaderboards.first
    puts @leaderboard.inspect

    respond_to do |format|
      format.turbo_stream
    end
  end

  # GET /tracks/:track_id/leaderboards/new
  def new
    @leaderboard = Leaderboard.new
  end

  # POST /tracks/:track_id/leaderboards
  def create
    @leaderboard = Leaderboard.new(leaderboard_params)
    if @leaderboard.save
      redirect_to track_leaderboards_path(@track), notice: 'Leaderboard successfully created.'
    else
      render :new
    end
  end

  # Implement other actions (show, edit, update, destroy) as needed
  # GET /tracks/:track_id/leaderboards/:id
  def show
    @leaderboard = Leaderboard.find(params[:id])

    # @lap_times = @leaderboard.lap_times.order(lap_time: :asc) # THIS WORKS TO SHOW ALL LAP TIMES

    @lap_times = @leaderboard.lap_times.select('DISTINCT ON (user_id) lap_times.*').order('user_id, lap_time ASC')
  end

  def edit
    @leaderboard = Leaderboard.find(params[:id])
  end

  def update
    @leaderboard = Leaderboard.find(params[:id])
    if @leaderboard.update(leaderboard_params)
      redirect_to @leaderboard
    else
      render 'edit'
    end
  end

  def destroy
    @leaderboard = Leaderboard.find(params[:id])
    @leaderboard.destroy
    redirect_to leaderboards_path
  end

  private

  def set_leaderboard
    @leaderboard = Leaderboard.find(params[:id])
  end

  def set_track
    @track = Track.find(params[:track_id])
  end

  def track_params
    params.permit(:track_type, :track_name, :track_id, :track_condition)
  end

  def leaderboard_params
    params.permit(:track_id, :track_name, :track_condition, :track_type)
  end
end
