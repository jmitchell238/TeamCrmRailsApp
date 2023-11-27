class LeaderboardsController < ApplicationController
  before_action :set_leaderboard, only: %i[show edit update destroy]
  before_action :set_track, only: %i[new create]

  # GET /leaderboards
  def index
    @track_type_options = Track.track_type_options
    @weather_conditions_options = Track.weather_conditions_options
    @times_of_day_options = Track.times_of_day_options

    # Start with all leaderboards and progressively filter them based on provided params
    @leaderboards = Leaderboard.includes(:track)

    if params[:track_type].present?
      @leaderboards = @leaderboards.where(tracks: { track_type: params[:track_type] })
    end

    if params[:weather_condition].present?
      @leaderboards = @leaderboards.where(weather_condition: params[:weather_condition])
    end

    if params[:time_of_day].present?
      @leaderboards = @leaderboards.where(time_of_day: params[:time_of_day])
    end

    # Initialize to nil or an empty ActiveRecord::Relation if no filters are applied
    @leaderboards = @leaderboards.references(:track)

    respond_to do |format|
      format.html # index.html.erb
      format.js do
        # On AJAX request, only update the necessary instance variables if needed
        # For example, you may want to load tracks based on the selected track type
        if params[:track_type].present?
          @tracks = Track.where(track_type: params[:track_type])
        end
      end
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
      redirect_to track_leaderboards_path(@track), notice: "Leaderboard successfully created."
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

  def leaderboard_params
    params.require(:leaderboard).permit(:weather_condition, :time_of_day, :track_id)
  end
end
