class PhotoPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def destroy?
    user_is_owner?(record)
  end

  private

  def user_is_owner?(photo)
    user.present? && ((photo.user == user) || (photo.event.try(:user) == user))
  end
end
