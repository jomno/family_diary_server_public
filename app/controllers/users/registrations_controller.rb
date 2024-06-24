# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  include RackSessionFix
  respond_to :json

  # PUT /resource
  def update
    super do |resource|
      resource.update_without_password(account_update_params)
    end
  end

  private

  def respond_with(resource, _opts = {})
    if request.method == "POST" && resource.persisted?
      render json: {
               status: { code: 200, message: "회원가입을 성공했습니다." },
             }, status: :ok
    elsif (request.method == "PUT" || request.method == "PATCH") && resource.persisted?
      render json: {
               status: { code: 200, message: "성공적으로 수정되었습니다." },
             }, status: :ok
    elsif request.method == "DELETE"
      render json: {
               status: { code: 200, message: "성공적으로 삭제되었습니다." },
             }, status: :ok
    else
      render json: {
               message: "#{resource.errors.full_messages.to_sentence}",
             }, status: :unprocessable_entity
    end
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :profile])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :profile])
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
