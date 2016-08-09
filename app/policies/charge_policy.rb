class ChargePolicy < ApplicationPolicy
  
  def create
    user.standard?
  end
  
end
