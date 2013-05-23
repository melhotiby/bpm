require "rvm/capistrano"
require "bundler/capistrano"

set :rvm_ruby_string, '1.9.3'
set :rvm_type, :user
set :normalize_asset_timestamps, false

set :application, "dailyburn"
set :deploy_to, "/var/rails/#{application}"
set :keep_releases, 3
set :ssh_options, {:forward_agent => true}

set :scm, :git
set :repository,  "git@github.com:railsdevmatt/bpm.git"
set :git_shallow_clone, 1
set :branch, "master"
set :use_sudo, false

set :user, "deploy"
set :ssh_options, {:forward_agent => true}

default_run_options[:pty] = true

task :production do
  set :rails_env, "production"
  server "ec2-54-234-79-123.compute-1.amazonaws.com", :app, :web, :db, :primary => true
end

before "deploy:restart", "deploy:bundle"
after "deploy:restart", "deploy:start"
after "deploy:restart", "deploy:precompile"

namespace :deploy do

  desc "run bundle install and ensure all gem requirements are met"
  task :bundle do
    run "cd #{current_path} && bundle install  --without=test development"
  end

  desc "Stop unicorn"
  task :restart, :except => { :no_release => true } do
    run "cd #{current_path} && kill -s QUIT `cat tmp/pids/unicorn.pid`"
  end

  desc "Start unicorn"
  task :start, :except => { :no_release => true } do
    run "cd #{current_path} ; bundle exec unicorn -c config/unicorn/production.rb -E #{rails_env} -D"
  end

  desc "Compile assets"
  task :precompile, :roles => :app do
    run "cd #{release_path} && rake RAILS_ENV=#{rails_env} assets:precompile"
  end

end

require './config/boot'