class Api::BaseController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def authenticate_user!
    if current_user.nil?
      render json: {
               status: { code: 401, message: "권한이 없습니다." },
             }, status: :unauthorized
    end
  end

  def record_not_found
    render json: {
             status: { code: 404, message: "데이터를 찾을 수 없습니다." },
           }, status: :not_found
  end
end
