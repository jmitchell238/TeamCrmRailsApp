class Leaderboard < ApplicationRecord
  # Associations
  belongs_to :track
  belongs_to :user, optional: true

  # Validations
  validates :lap_time, :weather_condition, :time_of_day, presence: true
  validates :lap_time, numericality: { greater_than: 0 }, allow_nil: true
  validates :user_id, uniqueness: { scope: [:track_id, :weather_condition, :time_of_day] }
  validates :weather_condition, presence: true
  validates :time_of_day, presence: true

  # Scopes to filter leaderboards by track, weather condition, and time of day
  scope :for_track, ->(track_id) { where(track_id: track_id) }
  scope :for_condition, ->(weather_condition) { where(weather_condition: weather_condition) }
  scope :for_time_of_day, ->(time_of_day) { where(time_of_day: time_of_day) }
end
