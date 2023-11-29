class RenameConditionsToTrackConditionsOnTracks < ActiveRecord::Migration[7.1]
  def change
    rename_column :tracks, :conditions , :track_conditions
  end
end
