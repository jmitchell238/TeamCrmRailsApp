class MakeRoundDateNotNullableAndNumberOfRoundsNotNullable < ActiveRecord::Migration[7.1]
  def change
    change_column_null :rounds, :round_date, false
    change_column_null :tournaments, :number_of_rounds, false
  end
end
