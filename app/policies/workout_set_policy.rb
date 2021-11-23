class WorkoutSetPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      record.user == user
    end
  end
end
