source "https://rubygems.org"

ruby "3.1.4"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.1.2"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

gem "carrierwave"
gem "fog-aws"

gem "rails-i18n", "~> 7.0.0" # For 7.0.0

# auth
gem "jwt"
gem "devise"
gem "devise-jwt", "~> 0.11.0"
gem "devise-jwt-cookie", github: "jomno/devise-jwt-cookie", branch: "master"

# api
gem "rack-cors"
# blueprinter is used to generate API documentation
gem "blueprinter"
# oj is used to generate optimized JSON
gem "oj"

gem "httparty"
gem "pdfkit"
gem "base64", "~> 0.2.0"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ]
  gem "byebug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
  gem "capistrano", "~> 3.11"
  gem "capistrano-rails", "~> 1.4"
  gem "capistrano-passenger", "~> 0.2.0"
  gem "capistrano-rbenv", "~> 2.1", ">= 2.1.4"
  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"

  gem "error_highlight", ">= 0.4.0", platforms: [:ruby]
end
