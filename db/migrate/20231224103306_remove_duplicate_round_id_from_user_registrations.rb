class RemoveDuplicateRoundIdFromUserRegistrations < ActiveRecord::Migration[7.1]
  def change
    remove_column :user_registrations, :round_id
  end
end
