class AddRoundsAmountToTournaments < ActiveRecord::Migration[7.1]
  def change
    add_column :tournaments, :number_of_rounds, :integer
    add_column :rounds, :round_date, :datetime
  end
end
