class CreateLeaderboards < ActiveRecord::Migration[7.1]
  def change
    create_table :leaderboards do |t|
      t.references :track, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :weather_condition # Weather Condition
      t.string :time_of_day # Time Of Day
      t.decimal :lap_time, null: false # User Lap Time

      t.timestamps  # created_at updated_at
    end

    add_index :leaderboards, [:track_id, :user_id, :weather_condition, :time_of_day], name: 'index_leaderboards_on_track_and_conditions', unique: true
  end
end
