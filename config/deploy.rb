require "rvm/capistrano"
require "bundler/capistrano"


server "59.90.127.144", :web, :app, :db, primary: true


set :application, "meter-reading"
set :user, "root"
set :rvm_type, "rvm use 1.9.3 --default"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false
set :rails_env, 'production'

set :scm, "git"
set :repository,  "git@github.com:railskipl/spml.git"
set :branch, "master"
set :bundle_cmd, 'source $HOME/.bash_profile && bundle'

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" #keep only the last 5 releases

namespace :deploy do 
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "/etc/init.d/unicorn_#{application} #{command}"
    end
  end
  
  task :setup_config, roles: :app do
      sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
      sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
      run "mkdir -p #{shared_path}/config"
      put File.read("config/database.example.yml"), "#{shared_path}/config/database.yml"
      puts "Now edit the config files in #{shared_path}."
    end
    after "deploy:setup", "deploy:setup_config"

    task :symlink_config, roles: :app do
      run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    end
    after "deploy:finalize_update", "deploy:symlink_config"

    desc "Make sure local git is in sync with remote."
    task :check_revision, roles: :web do
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
        puts "WARNING: HEAD is not the same as origin/master"
        puts "Run `git push` to sync changes."
        exit
      end
    end
    before "deploy", "deploy:check_revision"
  end