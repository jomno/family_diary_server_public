class Diary < ApplicationRecord
  belongs_to :user, optional: true

  validates :released_date, presence: true
  validates :released_date, uniqueness: { scope: :user_id }

  mount_uploader :image, ImageUploader
end
