class AddUserToTournaments < ActiveRecord::Migration[7.1]
  def change
    add_reference :tournaments, :user, foreign_key: true, null: false, default: 1  end
end
