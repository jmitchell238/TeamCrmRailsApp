# app/models/track.rb
class Track < ApplicationRecord
    # Association with Races
    has_many :races
    has_many :leaderboards, dependent: :destroy # Assuming you have a Leaderboard model
    belongs_to :user, optional: true

    validates :track_name, presence: true
    validates :track_type, presence: true
    validates :track_description, presence: true
    validates :track_pack, presence: true
    validates :track_image_uri, presence: true
    validates :track_map_uri, presence: true
    validates :track_video_preview_uri, presence: true
    validates :track_weather_conditions, presence: true
    validates :track_times_of_day, presence: true

    after_create :create_leaderboards_for_conditions

   # Class method to provide options for weather conditions
    def self.weather_conditions_options
        ['Clear', 'Rain', 'Wet']
    end

    # Class method to provide options for times of day
    def self.times_of_day_options
        ['Morning', 'Noon', 'Evening', 'Night']
    end

    # Class method to provide options for Track Type
    def self.track_type_options
      ['Supercross', 'Motocross', 'Enduro', 'Freestyle', 'Other']
    end

    private

    def create_leaderboards_for_conditions
        track_times_of_day.each do |time|
          track_weather_conditions.each do |weather|
            leaderboards.create!(
              track_id: id,
              weather_condition: weather,
              time_of_day: time
              # User and lap_time are not assigned here; they will be populated when a user submits a time.
            )
          end
        end
    end

end
