class DiaryBlueprint < Blueprinter::Base
  identifier :id

  fields :released_date, :content, :image_url, :audio_url
end
