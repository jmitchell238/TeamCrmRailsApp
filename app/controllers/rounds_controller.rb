# frozen_string_literal: true

# Controller: RoundsController
# Purpose:
# - Provide a controller for the Round model
# - This controller handles the functionality of the Round portion of the application.
# File Location:
# - app/controllers/rounds_controller.rb
# Tests Location:
# - test/controllers/rounds_controller_test.rb
class RoundsController < ApplicationController
  before_action :set_round, only: %i[show edit update destroy]

  def index
    @rounds = Round.all
  end

  def show; end

  def new
    @round = Round.new
  end

  def create
    @round = Round.new(round_params)
    if @round.save
      redirect_to @round, notice: 'Round was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @round.update(round_params)
      redirect_to @round, notice: 'Round was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @round.destroy
    redirect_to rounds_url, notice: 'Round was successfully destroyed.'
  end

  private

  def set_round
    @round = Round.find(params[:id])
  end

  def round_params
    params.require(:round).permit(:tournament_id, :track_id, :name, :number)
  end
end
