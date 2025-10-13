# frozen_string_literal: true

source "https://gem.coop"

git_source(:gitlab) { |repo_name| "https://gitlab.com/#{repo_name}" }

#### IMPORTANT #######################################################
# Gemfile is for local development ONLY; Gemfile is NOT loaded in CI #
####################################################### IMPORTANT ####

# Include dependencies from <gem name>.gemspec
gemspec

# Debugging
eval_gemfile "gemfiles/modular/debug.gemfile"

# Code Coverage
eval_gemfile "gemfiles/modular/coverage.gemfile"

# Linting
eval_gemfile "gemfiles/modular/style.gemfile"

# Documentation
eval_gemfile "gemfiles/modular/documentation.gemfile"

# Optional
eval_gemfile "gemfiles/modular/optional.gemfile"

### Std Lib Extracted Gems
eval_gemfile "gemfiles/modular/x_std_libs.gemfile"

### ORMs
gem "couch_potato", "~> 1.17", require: false
gem "mongoid", ">= 7", require: false
gem "mongoid-rspec", "~> 4.2", require: false
gem "nobrainer", "~> 0.44", require: false
gem "sequel", "~> 5.86", require: false
gem "sqlite3", ">= 1", require: false
gem "rom-sql", "~> 3.7", require: false

### Local dev tools
gem "growl"
gem "guard"
gem "guard-bundler"
gem "guard-rspec"
gem "rb-fsevent"

### Testing
gem "test-unit", ">= 3.0"
