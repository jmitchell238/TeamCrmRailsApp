class Leaderboard < ApplicationRecord
  # Associations
  belongs_to :track
  belongs_to :user

  # Validations
  validates :lap_time, presence: true, numericality: { greater_than: 0 }
  validates :user_id, uniqueness: { scope: [:track_id, :weather_condition, :time_of_day] }
  validates :weather_condition, presence: true
  validates :time_of_day, presence: true

  # Scopes to filter leaderboards by track, weather condition, and time of day
  scope :for_track, ->(track_id) { where(track_id: track_id) }
  scope :for_condition, ->(weather_condition) { where(weather_condition: weather_condition) }
  scope :for_time_of_day, ->(time_of_day) { where(time_of_day: time_of_day) }
end
