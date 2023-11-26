class LeaderboardsController < ApplicationController
  before_action :set_leaderboard, only: %i[show edit update destroy]

  # GET /leaderboards
  def index
    # You can filter leaderboards by track type, weather, and time of day using query parameters
    @leaderboards = Leaderboard.includes(:track).order('tracks.track_type', :lap_time)

    if params[:track_type].present?
      @leaderboards = @leaderboards.joins(:track).where('tracks.track_type = ?', params[:track_type])
    end

    if params[:weather_condition].present?
      @leaderboards = @leaderboards.where(weather_condition: params[:weather_condition])
    end

    if params[:time_of_day].present?
      @leaderboards = @leaderboards.where(time_of_day: params[:time_of_day])
    end
  end

  # POST /tracks/:track_id/leaderboards
  def create
    @leaderboard = Leaderboard.new(leaderboard_params.merge(track_id: params[:track_id], user: current_user))

    if @leaderboard.save
      redirect_to track_leaderboards_path(@leaderboard.track), notice: "Your lap time has been successfully submitted."
    else
      # Handle re-rendering the form with errors or providing feedback to the user.
    end
  end

  # Implement other actions (show, edit, update, destroy) as needed

  private

  def set_leaderboard
    @leaderboard = Leaderboard.find(params[:id])
  end

  def leaderboard_params
    params.require(:leaderboard).permit(:weather_condition, :time_of_day, :lap_time)
  end
end
