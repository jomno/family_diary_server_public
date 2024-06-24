class Identify < ApplicationRecord
  belongs_to :user, optional: true

  validates :uid, presence: true

  serialize :response, JSON

  def self.find_for_oauth(auth_hash)
    uid = auth_hash.dig(:uid)
    access_token = auth_hash.dig(:credentials, "access_token")

    identify = Identify.find_by(uid: uid)

    if !identify.present?
      identify = Identify.new(
        uid: uid,
        access_token: access_token,
        response: auth_hash,
      )

      identify.save!
    end

    return identify
  end

  def self.auth_hash(response_hash, token_hash)
    uid = response_hash.dig("id")
    access_token = token_hash.dig("access_token")
    kakao_account = response_hash.dig("kakao_account")
    extra = response_hash.dig("properties")
    info = {
      name: response_hash.dig("properties", "nickname"),
      image: response_hash.dig("properties", "thumbnail_image"),
    }.merge(kakao_account).except("profile")

    auth_hash = {
      uid: uid,
      info: info,
      credentials: token_hash,
      extra: extra,
    }

    return auth_hash
  end

  def find_by_user
    email = self.info.email

    return self.user if self.user.present?
    return false unless email.present?

    find_user = User.find_by(email: email)

    return find_user
  end

  def info
    OpenStruct.new(response["info"])
  end
end
