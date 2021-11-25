class MessagePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      record.user == user
    end
  end

  def new?
    true 
  end

  def create?
    true
  end
end
