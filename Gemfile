source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.3"

gem "rails", "~> 7.0.4", ">= 7.0.4.2"

gem "pg", "~> 1.1"

gem "puma", "~> 5.0"

# Auth
gem 'devise_token_auth'

# CORS
gem 'rack-cors'

gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

gem "bootsnap", require: false

group :development, :test do
 
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

