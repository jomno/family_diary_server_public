# config valid for current version and patch releases of Capistrano
lock "~> 3.18.0"
# set :assets_roles, []

set :application, "family_diary_server"
set :repo_url, "git@github.com:jomno/family_diary_server_public.git"

set :keep_releases, 4

append :linked_files, "config/master.key"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "vendor/bundle", ".bundle", "public/system", "public/uploads"

set :bundle_gemfile, -> { release_path.join("Gemfile") }
set :conditionally_migrate, true
