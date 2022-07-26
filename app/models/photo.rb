class Photo < ApplicationRecord
  belongs_to :event
  belongs_to :user

  validates :photo, presence: true, optional: true

  mount_uploader :photo, PhotoUploader

  scope :persisted, -> { where "id IS NOT NULL" }
end
