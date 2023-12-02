class RemoveTrackWeatherConditionsFromTracks < ActiveRecord::Migration[7.1]
  def change
    remove_column :tracks, :track_weather_conditions, :string
    remove_column :tracks, :track_times_of_day, :string
  end
end
