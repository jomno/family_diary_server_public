module Api
  class CurrentUserController < BaseController
    before_action :authenticate_user!

    def index
      render json: UserBlueprint.render(current_user), status: :ok
    end

    def set_printer_email
      printer_email = params[:printer_email]
      begin
        printService = EpsonPrinter.new(printer_email: printer_email)
        printService.authenticate!
      rescue StandardError => e
        render json: { message: e.message }, status: :bad_request
        return
      end

      current_user.update(printer_email: params[:printer_email])

      render json: UserBlueprint.render(current_user), status: :ok
    end

    def print
      printService = EpsonPrinter.new(printer_email: current_user.printer_email)

      begin
        printService.authenticate!
        current_user.orderd_diaries.each do |diary|
          printService.get_job
          printService.upload_file_from_url(diary.pdf_url)
          printService.print
        end
      rescue StandardError => e
        render json: { message: e.message }, status: :bad_request
        return
      end

      render json: { message: "인쇄 요청이 성공적으로 전송되었습니다." }, status: :ok
    end
  end
end
