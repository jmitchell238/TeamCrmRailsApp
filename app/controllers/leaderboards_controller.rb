class LeaderboardsController < ApplicationController
  before_action :set_leaderboard, only: %i[show edit update destroy]
  before_action :set_track, only: %i[new create]

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

# GET /tracks/:track_id/leaderboards/new
def new
  @leaderboard = Leaderboard.new
end

# POST /tracks/:track_id/leaderboards
def create
  @leaderboard = @track.leaderboards.build(leaderboard_params.merge(user: current_user))
  if @leaderboard.save
    redirect_to track_leaderboards_path(@track), notice: "Lap time successfully submitted."
  else
    render :new
  end
end

  # Implement other actions (show, edit, update, destroy) as needed

  def show
    @leaderboard = Leaderboard.find(params[:id])
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

  def leaderboard_params
    params.require(:leaderboard).permit(:weather_condition, :time_of_day, :lap_time)
  end
end
