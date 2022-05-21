class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :events, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy

  has_many :events

  validates :name, presence: true, length: { maximum: 35 }
  validates :email, length: { maximum: 255 }
  validates :email, uniqueness: true

  before_validation :set_name, on: :create

  def set_name
    self.name = "Агент #{rand(777)}" if self.name.blank?
  end
end
