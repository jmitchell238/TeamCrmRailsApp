class TracksController < ApplicationController
    before_action :set_track, only: [:show, :edit, :update, :destroy]

    def index
      @tracks = Track.all
    end

    def new
      @track = Track.new
    end

    def create
      if current_user.admin?
        @track = Track.new(track_params)

        if @track.save
          redirect_to tracks_path, notice: 'Track was successfully created.'
        else
          render :new
        end
      else
        redirect_to tracks_path, notice: 'You are not authorized to do that.'
      end
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

      respond_to do |format|
        format.js
      end
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
        :track_map_uri,
        :track_video_preview_uri,
        track_times_of_day: [],
        track_weather_conditions: []
        )
    end
end
