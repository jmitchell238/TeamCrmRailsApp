# frozen_string_literal: true

# == Schema Information
class Tournament < ApplicationRecord
  # Associations
  belongs_to :user
  has_many :rounds, dependent: :destroy
  has_many :user_registrations, dependent: :destroy
  has_many :registered_users, through: :user_registrations, source: :user

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

  def setup_initial_rounds
    puts 'Creating initial rounds for tournament'

    number_of_rounds.times do |round_number|
      round_date = start_date + round_number.weeks
      rounds.create!(
        tournament_id: id,
        name: "Round #{round_number + 1}",
        number: round_number + 1,
        round_date: round_date.change(hour: start_date.hour, min: start_date.min, sec: start_date.sec)
      )
    end
  end

  def previous_rounds
    rounds.where('round_date < ?', Date.today).order(:round_date)
  end

  def next_round
    round = rounds.where('round_date > ?', Date.today).order(:round_date).first
    round || rounds.order(:round_date).last
  end

  def upcoming_rounds
    rounds.where('round_date > ?', Date.today).order(:round_date)
  end

  def set_start_date_in_utc
    self.start_date = start_date.utc
  end
end
