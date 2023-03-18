# config valid for current version and patch releases of Capistrano
lock "~> 3.17.2"

set :application, "Questrooms"
set :repo_url, "git@github.com:skvortsovvg/QuestRooms.git"

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/deployer/questrooms"
set :deploy_user, "deployer"

# Default value for :linked_files is []
append :linked_files, "config/database.yml", 'config/master.key'

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "tmp/webpacker", "public/system", "vendor", "storage"
