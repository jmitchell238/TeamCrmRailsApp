class User < ApplicationRecord
    attribute :roles, :string, array: true, default: []

    has_secure_password

    validates :email, presence: true, uniqueness: true
    normalizes :email, with: ->(email) { email.strip.downcase }

    validates :gamer_tag, presence: true, uniqueness: true

    generates_token_for :password_reset, expires_in: 15.minutes do
        password_salt&.last(10)
    end

    def roles_list
        roles_except_admin = roles.reject { |role| role == 'admin' }
        roles_except_admin.each { |role| role.capitalize! }
        roles_except_admin.join(', ')
    end

    def admin?
        self.roles.include? Role.admin
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

    # generates_token_for :email_confirmation, expires_in: 24.hours do
    #   email
    # end
end
