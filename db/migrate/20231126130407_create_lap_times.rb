class CreateLapTimes < ActiveRecord::Migration[7.1]
  def change
    create_table :lap_times do |t|
      t.references :user, null: false, foreign_key: true
      t.references :leaderboard, null: false, foreign_key: true
      t.decimal :lap_time

      t.timestamps
    end
  end
end
