# app/models/role.rb
class Role
  ROLES = {
    member: 'member',
    owner: 'owner',
    manager: 'manager',
    admin: 'admin'
  }.freeze

  def self.roles
    ROLES
  end

  def self.role_values
    ROLES.values
  end

  def self.member
    ROLES[:member]
  end

  def self.owner
    ROLES[:owner]
  end

  def self.manager
    ROLES[:manager]
  end

  def self.admin
    ROLES[:admin]
  end
end
