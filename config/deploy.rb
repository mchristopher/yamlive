begin
  require 'bundler/capistrano'
rescue LoadError
  puts "You're missing the bundler gem: gem install bundler"
  exit 1
end

set :application,   "yammerlive"
set :user,          "deploy"
set :port,          22
set :repository,    "git@github.com:eagleyecs/yamlive.git"
set :deploy_via,    :remote_cache
set :deploy_to,     "/data/#{application}"
set :scm,           :git
set :use_sudo,      false
set :keep_releases, 5
set :bundle_flags,  "--deployment"

#role [:web, :app, :db],  "yammerlive.mchristopher.com", :primary => true # This is where Rails migrations will run

server "yammerlive.mchristopher.com", :web, :app, :db, :primary => true

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
