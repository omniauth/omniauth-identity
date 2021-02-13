# frozen_string_literal: true

# This Gemfile copies liberally from https://github.com/rspec/rspec-core/blob/main/Gemfile
source 'https://rubygems.org'

# Specify your gem's dependencies in rspec-pending_for.gemspec
gemspec

ruby_version = Gem::Version.new(RUBY_VERSION)

gem 'yard', '~> 0.9.24', require: false

### deps for rdoc.info
group :documentation do
  gem 'github-markup', platform: :mri
  gem 'redcarpet', platform: :mri
end

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'couch_potato', github: 'langalex/couch_potato'
  gem 'growl'
  gem 'guard'
  gem 'guard-bundler'
  gem 'guard-rspec'
  gem 'mongoid-rspec', github: 'mongoid/mongoid-rspec'
  gem 'pry', platform: :mri
  gem 'pry-byebug', platform: :mri
  gem 'rb-fsevent'
end

group :test do
  gem 'test-unit', '>= 3.0'
end
