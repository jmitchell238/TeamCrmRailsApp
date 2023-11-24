class TracksController < ApplicationController
    before_action :set_track, only: [:show, :edit, :update, :destroy]
  
    def index
      @tracks = Track.all
    end
  
    def new
      @track = Track.new
    end
  
    def create
      @track = Track.new(track_params)
  
      if @track.save
        redirect_to tracks_path, notice: 'Track was successfully created.'
      else
        render :new
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
        if @track.update(track_params)
          redirect_to tracks_path, notice: 'Track was successfully updated.'
        else
          render :edit
        end
    end


    def destroy
        @track = Track.find(params[:id])
        @track.destroy

        redirect_to tracks_path, notice: 'Track was successfully deleted.'
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
        :track_time_of_day, 
        :track_pack, 
        :track_image_uri,
        :track_map_uri, 
        :track_video_preview_uri, 
        :track_weather
        )
    end
end
  