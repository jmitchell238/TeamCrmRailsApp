# frozen_string_literal: true

# Controller: RacesController
# Purpose:
# - Provide a controller for the Race model
# Path:
# - app/controllers/races_controller.rb
# Tests Location:
# - test/controllers/races_controller_test.rb
class RacesController < ApplicationController
  before_action :set_round
  before_action :set_race, only: %i[show edit update destroy]

  # GET /rounds/:round_id/races
  def index
    @races = @round.races
  end

  # GET /rounds/:round_id/races/1
  def show
    @race = Race.find(params[:id])
  end

  # GET /rounds/:round_id/races/new
  def new
    @race = @round.races.build
  end

  # POST /rounds/:round_id/races
  def create
    @race = @round.races.build(race_params)

    if @race.save
      redirect_to [@round, @race], notice: 'Race was successfully created.'
    else
      render :new
    end
  end

  # GET /rounds/:round_id/races/1/edit
  def edit; end

  # PATCH/PUT /rounds/:round_id/races/1
  def update
    if @race.update(race_params)
      redirect_to [@round, @race], notice: 'Race was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /rounds/:round_id/races/1
  def destroy
    @race.destroy
    redirect_to round_races_url(@round), notice: 'Race was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_round
    @round = Round.find(params[:round_id])
  end

  def set_race
    @race = @round.races.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def race_params
    params.require(:race).permit(:round_id, :race_type, :main_category)
  end
end
