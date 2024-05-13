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
  # ORMs
  if ruby_version < Gem::Version.new('2.5.0')
    gem 'activerecord', '~> 5', require: false # rails 5 works with Ruby 2.4
  else
    gem 'activerecord', '~> 6', require: false # rails 6 requires Ruby 2.5 or later
  end
  gem 'anonymous_active_record', '~> 1', require: false
  gem 'couch_potato', github: 'langalex/couch_potato', require: false
  gem 'mongoid', '~> 9', require: false
  gem 'mongoid-rspec', github: 'mongoid/mongoid-rspec', require: false
  gem 'nobrainer', '~> 0', require: false
  gem 'sequel', '~> 5', require: false

  if ruby_version >= Gem::Version.new('2.4')
    # No need to run byebug / pry on earlier versions
    gem 'byebug', platform: :mri
    gem 'pry', platform: :mri
    gem 'pry-byebug', platform: :mri
  end

  if ruby_version >= Gem::Version.new('2.7')
    # No need to run rubocop or simplecov on earlier versions
    gem 'rubocop', '~> 1.9', platform: :mri
    gem 'rubocop-md', platform: :mri
    gem 'rubocop-minitest', platform: :mri
    gem 'rubocop-packaging', platform: :mri
    gem 'rubocop-performance', platform: :mri
    gem 'rubocop-rake', platform: :mri
    gem 'rubocop-rspec', platform: :mri
    gem 'rubocop-sequel', platform: :mri

    gem 'simplecov', '~> 0.21', platform: :mri
  end

  gem 'growl'
  gem 'guard'
  gem 'guard-bundler'
  gem 'guard-rspec'
  gem 'rb-fsevent'
end

group :test do
  gem 'test-unit', '>= 3.0'
end
