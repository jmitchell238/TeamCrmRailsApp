# frozen_string_literal: true

# == Schema Information
class User < ApplicationRecord
  has_many :owned_tournaments, class_name: 'Tournament', foreign_key: 'user_id', dependent: :destroy
  has_many :user_registrations, dependent: :destroy
  has_many :registered_tournaments, through: :user_registrations, source: :tournament
  has_many :race_participations, through: :user_registrations
  has_many :races, through: :race_participations
  attribute :roles, :string, array: true, default: []
  validates :email, presence: true, uniqueness: true
  validates :gamer_tag, presence: true, uniqueness: true

  normalizes :email, with: ->(email) { email.strip.downcase }
  has_secure_password

  generates_token_for :password_reset, expires_in: 15.minutes do
    password_salt&.last(10)
  end

  def roles_list
    roles_except_admin = roles.reject { |role| role == 'admin' }
    roles_except_admin.each { |role| role.capitalize! }
    roles_except_admin.join(', ')
  end

  def admin?
    roles.include? Role.admin
  end

  # Add a method to add roles to a user
  def add_roles(*new_roles)
    self.roles ||= [] # Initialize the roles array if it's nil
    self.roles |= new_roles.map(&:to_s) # Combine the existing roles with the new roles
  end

  # Add a method to remove roles from a user
  def remove_roles(*old_roles)
    self.roles -= old_roles.map(&:to_s) # Remove the specified roles from the array
  end

  def time_zone
    ActiveSupport::TimeZone[user_time_zone] || 'UTC'
  end

  def time_zone_offset
    ActiveSupport::TimeZone[time_zone].formatted_offset
  end

  def registered_for_round?(round)
    user_registrations.exists?(round:)
  end

  # generates_token_for :email_confirmation, expires_in: 24.hours do
  #   email
  # end
end
