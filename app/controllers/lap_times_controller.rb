class LapTimesController < ApplicationController

  before_action :set_lap_time, only: %i[show edit update destroy]
  before_action :set_leaderboard, only: %i[new create]

  def index
    @lap_times = LapTime.all
  end

  def new
    @lap_time = LapTime.new
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
    user = User.find_by(id: params[:user_id])
    leaderboard = Leaderboard.find_by(id: params[:leaderboard_id])

    lap_time = LapTime.create(user: user, leaderboard: leaderboard, lap_time: params[:lap_time])
    redirect_to leaderboard_path(leaderboard)
  end

  def destroy
    lap_time = LapTime.find_by(id: params[:id])
    lap_time.destroy
    redirect_to leaderboard_path(lap_time.leaderboard)
  end

  private

  def lap_time_params
    params.require(:lap_time).permit(:lap_time, :user_id, :leaderboard_id)
  end

  def set_lap_time
    @lap_time = LapTime.find(params[:id])
  end
end
