class WikiPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.present? && user.admin?
        scope.all
      elsif user.present?
        scope.where('private = ? OR user_id = ?', false, user.id)
      else
        scope.where(private: false)
      end
    end
  end
  
  def show?
    if user.present? && (user.admin? || record.user == user)
      true
    else
      record.private == false
    end
  end
  
  def create?
    user.present?
  end
  
  def update?
    user.admin? || record.user == user if user.present?
  end
  
  def destroy?
    user.admin? || record.user == user if user.present?
  end  

  #allow admin users, users who own a wiki and are premium who are updating, 
  #and users who are premium who are creating to see Private Wiki checkbox
  def make_private_for?(action)
    case action
    when "new"
      user.admin? || user.premium?
    when "create"
      user.admin? || user.premium?
    when "edit"
      user.admin? || ( record.user == user && user.premium? )
    when "update"
      user.admin? || ( record.user == user && user.premium? )
    end
  end
  
  #allow admin users, users who own a wiki and are premium who are updating, 
  #and users who are premium who are creating to use the :private param  
  def permitted_params_for(action)
    premium_params = [:name, :description, :mud_id, :private]
    standard_params = [:name, :description, :mud_id]

    case action
      when "create"
      if user.admin? || user.premium?
        premium_params
      else
        standard_params
      end
    when "update"
      if user.admin? || ( record.user == user && user.premium? )
        premium_params 
      else
        standard_params
      end
    else
      standard_params
    end
  end
end
