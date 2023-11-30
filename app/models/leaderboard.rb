# frozen_string_literal: true

# == Schema Information
class Leaderboard < ApplicationRecord
  # Associations
  belongs_to :track
  has_many :lap_times, dependent: :destroy

  # Validations
  validates :weather_condition, presence: false
  validates :time_of_day, presence: false
  validates :track_condition, presence: true
  validates :track_type, presence: true
  validates :track_name, presence: true

  # Scopes to filter leaderboards by track, track type, track condition
  scope :for_track, ->(track_id) { where(track_id:) }
  scope :for_track_type, ->(track_type) { where(track_type:) }
  scope :for_track_name, ->(track_name) { where(track_name:) }
  scope :for_track_condition, ->(track_condition) { where(track_condition:) }
  # scope :for_condition, ->(weather_condition) { where(weather_condition: weather_condition) }
  # scope :for_time_of_day, ->(time_of_day) { where(time_of_day: time_of_day) }
end
