class ChangeLeaderboardsUserIdToNotRequired < ActiveRecord::Migration[7.1]
  def change
    change_column_null :leaderboards, :user_id, true
  end
end
