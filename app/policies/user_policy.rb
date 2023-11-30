class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      return unless user.admin?

      scope.all
    end
  end

  def edit?
    user.present? && (user.admin? || user.id == record.id)
  end

  def update?
    user.present? && (user.admin? || user.id == record.id)
  end

  def destroy?
    user.present? && (user.admin? || user.id == record.id)
  end
end
