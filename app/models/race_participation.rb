# frozen_string_literal: true

# == Schema Information
class RaceParticipation < ApplicationRecord
  belongs_to :user_registration
  belongs_to :race

  # Logic to calculate points based on position or other criteria
end
