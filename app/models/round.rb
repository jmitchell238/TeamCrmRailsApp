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
  # after_create :create_initial_races
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

  # def create_initial_races
  #   # Your logic to create initial races for the round goes here
  #   # For example:
  #   (1..number_of_races).each do |race_number|
  #     races.create(number: race_number, name: "Race #{race_number}")
  #   end
  # end
end
