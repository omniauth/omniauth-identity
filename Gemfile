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
  if ruby_version < Gem::Version.new('2.5.0')
    gem 'activerecord', '~> 5' # rails 5 works with Ruby 2.4
  else
    gem 'activerecord', '~> 6' # rails 6 requires Ruby 2.5 or later
  end

  if ruby_version >= Gem::Version.new('2.4')
    # No need to run rubocop or simplecov on earlier versions
    gem 'rubocop', '~> 1.9', :platform => :mri
    gem 'rubocop-md', :platform => :mri
    gem 'rubocop-minitest', :platform => :mri
    gem 'rubocop-packaging', :platform => :mri
    gem 'rubocop-rake', :platform => :mri
    gem 'rubocop-rspec', :platform => :mri
    gem 'simplecov', :platform => :mri

    # No need to run byebug / pry on earlier versions
    gem 'byebug', :platform => :mri
    gem 'pry', :platform => :mri
    gem 'pry-byebug', :platform => :mri
  end

  gem 'couch_potato', github: 'langalex/couch_potato'
  gem 'growl'
  gem 'guard'
  gem 'guard-bundler'
  gem 'guard-rspec'
  gem 'mongoid-rspec', github: 'mongoid/mongoid-rspec'
  gem 'rb-fsevent'
end

group :test do
  gem 'test-unit', '>= 3.0'
end
