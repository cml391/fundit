source 'https://rubygems.org'

gem 'rails', '3.2.7'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem "twitter-bootstrap-rails"
gem 'stripe'
gem 'rest-client'
gem 'oauth2'
gem 'pony'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
  gem 'coffee-rails', '~> 3.2.1'
end

gem 'jquery-rails'

group :test, :development do
  gem 'rspec-rails'
  gem 'sqlite3'
  gem 'pry'
  gem 'shoulda-matchers'
  gem 'factory_girl_rails'
end

group :production do
  gem 'pg'
  gem 'rack-ssl'
end

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'