class AddTrackTypeToLeaderboards < ActiveRecord::Migration[7.1]
  def change
    add_column :leaderboards, :track_type, :string
  end
end
