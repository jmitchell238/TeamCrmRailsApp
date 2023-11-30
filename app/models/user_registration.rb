# frozen_string_literal: true

# == Schema Information
class UserRegistration < ApplicationRecord
  belongs_to :user
  belongs_to :tournament
  has_many :race_participations

  # ...
  def self.register(params)
    # ...
    user = User.new(params)
    user.save!
    # ...
  end
end
