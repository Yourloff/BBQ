class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  with_options if: -> { user.present? } do
    validates :user, uniqueness: { scope: :event_id }
    validate :event_host
  end

  with_options unless: -> { user.present? } do
    validates :user_name, presence: true
    validates :user_email, presence: true, format: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/
    validates :user_email, uniqueness: { scope: :event_id }
    validate :forbidden_to_use_email
  end

  def user_name
    user&.name || super
  end

  def user_email
    user&.email || super
  end

  def forbidden_to_use_email
    if User.find_by_email(self.user_email)
      errors.add(:email, 'уже существует')
    end
  end

  def event_host
    if user.eql?(event.user)
      errors.add(:user_email, message: 'Вы не можете это сделать')
    end
  end
end
