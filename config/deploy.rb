# config valid only for current version of Capistrano
lock '3.7.2'

set :application, 'Synced'
set :repo_url, 'git@github.com:SyncedPSI/Synced.git'
set :user, 'www'
set :rbenv_ruby, '2.4.0'
set :puma_threads, [2, 8]
set :puma_workers, 2

set :pty,             true
set :use_sudo,        false
set :deploy_via,      :remote_cache
set :deploy_to,       "/home/#{fetch(:user)}/#{fetch(:application)}_#{fetch(:stage)}"
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true # Change to true if using ActiveRecord
set :yarn_flags, nil

## Linked Files & Directories (Default None):
set :linked_files, %w(.env)
set :linked_dirs,  %w(log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads node_modules)
