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
  before_action :set_tournament, only: %i[show edit update destroy]

  def index
    @tournaments = Tournament.all
  end

  def show; end

  def new
    @tournament = Tournament.new
  end

  def create
    @tournament = Tournament.new(tournament_params)
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
    params.require(:tournament).permit(:name, :description, :start_date)
  end
end
