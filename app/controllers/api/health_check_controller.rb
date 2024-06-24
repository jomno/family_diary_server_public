module Api
  class HealthCheckController < BaseController
    def index
      render json: { status: "ok" }
    end
  end
end
