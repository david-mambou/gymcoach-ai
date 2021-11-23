class WorkoutPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      record.user == user
    end
  end

  def create?
    true
  end

  def new?
    create?
  end

  def show?
    true
  end
end
