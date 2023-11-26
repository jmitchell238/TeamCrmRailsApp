class AddConditionsToTracks < ActiveRecord::Migration[7.1]
  def change
    add_column :tracks, :track_weather_conditions, :string, array: true, default: []
    add_column :tracks, :track_times_of_day, :string, array: true, default: []
    remove_column :tracks, :track_weather
    remove_column :tracks, :track_time_of_day
  end
end
