class Tournament < ApplicationRecord
  # Associations
  has_many :rounds, dependent: :destroy
  has_many :user_registrations, dependent: :destroy
  has_many :users, through: :user_registrations

  # Validations
  validates :name, presence: true
  validates :start_date, presence: true

  # Callbacks
  after_create :setup_initial_rounds
  # You might have callbacks to automatically set up rounds when a tournament is created.

  # Scopes
  scope :upcoming, -> { where('start_date > ?', Date.today) }
  # You can define scopes for common queries related to tournaments.

  # Custom methods
  def register_user(user)
    # Logic to register a user for the tournament
  end

end
