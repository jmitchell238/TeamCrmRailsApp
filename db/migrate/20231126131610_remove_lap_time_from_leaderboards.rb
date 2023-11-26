# db/migrate/xxxxxxxxxx_remove_lap_time_from_leaderboards.rb
class RemoveLapTimeFromLeaderboards < ActiveRecord::Migration[7.1]
  def change
    remove_column :leaderboards, :lap_time, :decimal, null: false
  end
end
