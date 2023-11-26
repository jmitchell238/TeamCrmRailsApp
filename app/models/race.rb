class Race < ApplicationRecord
  belongs_to :round
  has_many :race_participations
  has_many :user_registrations, through: :race_participations
  belongs_to :track

  # Add validation for race_type to be either 'Heat' or 'Main'
  validates :race_type, inclusion: { in: %w[Heat Main] }

  # Logic to calculate the results of the race, update points, positions, etc.
end
