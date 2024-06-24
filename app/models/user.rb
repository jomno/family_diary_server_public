class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable, :validatable, :jwt_cookie_authenticatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  has_one :identify, dependent: :destroy
  has_many :diaries, dependent: :destroy

  mount_uploader :profile, ImageUploader

  def orderd_diaries
    diaries.order(released_date: :asc)
  end

  def jwt_payload
    super.merge(
      UserBlueprint.render_as_hash(self)
    )
  end

  def today_diary
    diaries.find_by(released_date: Date.today)
  end
end
