class CreateUserRegistrations < ActiveRecord::Migration[7.1]
  def change
    create_table :user_registrations do |t|
      t.references :user, null: false, foreign_key: true  # Foreign key to the user
      t.references :tournament, null: false, foreign_key: true  # Foreign key to the tournament

      t.timestamps  # Automatically creates created_at and updated_at columns
    end
    add_index :user_registrations, [:user_id, :tournament_id], unique: true # Ensures that a user can only register once for a tournament
  end
end
