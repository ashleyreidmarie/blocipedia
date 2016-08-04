class PagePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.present? && user.admin?
        scope.all
      elsif user.present?
        scope.visible_to(user)
      else
        scope.not_private
      end
    end
  end
  
  def show?
    record.wiki.private == false || record.wiki.user_id == user.id || user.admin?
  end
  
  def create?
    user.present? && record.wiki.private == false || record.wiki.user_id == user.id || user.admin?
  end
  
  def update?
    (user.present? && record.wiki.private == false) || record.wiki.user_id == user.id || user.admin?
  end
  
  def destroy?
    record.wiki.user_id == user.id || user.admin?
  end
end
