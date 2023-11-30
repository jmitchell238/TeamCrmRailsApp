# frozen_string_literal: true

# == Schema Information
class Round < ApplicationRecord
  # Associations
  belongs_to :tournament
  has_many :races, dependent: :destroy
  # If you're keeping track of scores for each round, then you might want a:
  has_many :user_scores

  # Validations
  validates :name, presence: true
  # Add any validations needed for rounds here.

  # Callbacks
  after_create :create_initial_races
  # You might have callbacks to automatically create races when a round is created.

  # Scopes
  scope :completed, -> { where(completed: true) }
  # You can define scopes for common queries related to rounds.

  # Custom methods
  def create_race(attributes)
    # Logic to create a race associated with this round.
  end

  def calculate_scores
    # Logic to calculate and update scores after races are finished.
  end
end
