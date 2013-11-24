require 'bundler/capistrano'
# $:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require 'rvm/capistrano'

set :application, "Trade-Labor"
set :repository,  "git@github.com:nateastle/Trade-Labor.git"

set :rvm_ruby_string, 'ruby-1.9.3-p448'

set :rvm_type, :system

set :branch, "master"
set :deploy_to, "/var/www/dev/trade_labor"
set :rails_env, "production"
set :app_env,   "production"

set :scm, :git
set :deploy_via, :remote_cache

set :git_enable_submodules, false

set :keep_releases, 5
set :user, "ec2-user"
set :use_sudo, false

default_run_options[:pty] = true
ssh_options[:forward_agent] = true
ssh_options[:auth_methods] = ["publickey"]
ssh_options[:keys] = ["/home/sandeep/Desktop/sandeep/nathan/tradelaborkey.pem"]

load 'deploy/assets'

#server "ec2-user@ec2-54-242-240-126.compute-1.amazonaws.com", :app, :web, :db, :primary => true

server "dev.trade-labor.com", :app, :web, :db, :primary => true

after "deploy:update", "deploy:cleanup" 
before 'deploy:assets:precompile', 'deploy:symlink_shared'


namespace :deploy do
  desc "Symlink shared configs and folders on each release."
  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    # run "ln -nfs #{shared_path}/config/config.yml #{release_path}/config/config.yml"
    # run "ln -nfs #{shared_path}/lib/app_data.yml #{release_path}/lib/app_data.yml"
    run "ln -nfs #{shared_path}/log #{release_path}/log"
    run "ln -nfs #{shared_path}/uploads #{release_path}/public/uploads"
  end
end

namespace :solr do

  desc "Start the solr server."
  task :start do
    
  end

  desc "Stop the solr server."
  task :stop do
    
  end

  desc "Restart the solr server."
  task :restart do
    
  end
end