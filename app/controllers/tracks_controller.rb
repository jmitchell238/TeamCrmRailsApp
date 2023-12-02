# frozen_string_literal: true

# Controller: TracksController
# Purpose:
# - Provide a controller for the Track model
# - This controller handles the functionality of the Track portion of the application.
# File Location:
# - app/controllers/tracks_controller.rb
# Tests Location:
# - test/controllers/tracks_controller_test.rb
class TracksController < ApplicationController
  before_action :set_track, only: %i[show edit update destroy]

  def index
    @tracks = Track.all
  end

  def new
    @track = Track.new
    # @track.track_image_uri ||= "https://p.vitalmx.com/photos/features/8007/title_image/s1600_legends_copy_577031.jpg"
  end

  # @return [nil]
  def create
    authorize Track.new
    @track = Track.new(track_params)

    if @track.save
      redirect_to tracks_path, notice: 'Track was successfully created.'
    else
      @errors = @track.errors.full_messages
      puts @errors.inspect
      render :new
    end

  rescue Pundit::NotAuthorizedError
    redirect_back(fallback_location: root_path, notice: 'You are not authorized to do that.')
  end

  def show
    @track = Track.find(params[:id])
  end

  def edit
    @track = Track.find(params[:id])
  end

  def update
    @track = Track.find(params[:id])
    authorize @track
    if @track.update(track_params)
      redirect_to track_path(@track), notice: 'Track was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @track = Track.find(params[:id])
    @track.destroy

    redirect_to tracks_path, notice: 'Track was successfully deleted.'
  end

  def fetch_names(track_type)
    @tracks = Track.find_by(track_type: params[track_type])

    respond_to(&:js)
  end

  private

  def set_track
    @track = Track.find(params[:id])
  end

  def track_params
    params.require(:track).permit(
      :track_name,
      :track_type,
      :track_description,
      :track_pack,
      :track_image_uri,
      track_conditions: []
    )
  end
end
