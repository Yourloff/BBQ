class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:github, :vkontakte]

  has_many :events, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :events

  validates :name, presence: true, length: { maximum: 35 }
  validates :email, length: { maximum: 255 }, uniqueness: true

  before_validation :set_name, on: :create

  after_commit :link_subscriptions, on: :create

  mount_uploader :avatar, AvatarUploader
  serialize :avatar, JSON

  def set_name
    self.name = "Агент #{rand(777)}" if self.name.blank?
  end

  def link_subscriptions
    Subscription.where(user_id: nil, user_email: self.email).update_all(user_id: self.id)
  end

  private

  def self.find_for_github_oauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first
    unless user
      user = User.create(
        email: data['email'],
        password: Devise.friendly_token[0, 20]
      )
    end
    user
  end

  def self.find_for_vkontakte_oauth(access_token)
    if user = User.where(:url => access_token.info.urls.Vkontakte).first
      user
    else
      User.create!(:provider => access_token.provider, :url => access_token.info.urls.Vkontakte, :username => access_token.info.name, :nickname => access_token.extra.raw_info.domain, :email => access_token.extra.raw_info.domain+'<hh user=vk>.com', :password => Devise.friendly_token[0,20])
    end
  end
end
