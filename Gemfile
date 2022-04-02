source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.5'
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 5.0'
gem 'jsonapi-serializer'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

gem 'kaminari', '>= 1.2.1'

# API Documentation
gem 'rspec_api_documentation', '~> 6.1'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Rspec related gem
  gem 'rspec-rails', '~> 4.0.2'
  # Fake data
  gem 'factory_bot_rails', '>= 6.2.0'
  gem 'faker', git: 'https://github.com/faker-ruby/faker.git', branch: 'master'
end


group :test do
  gem 'database_flusher'
  gem 'shoulda-matchers', '~> 4.0'
  gem 'shoulda-callback-matchers'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'spring'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]