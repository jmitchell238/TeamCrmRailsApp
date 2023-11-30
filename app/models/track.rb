# frozen_string_literal: true

# == Schema Information
class Track < ApplicationRecord
  # Association with Races
  has_many :races
  has_many :leaderboards, dependent: :destroy # Assuming you have a Leaderboard model
  belongs_to :user, optional: true

  validates :track_name, presence: true
  validates :track_type, presence: true
  validates :track_description, presence: true
  validates :track_pack, presence: true
  validates :track_image_uri, presence: true
  validates :track_conditions, presence: true
  validates :track_map_uri, presence: false
  validates :track_video_preview_uri, presence: false

  # Commenting these out for now because they are not being used
  # validates :track_weather_conditions, presence: true
  # validates :track_times_of_day, presence: true

  after_create :create_leaderboards_for_conditions

  # Class method to provide options for Track Type
  def self.track_type_options
    %w[supercross national]
  end

  # Class method to provide options for weather conditions
  def self.weather_conditions_options
    %w[clear rain wet]
  end

  # Class method to provide options for times of day
  def self.times_of_day_options
    %w[morning afternoon night]
  end

  # # There aren't weather Condition options and time of day Options. There are just OPTIONS
  # # Options are Morning, Afternoon, Night, Rainy
  def self.track_conditions_options
    %w[morning afternoon night rainy]
  end

  private

  def create_leaderboards_for_conditions
    track_conditions.each do |condition|
      leaderboards.create!(
        track_id: id,
        track_condition: condition,
        track_type:
      )
    end
  end
end
