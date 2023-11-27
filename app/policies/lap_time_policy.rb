class LapTimePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      end
    end
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.present?
  end

  def update?
    user.present? && (user.admin? || user.id == record.user_id)
  end

  def delete?
    user.present? && (user.admin? || user.id == record.user_id)
  end

  def destroy?
    user.present? && (user.admin? || user.id == record.user_id)
  end
end
