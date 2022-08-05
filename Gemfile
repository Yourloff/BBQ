source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.4'

gem 'bootsnap', require: false
gem 'bootstrap-icons-helper'
gem 'carrierwave'
gem "capistrano-resque", "~> 0.2.2", require: false
gem 'cssbundling-rails'
gem "mini_magick"
gem 'devise'
gem 'devise-i18n'
gem 'lightbox2-rails'
gem 'material_icons'
gem 'pg'
gem 'resque'
gem 'rails-i18n'
gem 'recaptcha', require: 'recaptcha/rails'
gem 'rails', '~> 7.0.2', '>= 7.0.2.4'
gem 'russian'
gem 'sprockets-rails', :require => 'sprockets/railtie'
gem 'puma', '~> 5.0'
gem "pundit", "~> 2.2"
gem 'jbuilder'
gem 'jsbundling-rails'
gem 'turbo-rails'
gem 'stimulus-rails'
gem 'jquery-rails'
gem 'tzinfo-data', platforms: %i[ mingw mswin x64_mingw jruby ]
gem 'dotenv-rails', '~> 2.1', '>= 2.1.1'

gem 'ed25519', '~> 1.2'
gem 'bcrypt_pbkdf', '~> 1'

group :development, :test do
  gem 'byebug'
  gem 'capistrano', '~> 3.8'
  gem 'capistrano-rails', '~> 1.2'
  gem 'capistrano-passenger', '~> 0.2'
  gem 'capistrano-rbenv', '~> 2.1'
  gem 'capistrano-bundler', '~> 1.2'
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'sqlite3'
end

group :development do
  gem 'web-console'
  gem 'letter_opener'
end

group :production do
  gem 'rails_12factor'
end
