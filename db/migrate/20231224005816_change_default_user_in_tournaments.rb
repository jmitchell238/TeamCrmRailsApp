class ChangeDefaultUserInTournaments < ActiveRecord::Migration[7.1]
  def change
    change_column_default :tournaments, :user_id, nil
  end
end
