class AddTrackNameToLeaderboards < ActiveRecord::Migration[7.1]
  def change
    add_column :leaderboards, :track_name, :string
  end
end
