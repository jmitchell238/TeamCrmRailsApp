class CreateRounds < ActiveRecord::Migration[7.1]
  def change
    create_table :rounds do |t|
      t.references :tournament, null: false, foreign_key: true # Foreign key to the tournament
      t.references :track, null: false, foreign_key: true # Foreign key to the track
      t.string :name # Name of the round
      t.integer :number # Number of the round

      t.timestamps # Automatically creates created_at and updated_at columns
    end
  end
end
