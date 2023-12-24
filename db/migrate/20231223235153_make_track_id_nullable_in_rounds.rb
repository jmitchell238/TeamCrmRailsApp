class MakeTrackIdNullableInRounds < ActiveRecord::Migration[7.1]
  def change
    change_column :rounds, :track_id, :bigint, null: true
  end
end
