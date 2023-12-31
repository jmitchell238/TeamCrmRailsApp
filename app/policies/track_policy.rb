class TrackPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      return unless user.admin?

      scope.all
    end
  end

  def index?
    user.present? && user.admin?
  end

  def show?
    user.present? && user.admin?
  end

  def update?
    user.present? && user.admin?
  end

  def create?
    user.present? && user.admin?
  end

  def destroy?
    user.present? && user.admin?
  end
end
