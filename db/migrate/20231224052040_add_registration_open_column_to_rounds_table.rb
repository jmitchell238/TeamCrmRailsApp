class AddRegistrationOpenColumnToRoundsTable < ActiveRecord::Migration[7.1]
  def change
    add_column :rounds, :registration_open, :boolean, default: true
    add_column :user_registrations, :round_id, :bigint
    add_foreign_key :user_registrations, :rounds


    create_table :race_sets, force: :cascade do |t|
      t.bigint "round_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      # Add other necessary columns
    end

    add_foreign_key :race_sets, :rounds

    add_column :races, :race_set_id, :bigint
    add_foreign_key :races, :race_sets
  end
end
