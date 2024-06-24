module Api
  class UsersController < BaseController
    PREPARED_TOKEN_ENV_KEY = "warden-jwt_auth.token"

    def kakao
      code = params[:code]
      redirect_uri = params[:redirect_uri]

      kakao_service = SnsService.new(provider: "kakao", code: code, redirect_uri: redirect_uri)
      auth_hash, response_success, identify, find_user = kakao_service.auth_result

      if response_success
        if identify.user.present?
          @user = identify.user

          custom_sign_in(:user, @user)

          render json: { result: "success" }, status: :ok
        elsif find_user.present?
          if find_user.identify.present?
            kor_provider = find_user.identify.kor_provider

            render json: { message: "#{kor_provider}로 이미 가입한 계정입니다.</br> #{find_user.email}계정으로 #{kor_provider} 로그인해주세요." }, status: :conflict
          else
            render json: { message: "#{find_user.email}로 일반 가입한 계정입니다.</br> #{find_user.email}계정으로 일반 로그인해주세요." }, status: :conflict
          end
        else
          email = identify.info.email
          name = identify.info.name
          profile = identify.info.image

          
          @user = User.new(email: email, name: name, remote_profile_url: profile)
          make_password = Devise.friendly_token[0, 20]
          @user.password = make_password
          @user.password_confirmation = make_password
          
          if @user.save
            identify.update(user_id: @user.id)

            custom_sign_in(:user, @user)

            render json: { result: "success" }, status: :ok
          else
            render json: { message: "카카오 로그인에 실패했습니다." }, status: :unprocessable_entity
          end
        end
      else
        render json: { message: "카카오 로그인에 실패했습니다." }, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.permit(:email, :name, :nickname)
    end

    def custom_sign_in(resource_or_scope, resource)
      sign_in resource_or_scope, resource
      token, payload = Warden::JWTAuth::UserEncoder.new.call(resource, resource_or_scope, nil)
      request.env[PREPARED_TOKEN_ENV_KEY] = token
      name, cookie = Devise::JWT::Cookie::CookieHelper.new.build(token)
      response.set_header("Authorization", current_token)
      Rack::Utils.set_cookie_header!(headers, name, cookie)
    end

    def current_token
      request.env["warden-jwt_auth.token"]
    end
  end
end
