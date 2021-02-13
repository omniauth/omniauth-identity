# frozen_string_literal: true

# This Gemfile copies liberally from https://github.com/rspec/rspec-core/blob/main/Gemfile
source 'https://rubygems.org'

# Specify your gem's dependencies in rspec-pending_for.gemspec
gemspec

ruby_version = Gem::Version.new(RUBY_VERSION)
if ruby_version < Gem::Version.new('1.9.3')
  gem 'rake', '< 11.0.0' # rake 11 requires Ruby 1.9.3 or later
elsif ruby_version < Gem::Version.new('2.0.0')
  gem 'rake', '< 12.0.0' # rake 12 requires Ruby 2.0.0 or later
elsif ruby_version < Gem::Version.new('2.2.0')
  gem 'rake', '< 13.0.0' # rake 13 requires Ruby 2.2.0 or later
else
  gem 'rake', '> 13.0.0'
end

gem 'yard', '~> 0.9.24', :require => false

### deps for rdoc.info
group :documentation do
  gem 'github-markup', :platform => :mri
  gem 'redcarpet', :platform => :mri
end

group :development, :test do
  # No need to run byebug / pry on earlier versions
  if ruby_version >= Gem::Version.new('2.4') && RUBY_ENGINE == 'ruby'
    gem 'byebug'
    gem 'pry'
    gem 'pry-byebug'
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
  # No need to run rubocop or simplecov on earlier versions
  if ruby_version >= Gem::Version.new('2.4') && RUBY_ENGINE == 'ruby'
    gem 'rubocop', '~> 1.6'
    gem 'rubocop-md'
    gem 'rubocop-minitest'
    gem 'rubocop-packaging'
    gem 'rubocop-rake'
    gem 'rubocop-rspec'
    gem 'simplecov'
  end

  gem 'test-unit', '~> 3.0' if ruby_version >= Gem::Version.new('2.2')

  # Version 5.12 of minitest requires Ruby 2.4
  gem 'minitest', '< 5.12.0' if ruby_version < Gem::Version.new('2.4.0')
end
