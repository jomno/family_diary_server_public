class UserBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :email, :profile_url, :printer_email
end
