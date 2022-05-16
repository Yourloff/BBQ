class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Юзер может создавать много событий
  has_many :events

   validates :name, presence: true, length: { maximum: 35 }

  before_validation :set_name, on: :create

  def set_name
    self.name = "Агент #{rand(777)}" if self.name.blank?
  end
end
