require "bundler/capistrano"

set :scm,             :git
set :repository,      "git@codeplane.com:you/my_site.git"
set :branch,          "origin/master"
set :migrate_target,  :current
set :ssh_options,     { :forward_agent => true }
set :rails_env,       "production"
set :deploy_to,       "/srv/glodjib"
set :normalize_asset_timestamps, false

set :user,            "deploy"
set :group,           "web"
set :use_sudo,        false

role :web,    "176.58.127.66"
role :app,    "176.58.127.66"
role :db,     "176.58.127.66", :primary => true

set(:latest_release)  { fetch(:current_path) }
set(:release_path)    { fetch(:current_path) }
set(:current_release) { fetch(:current_path) }

set(:current_revision)  { capture("cd #{current_path}; git rev-parse --short HEAD").strip }
set(:latest_revision)   { capture("cd #{current_path}; git rev-parse --short HEAD").strip }
set(:previous_revision) { capture("cd #{current_path}; git rev-parse --short HEAD@{1}").strip }

default_environment["RAILS_ENV"] = 'production'

default_environment["PATH"]         = "/usr/local/rvm/gems/ruby-2.1.0-preview1/bin:/usr/local/rvm/gems/ruby-2.1.0-preview1@global/bin:/usr/local/rvm/rubies/ruby-2.1.0-preview1/bin:/usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
#default_environment["GEM_HOME"]     = "--"
#default_environment["GEM_PATH"]     = "--"
default_environment["RUBY_VERSION"] = "ruby-2.1.0-preview1"

default_run_options[:shell] = '/bin/bash'

namespace :deploy do
  desc "Deploy your application"
  task :default do
    update
    restart
  end

  desc "Setup your git-based deployment app"
  task :setup, :except => { :no_release => true } do
    dirs = [deploy_to, shared_path]
    dirs += shared_children.map { |d| File.join(shared_path, d) }
    run "sudo mkdir -p #{dirs.join(' ')} && #{try_sudo} chmod g+w #{dirs.join(' ')}"
    run "git clone #{repository} #{current_path}"
  end

  task :cold do
    update
    migrate
  end

  task :update do
    transaction do
      update_code
      migrate
      precompile_assets
    end
  end

  desc "Update the deployed code."
  task :update_code, :except => { :no_release => true } do
    run "cd #{current_path}; git fetch origin; git reset --hard #{branch}"
    finalize_update
  end

  desc "Update the database"
  task :migrations do
    transaction do
      update_code
    end
    migrate
    restart
  end

  desc "Precompile assets"
  task :precompile_assets do
    run_rake "assets:precompile"
  end

  task :finalize_update, :except => { :no_release => true } do
    if fetch(:normalize_asset_timestamps, true)
      stamp = Time.now.utc.strftime("%Y%m%d%H%M.%S")
      asset_paths = fetch(:public_children, %w(images stylesheets javascripts)).map { |p| "/srv/glodjib/current/public/#{p}" }.join(" ")
      run "find #{asset_paths} -exec touch -t #{stamp} {} ';'; true", :env => { "TZ" => "UTC" }
    end
  end

  desc "Zero-downtime restart of Unicorn"
  task :restart, :except => { :no_release => true } do
    run "sudo env PATH=#{default_environment["PATH"]} /etc/init.d/unicorn restart"
  end

  desc "Start unicorn"
  task :start, :except => { :no_release => true } do
    run "sudo env PATH=#{default_environment["PATH"]} /etc/init.d/unicorn start"
  end

  desc "Stop unicorn"
  task :stop, :except => { :no_release => true } do
    run "sudo env PATH=#{default_environment["PATH"]} /etc/init.d/unicorn stop"
  end
end

namespace :foreman do
  after "deploy:update", "foreman:export"    # Export foreman scripts
  after "deploy:restart", "foreman:restart"   # Restart application scripts
  after "deploy:stop", "foreman:stop"   # Restart application scripts
  after "deploy:start", "foreman:start"

# Foreman tasks

  desc 'Export the Procfile to Ubuntu upstart scripts'
  task :export, :roles => :queue do
    run "cd #{release_path}; sudo $(rbenv which foreman) export upstart /etc/init -f ./Procfile -a #{application} -u #{user} -l #{release_path}/log/foreman"
  end

  desc "Start the application services"
  task :start, :roles => :queue do
    run "sudo start #{application}"
  end

  desc "Stop the application services"

  task :stop, :roles => :queue do
    run "sudo stop #{application}"
  end

  desc "Restart the application services"
  task :restart, :roles => :queue do
    run "sudo stop #{application}"
    run "sudo start #{application}"
    #run "sudo start #{application} || sudo restart #{application}"
  end
end

def run_rake(cmd)
  run "cd /srv/glodjib/current; #{rake} #{cmd}"
end