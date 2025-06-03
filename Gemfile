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

### Security Audit
eval_gemfile "gemfiles/modular/audit.gemfile"

### Documentation
eval_gemfile "gemfiles/modular/documentation.gemfile"

### Linting
eval_gemfile "gemfiles/modular/style.gemfile"

### ORMs
gem "couch_potato", "~> 1.17", require: false
gem "mongoid", ">= 7", require: false
gem "mongoid-rspec", "~> 4.2", require: false
gem "nobrainer", "~> 0.44", require: false
gem "sequel", "~> 5.86", require: false
gem "sqlite3", ">= 1", require: false

### Local dev tools
gem "growl"
gem "guard"
gem "guard-bundler"
gem "guard-rspec"
gem "rb-fsevent"

# Code Coverage
eval_gemfile "gemfiles/modular/coverage.gemfile"

### Testing
gem "appraisal", github: "pboling/appraisal", branch: "galtzo"
gem "test-unit", ">= 3.0"

platform :mri do
  ### Debugging (MRI Only)
  gem "byebug", ">= 11"
end

# TODO: Remove this once fixed in upstream bson (> 5.0.2)
# Fix that is only needed on systems with GCC v15+
# See: https://github.com/mongodb/bson-ruby/pull/355
eval_gemfile "gemfiles/modular/bson_v5.gemfile"
