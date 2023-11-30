class CreateRaces < ActiveRecord::Migration[7.1]
  def change
    create_table :races do |t|
      t.references :round, null: false, foreign_key: true #
      t.string :race_type, null: false # 'Heat' or 'Main'
      t.string :main_category # 'A', 'B', 'C', etc., applicable only if race_type is 'Main'
      # Add any other attributes relevant for a race

      t.timestamps # created_at, updated_at
    end
  end
end
