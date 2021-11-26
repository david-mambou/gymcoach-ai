class WorkoutPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      record.user == user
    end
  end

  def create?
    true
  end

  def activate?
    true
  end

  def new?
    create?
  end

  def show?
    true
  end

  def update?
    true
  end

  def mark_finished?
    true
  end
end
