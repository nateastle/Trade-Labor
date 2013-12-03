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

server "dev.trade-labor.com", :app, :web, :db, :primary => true

namespace :deploy do
  
  desc "Symlink shared configs and folders on each release."
  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/log #{release_path}/log"
    run "ln -nfs #{shared_path}/uploads #{release_path}/public/uploads"
    # Solr  
    run "ln -nfs #{shared_path}/solr #{current_path}/solr"
    #run "ls -al #{current_path}/solr/pids/"
  end

  desc "Create solr dir in shared path."
  task :setup_solr_data_dir do
    run "mkdir -p #{shared_path}/solr/data"
  end

end

namespace :solr do
  [:stop, :start, :restart ].each do |action|
    desc "#{action.to_s.capitalize} Solr"
    task action, :roles => :web do
      invoke_command "sudo /etc/init.d/solr #{action.to_s}", :via => run_method
    end
  end

  desc "reindex the whole database"
  task :reindex, :roles => :app do
    run "cd #{current_path} && #{rake} RAILS_ENV=#{rails_env} sunspot:solr:reindex" 
  end
 
end  

namespace :apache do
  [:stop, :start, :restart, :reload].each do |action|
    desc "#{action.to_s.capitalize} Apache"
    task action, :roles => :web do
      invoke_command "sudo /etc/init.d/httpd #{action.to_s}", :via => run_method
    end
  end
end


namespace :passenger do  
  desc "Restart Application"  
  task :restart do  
    run "touch #{current_path}/tmp/restart.txt"  
  end  
end  
  
# after :deploy, "passenger:restart"  


after "deploy:update", "deploy:cleanup" 
after 'deploy:setup', 'deploy:setup_solr_data_dir'
before 'deploy:assets:precompile', 'deploy:symlink_shared'

# cap apache:stop
# cap apache:start
# cap apache:restart
# cap apache:reload