# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'garden'
set :repo_url, 'git@github.com:shangyukyo/garden.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/garden/www"

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

set :pid_path, "#{shared_path}/tmp/pids"
set :log_path, "#{shared_path}/log"

namespace :unicorn do
  pid = "#{fetch(:pid_path)}/unicorn.pid"

  task :start do
    on roles(:web, :db, :app) do
      within release_path do
        with rails_env: 'production' do
          execute :bundle, 'exec unicorn_rails -c config/unicorn.rb -D' 
        end
      end
    end
  end

  task :stop do
    on roles(:web, :db, :app) do
      execute :kill, "-QUIT `cat #{pid}`"
    end
  end

  task :restart do
    on roles(:web, :db, :app) do
      execute :kill, "-USR2 `cat #{pid}`"
    end    
  end

  task :force_reload do
    on roles(:web, :db, :app) do
      execute :kill, "-TERM `cat #{pid}`"
      invoke 'unicorn:start'
    end
  end
end

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end