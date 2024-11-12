# frozen_string_literal: true

#### IMPORTANT #######################################################
# Gemfile is for local development ONLY; Gemfile is NOT loaded in CI #
####################################################### IMPORTANT ####

source "https://rubygems.org"

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gemspec

### Documentation
gem "yard", "~> 0.9.34", require: false
gem "yard-junk", "~> 0.0.10"
gem "github-markup", platform: :mri
gem "redcarpet", platform: :mri

### Linting
gem "rubocop-lts", "~> 12.1", ">= 12.1.1"
gem "rubocop-minitest"
gem "rubocop-sequel"

### ORMs
gem "activerecord", ">= 6", require: false # rails 6 requires Ruby 2.5 or later
gem "anonymous_active_record", "~> 1", require: false
gem "couch_potato", github: "langalex/couch_potato", require: false
gem "mongoid", "~> 7", require: false
gem "mongoid-rspec", github: "mongoid/mongoid-rspec", require: false
gem "nobrainer", "~> 0", require: false
gem "sequel", "~> 5", require: false

### Local dev tools
gem "growl"
gem "guard"
gem "guard-bundler"
gem "guard-rspec"
gem "rb-fsevent"

### Coverage
gem "kettle-soup-cover", "~> 1.0", ">= 1.0.2"

### Testing
gem "test-unit", ">= 3.0"

platform :mri do
  ### Debugging (MRI Only)
  gem "byebug", ">= 11"
end
