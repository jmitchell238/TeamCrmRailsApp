class CreateTournaments < ActiveRecord::Migration[7.1]
  def change
    create_table :tournaments do |t|
      t.string :name, null: false # Name of the tournament
      t.text :description # Description of the tournament
      t.datetime :start_date, null: false # Start date of the tournament

      t.timestamps # Automatically creates created_at and updated_at columns
    end
  end
end
