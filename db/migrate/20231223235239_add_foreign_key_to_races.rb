class AddForeignKeyToRaces < ActiveRecord::Migration[7.1]
  def change
    unless column_exists?(:races, :round_id)
      add_column :races, :round_id, :bigint, null: false
      add_foreign_key :races, :rounds
      add_index :races, :round_id
    end
  end
end
