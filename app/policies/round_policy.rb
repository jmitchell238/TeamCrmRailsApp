# frozen_string_literal: true

class RoundPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      return unless user.admin?

      scope.all
    end
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