class CreateUserScores < ActiveRecord::Migration[7.1]
  def change
    create_table :user_scores do |t|
      t.references :user_registration, null: false, foreign_key: true # Foreign key to the user registration
      t.references :round, null: false, foreign_key: true # Foreign key to the round
      t.integer :points, default: 0 # Points earned by the user
      t.integer :position # Position of the user in the round

      t.timestamps  # Automatically creates created_at and updated_at columns
    end
  end
end
