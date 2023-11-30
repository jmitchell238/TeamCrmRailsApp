class CreateTracks < ActiveRecord::Migration[7.1]
  def change
    create_table :tracks do |t|
      t.string :track_name
      t.string :track_type
      t.string :track_description
      t.string :track_time_of_day
      t.string :track_pack
      t.string :track_image_uri
      t.string :track_video_preview_uri
      t.string :track_weather

      t.timestamps
    end
  end
end
