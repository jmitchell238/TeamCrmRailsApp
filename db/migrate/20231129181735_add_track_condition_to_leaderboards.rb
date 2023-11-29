class AddTrackConditionToLeaderboards < ActiveRecord::Migration[7.1]
  def change
    add_column :leaderboards, :track_condition, :string
  end
end
