# config valid for current version and patch releases of Capistrano
lock '~> 3.16.0'

set :application, 'my_app_name'
set :repo_url, 'git@github.com:psiconauta/donna_auchaway.git'
set :branch, ENV['DONNA_DEPLOY_BRANCH'] || :main

# Default value for :format is :airbrussh.

# Valores default de capistrano.
set :format, :airbrussh
# set :format, :pretty
set :log_level, :debug
set :pty, false
set :keep_releases, 5
set :format_options,
  command_output: true,
  log_file: 'log/capistrano.log',
  color: :auto,
  truncate: :auto

# rbenv.
set :rbenv_type, :user
set :rbenv_ruby, File.read('.ruby-version').strip

append :linked_files,
  'db/production.sqlite3'
