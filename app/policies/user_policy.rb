class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      end
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
