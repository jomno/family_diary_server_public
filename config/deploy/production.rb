set :deploy_to, "/home/deploy/family_diary_server"
set :branch, "main"
server Rails.application.credentials.dig(:production_ip), user: "deploy", roles: %w{app db web}
