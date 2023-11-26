class UserScoresController < ApplicationController
  before_action :set_user_score, only: %i[show edit update destroy]

  def index
    @user_scores = UserScore.all
  end

  def show
  end

  def new
    @user_score = UserScore.new
  end

  def create
    @user_score = UserScore.new(user_score_params)
    if @user_score.save
      redirect_to @user_score, notice: 'User score was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user_score.update(user_score_params)
      redirect_to @user_score, notice: 'User score was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @user_score.destroy
    redirect_to user_scores_url, notice: 'User score was successfully destroyed.'
  end

  def set_user_position
    # Assuming 'position' is passed as a parameter
    position = user_score_params[:position]
    @user_score.position = position
    @user_score.points = position_to_score(position) if position.present?

    if @user_score.save
      redirect_to @user_score.round.tournament, notice: 'User score and position were successfully updated.'
    else
      render :edit, alert: 'Unable to update user score and position.'
    end
  end

  private

  def set_user_points
    @user_score = UserScore.find(params[:id])
    @user_score.points = @user_score.round.points
  end

  def set_user_score
    @user_score = UserScore.find(params[:id])
  end

  # Make sure to white list the position parameter if needed
  def user_score_params
    params.require(:user_score).permit(:user_registration_id, :round_id, :points, :position)
  end

  def position_to_score(position)
    scores = {
      1 => 27,
      2 => 28,
      3 => 23,
      4 => 21,
      5 => 20,
      6 => 19,
      7 => 18,
      8 => 17,
      9 => 16,
      10 => 15,
      11 => 14,
      12 => 13,
      13 => 12,
      14 => 11,
      15 => 10,
      16 => 9,
      17 => 8,
      18 => 7,
      19 => 6,
      20 => 5,
      21 => 4,
      22 => 3,
      23 => 2,
      24 => 1
    }

    # Provide a default score or throw an error if the position is not recognized
    scores[position] || default_score_for_unrecognized_position
  end

  def default_score_for_unrecognized_position
    0 # Or raise an error if positions outside the defined range are not allowed
  end
end
