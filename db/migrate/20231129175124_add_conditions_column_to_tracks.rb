class AddConditionsColumnToTracks < ActiveRecord::Migration[7.1]
  def change
    add_column :tracks, :conditions, :string, array: true, default: []

    Track.reset_column_information

    Track.find_each do |track|
      conditions = []

      # Move data from track_weather_conditions
      conditions.concat(track.track_weather_conditions.split(',')) if track.track_weather_conditions.present?

      # Move data from track_times_of_day
      conditions.concat(track.track_times_of_day.split(',')) if track.track_times_of_day.present?

      # Remove any duplicates and empty strings
      conditions = conditions.uniq.reject(&:empty?)

      track.update(conditions: conditions)
    end

    # TODO: Remove these columns in a future migration
    # remove_column :tracks, :track_weather_conditions
    # remove_column :tracks, :track_times_of_day
  end
end
