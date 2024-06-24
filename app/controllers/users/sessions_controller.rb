# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  include RackSessionFix
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    if resource.persisted?
      render json: {
               status: { code: 200, message: "Logged in sucessfully." },
             }, status: :ok
    else
      render json: {
               status: { code: 401, message: "존재하지 않는 사용자입니다." },
               data: {},
             }, status: :unauthorized
    end
  end

  def respond_to_on_destroy
    # _session_id 쿠키 삭제해서 계정 연동 안 되게 처리
    # TODO: _session_id 개념 체크 필요
    Rack::Utils.set_cookie_header!(headers, "_session_id", value: "", expires: 1.day.ago, path: "/")

    render json: {
             status: 200,
             message: "logged out successfully",
           }, status: :ok
  end

  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
