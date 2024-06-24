class SnsService
  attr_accessor :provider, :code, :state, :redirect_uri

  def initialize(provider:, code:, state: nil, redirect_uri:)
    @provider = provider
    @code = code
    @state = state
    @redirect_uri = redirect_uri
  end

  def auth_result
    auth_hash_response, response_success, token = get_required_value()

    auth_hash = Identify.auth_hash(auth_hash_response, token)
    identify = Identify.find_for_oauth(auth_hash)
    find_user = identify.find_by_user

    return auth_hash, response_success, identify, find_user
  end

  private

  def get_required_value
    token = get_kakao_token()
    response = get_kakao_response(token)
    auth_hash_response = response.parsed_response
    response_success = response.code == 200

    return auth_hash_response, response_success, token
  end

  def get_kakao_response(token)
    response = HTTParty.get(
      "https://kapi.kakao.com/v2/user/me",
      headers: {
        "Authorization": token.dig("token_type") + " " + token.dig("access_token"),
      },
    )

    return response
  end

  def get_kakao_token
    token_url = "https://kauth.kakao.com/oauth/token"
    grant_type = "authorization_code"
    client_id = Rails.application.credentials.dig(:KAKAO_CLIENT_ID)

    token = HTTParty.post(
      token_url,
      body: {
        grant_type: grant_type,
        client_id: client_id,
        redirect_uri: redirect_uri,
        code: code,
      },
    ).parsed_response

    return token
  end
end
