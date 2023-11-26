class UserScore < ApplicationRecord
  # Associations
  belongs_to :user_registration
  belongs_to :round

  # Validations
  # Ensure that the score is always present and is an integer (you can adjust the range if necessary)
  validates :points, presence: true, numericality: { only_integer: true }

  # Unique score entry per user registration per round
  validates :user_registration_id, uniqueness: { scope: :round_id }

  # Callbacks
  # Use callbacks to manage scoring, e.g., before_save to recalculate total score if things change

  # Scopes
  # You can define scopes to make common queries succinct, like ordering by score

  # Custom methods
  # If your scoring system is complex, you might want methods to calculate and update scores
  def calculate_points
    # Logic to calculate and assign points based on some criteria, such as race positions
  end

  # A method to update user total score in tournament after each round, if needed
  def update_total_score
    # Logic to update user's total score in tournament
  end
end
