class CreateRaceParticipations < ActiveRecord::Migration[7.1]
  def change
    create_table :race_participations do |t|
      t.references :user_registration, null: false, foreign_key: true
      t.references :race, null: false, foreign_key: true
      t.integer :position # 1, 2, 3, etc.
      t.integer :points

      t.timestamps  # created_at, updated_at
    end
  end
end
