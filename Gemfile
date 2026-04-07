source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby "2.7.8"

gem "rails", "~> 5.1.4"
gem "pg", "~> 0.18"
gem "puma", "~> 3.7"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"

gem "coffee-rails", "~> 4.2"
gem "turbolinks", "~> 5"
gem "jbuilder", "~> 2.5"
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

gem "slim-rails"
gem "simple_form", "~> 3.5.0"
gem "bootstrap-sass", "~> 3.3.7"
gem "jquery-rails"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "rspec-rails"
  gem "factory_bot_rails"
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"

  gem "lefthook", require: false
end

group :test do
  gem "capybara"
  gem "database_cleaner"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
