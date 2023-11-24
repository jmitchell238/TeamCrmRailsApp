class AddTrackMapUriToTracks < ActiveRecord::Migration[7.1]
  def change
    add_column :tracks, :track_map_uri, :string
  end
end
