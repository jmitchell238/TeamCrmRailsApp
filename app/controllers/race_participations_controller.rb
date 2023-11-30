# frozen_string_literal: true

# Controller: RaceParticipationsController
# Purpose:
# - Provide a controller for RaceParticipations model
# - This controller handles the functionality of the RaceParticipation portion of the application.
# File Location:
# - app/controllers/race_participations_controller.rb
# Tests Location:
# - test/controllers/race_participations_controller_test.rb
class RaceParticipationsController < ApplicationController
  before_action :set_race
  before_action :set_race_participation, only: %i[show edit update destroy]

  # GET /races/:race_id/race_participations
  def index
    @race_participations = @race.race_participations
  end

  # GET /races/:race_id/race_participations/1
  def show; end

  # GET /races/:race_id/race_participations/new
  def new
    @race_participation = @race.race_participations.build
  end

  # POST /races/:race_id/race_participations
  def create
    @race_participation = @race.race_participations.build(race_participation_params)

    if @race_participation.save
      redirect_to [@race, @race_participation], notice: 'Race participation was successfully created.'
    else
      render :new
    end
  end

  # GET /races/:race_id/race_participations/1/edit
  def edit; end

  # PATCH/PUT /races/:race_id/race_participations/1
  def update
    if @race_participation.update(race_participation_params)
      redirect_to [@race, @race_participation], notice: 'Race participation was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /races/:race_id/race_participations/1
  def destroy
    @race_participation.destroy
    redirect_to race_race_participations_url(@race), notice: 'Race participation was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_race
    @race = Race.find(params[:race_id])
  end

  def set_race_participation
    @race_participation = @race.race_participations.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def race_participation_params
    params.require(:race_participation).permit(:user_registration_id, :race_id, :position, :points)
  end
end
