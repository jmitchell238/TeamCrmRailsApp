# db/migrate/<timestamp>_remove_user_id_from_leaderboards.rb
class RemoveUserIdFromLeaderboards < ActiveRecord::Migration[7.1]
  def change
    remove_column :leaderboards, :user_id
  end
end
