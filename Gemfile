# frozen_string_literal: true

#### IMPORTANT #######################################################
# Gemfile is for local development ONLY; Gemfile is NOT loaded in CI #
####################################################### IMPORTANT ####

source "https://rubygems.org"

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gemspec

### Std Lib Extracted Gems
gem "mutex_m", "~> 0.2"
gem "stringio", "~> 3.1", ">= 3.1.2"

### Documentation
gem "yard", "~> 0.9.34", require: false
gem "yard-junk", "~> 0.0.10"
gem "github-markup"
gem "redcarpet"

### Linting
gem "rubocop-lts", "~> 12.1", ">= 12.1.1"
gem "rubocop-minitest"
gem "rubocop-packaging", "~> 0.5", ">= 0.5.2"
gem "rubocop-rspec", "~> 3.2"
gem "rubocop-sequel"
gem "standard", ">= 1.35.1", "!= 1.41.1"

### ORMs
gem "couch_potato", "~> 1.17", require: false
gem "mongoid", ">= 7", require: false
gem "mongoid-rspec", "~> 4.2", require: false
gem "nobrainer", "~> 0.44", require: false
gem "sequel", "~> 5.86", require: false

### Local dev tools
gem "growl"
gem "guard"
gem "guard-bundler"
gem "guard-rspec"
gem "rb-fsevent"

### Coverage
gem "kettle-soup-cover", "~> 1.0", ">= 1.0.4"

### Testing
gem "test-unit", ">= 3.0"

platform :mri do
  ### Debugging (MRI Only)
  gem "byebug", ">= 11"
end
