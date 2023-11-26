# app/models/track.rb
class Track < ApplicationRecord
    # Association with Races
    has_many :races

    validates :track_name, presence: true
    validates :track_type, presence: true
    validates :track_description, presence: true
    validates :track_time_of_day, presence: true
    validates :track_pack, presence: true
    validates :track_image_uri, presence: true
    validates :track_map_uri, presence: true
    validates :track_video_preview_uri, presence: true
    validates :track_weather, presence: true
end
