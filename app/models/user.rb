class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :events, :dependent => :delete_all

  validates :name, presence: true, length: { maximum: 35 }
  validates :email, length: { maximum: 255 }
  validates :email, uniqueness: true
  validates :email, format: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/

  before_validation :set_name, on: :create

  def set_name
    self.name = "Агент #{rand(777)}" if self.name.blank?
  end
end
