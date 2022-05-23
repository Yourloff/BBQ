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
    validate :check_exist_email
  end

  def user_name
    user&.name || super
  end

  def user_email
    user&.email || super
  end

  private

  def check_exist_email
    if User.find_by(email: user_email)
      errors.add(:email, I18n.t('subscriptions.subscription.check_exist_email'))
    end
  end

  def event_host
    if user == event.user
      errors.add(:user_email, message: I18n.t('subscriptions.subscription.event_host'))
    end
  end
end
