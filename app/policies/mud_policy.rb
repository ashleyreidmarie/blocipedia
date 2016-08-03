class MudPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user && user.admin?
        scope.all
      else
        scope.approved
      end
    end
  end
  
  def create?
    user
  end
  
  def update?
    user.admin?
  end
  
  def destroy?
    user.admin?
  end
  
  def dashboard?
    user.admin?
  end
  
  def approval?
    user.admin?
  end
  
end
