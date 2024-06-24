module Api
  class DiariesController < BaseController
    before_action :authenticate_user!, except: %i[create show]
    before_action :set_diary, only: %i[show destroy update]

    def index
      @diaries = current_user.diaries

      render json: DiaryBlueprint.render(@diaries), status: :ok
    end

    def create
      @diary = Diary.new(diary_params)

      if @diary.save
        render json: DiaryBlueprint.render(@diary), status: :created
      else
        render json: @diary.errors, status: :unprocessable_entity
      end
    end

    def update
      @diary.user = current_user
      @diary.update(diary_params)

      render json: DiaryBlueprint.render(@diary), status: :ok
    end

    def show
      render json: DiaryBlueprint.render(@diary), status: :ok
    end

    def destroy
      @diary.destroy

      head :no_content
    end

    private

    def set_diary
      @diary = Diary.find(params[:id])
    end

    def diary_params
      params.permit(:released_date, :content, :image, :audio_url, :pdf_url)
    end
  end
end
