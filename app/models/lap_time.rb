# frozen_string_literal: true

# == Schema Information
class LapTime < ApplicationRecord
  belongs_to :user
  belongs_to :leaderboard

  validates :lap_time, presence: true

  def formatted_lap_time=(formatted_time)
    return if formatted_time.blank?

    # Remove any non-digit characters and store as lap_time
    self.lap_time = formatted_time.gsub(/\D/, '').to_i
  end

  def formatted_lap_time
    return nil if lap_time.nil?

    lap_time_str = lap_time.to_i.to_s.rjust(6, '0') # Ensure 6 digits, pad with leading zeros if needed

    "#{lap_time_str[0..1]}:#{lap_time_str[2..3]}.#{lap_time_str[4..5]}"
  end
end
