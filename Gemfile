source 'https://rubygems.org'

gem 'rails', '3.2.13'
gem 'bcrypt-ruby'
gem "therubyracer"
gem "less-rails" #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
gem "twitter-bootstrap-rails" 
gem 'activemerchant'
gem 'font_assets'


# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

#gem 'sqlite3'
gem 'pg'
gem 'pg_search'
gem 'jquery-tokeninput-rails'

#### Solr specific start ######
gem 'sunspot_rails', github: 'sunspot/sunspot', branch: 'master'
gem 'sunspot_solr', github: 'sunspot/sunspot', branch: 'master'
gem 'progress_bar'
#### Solr specific end ######

gem 'simple_form'
gem 'client_side_validations'
gem 'client_side_validations-simple_form'

 require 'csv'
gem 'rubyzip', '< 1.0.0'
gem 'roo','1.10.1'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails', "< 3.0.0"


# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
group :development do
  gem "rails-erd"
  gem "debugger"
end

gem "rspec-rails", :group => [:development, :test]
gem "capybara", :group => [:development, :test]
gem "nifty-generators", :group => :development
gem "kaminari"
gem "annotate"
gem "devise" , "3.1.0"
gem 'cancan'

gem "thin"
gem 'rmagick'
gem 'carrierwave'

gem 'nested_form'
