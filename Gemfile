source 'https://rubygems.org'

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

gem 'telegram-bot-ruby', require: 'telegram/bot'
gem 'net-http-persistent'

gem 'activerecord', require: 'active_record'
gem 'activesupport', require: 'active_support'
gem 'rake'

# Gemas sólo necesarias en producción.
group :production do
  gem 'pg'
end

# Gemas sólo necesarias en desarrollo.
group :development do
  gem 'pry'
  gem 'sqlite3'
end

# Gemas sólo necesarias para el deploy con capistrano.
group :deploy do
  gem 'capistrano', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rbenv', require: false
  gem 'capistrano-rails', require: false
  gem 'ed25519', require: false
  gem 'bcrypt_pbkdf', require: false
end
