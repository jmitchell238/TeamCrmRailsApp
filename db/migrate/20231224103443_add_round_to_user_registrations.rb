class AddRoundToUserRegistrations < ActiveRecord::Migration[7.1]
  def change
    add_reference :user_registrations, :round, foreign_key: true
  end
end
