# frozen_string_literal: true

# HOW TO UPDATE APPRAISALS:
#   BUNDLE_GEMFILE=Appraisal.root.gemfile bundle
#   BUNDLE_GEMFILE=Appraisal.root.gemfile bundle exec appraisal update
#   bundle exec rake rubocop_gradual:autocorrect

# Used for HEAD (nightly) releases of ruby, truffleruby, and jruby.
# Split into discrete appraisals if one of them needs a dependency locked discretely.
appraise "ar-head" do
  eval_gemfile "modular/mutex_m/r2/v0.3.gemfile"
  eval_gemfile "modular/stringio/r2/v3.0.gemfile"
  eval_gemfile "modular/activerecord/vHEAD.gemfile"
  eval_gemfile "modular/runtime_heads.gemfile"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Compat: Ruby >= 2.2.2
# Test Matrix:
#   - Ruby 2.4
appraise "ar-5-2-r2.4" do
  eval_gemfile "modular/mutex_m/r2.4/v0.1.gemfile"
  eval_gemfile "modular/stringio/r2.4/v0.0.2.gemfile"
  eval_gemfile "modular/activerecord/r2.4/v5.2.gemfile"
  eval_gemfile "modular/omniauth/r2/v1.0.gemfile"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Compat: Ruby >= 2.2.2
# Test Matrix:
#   - Ruby 2.5
#   - Ruby 2.6
#   - Ruby 2.7
appraise "ar-5-2-r2" do
  eval_gemfile "modular/mutex_m/r2/v0.3.gemfile"
  eval_gemfile "modular/stringio/r2/v3.0.gemfile"
  eval_gemfile "modular/activerecord/r2/v5.2.gemfile"
  eval_gemfile "modular/omniauth/r2/v1.1.gemfile"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Compat: Ruby >= 2.5
# Test Matrix:
#   - Ruby 2.5
#   - Ruby 2.6
#   - Ruby 2.7
appraise "ar-6-0" do
  eval_gemfile "modular/activerecord/r2/v6.0.gemfile"
  eval_gemfile "modular/mutex_m/r2/v0.3.gemfile"
  eval_gemfile "modular/stringio/r2/v3.0.gemfile"
  eval_gemfile "modular/omniauth/r2/v1.2.gemfile"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Compat: Ruby >= 2.5
# Test Matrix:
#   - JRuby 9.2
#   - JRuby 9.3
#   - Ruby 2.5
#   - Ruby 2.6
#   - Ruby 2.7
appraise "ar-6-1-r2" do
  eval_gemfile "modular/activerecord/r2/v6.1.gemfile"
  eval_gemfile "modular/mutex_m/r2/v0.3.gemfile"
  eval_gemfile "modular/stringio/r2/v3.0.gemfile"
  eval_gemfile "modular/omniauth/r2/v1.3.gemfile"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Compat: Ruby >= 2.5
# Test Matrix:
#   - Ruby 3.0
appraise "ar-6-1-r3" do
  eval_gemfile "modular/activerecord/r3/v6.1.gemfile"
  eval_gemfile "modular/mutex_m/r2/v0.3.gemfile"
  eval_gemfile "modular/stringio/r2/v3.0.gemfile"
  eval_gemfile "modular/omniauth/r3/v2.1.gemfile"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Compat: Ruby >= 2.7
# Test Matrix:
#   - Ruby 2.7
appraise "ar-7-0-r2" do
  eval_gemfile "modular/activerecord/r2/v7.0.gemfile"
  eval_gemfile "modular/mutex_m/r2/v0.3.gemfile"
  eval_gemfile "modular/stringio/r2/v3.0.gemfile"
  eval_gemfile "modular/omniauth/r2/v1.4.gemfile"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Compat: Ruby >= 2.7
# Test Matrix:
#   - Ruby 3.0
#   - Ruby 3.1
appraise "ar-7-0-r3" do
  eval_gemfile "modular/activerecord/r3/v7.0.gemfile"
  eval_gemfile "modular/mutex_m/r2/v0.3.gemfile"
  eval_gemfile "modular/stringio/r2/v3.0.gemfile"
  eval_gemfile "modular/omniauth/r3/v2.1.gemfile"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Compat: Ruby >= 2.7
# Test Matrix:
#   - Ruby 2.7
appraise "ar-7-1-r2" do
  eval_gemfile "modular/activerecord/r2/v7.1.gemfile"
  eval_gemfile "modular/mutex_m/r2/v0.3.gemfile"
  eval_gemfile "modular/stringio/r2/v3.0.gemfile"
  eval_gemfile "modular/omniauth/r2/v1.5.gemfile"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Compat: Ruby >= 2.7
# Test Matrix:
#   - Ruby 3.0
#   - Ruby 3.1
#   - Ruby 3.2
#   - JRuby 10.0
appraise "ar-7-1-r3" do
  eval_gemfile "modular/activerecord/r3/v7.1.gemfile"
  eval_gemfile "modular/mutex_m/r2/v0.3.gemfile"
  eval_gemfile "modular/stringio/r2/v3.0.gemfile"
  eval_gemfile "modular/omniauth/r3/v2.1.gemfile"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Compat: Ruby >= 3.1
# Test Matrix:
#   - Ruby 3.1
#   - JRuby 9.4
#   - Ruby 3.2
#   - Ruby 3.3
#   - JRuby 10.0
#   - jruby-head
appraise "ar-7-2" do
  eval_gemfile "modular/activerecord/r3/v7.2.gemfile"
  eval_gemfile "modular/mutex_m/r2/v0.3.gemfile"
  eval_gemfile "modular/stringio/r2/v3.0.gemfile"
  eval_gemfile "modular/omniauth/r3/v2.1.gemfile"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Compat: Ruby >= 3.2
# Test Matrix:
#   - Ruby 3.2
#   - Ruby 3.3
#   - Ruby 3.4
#   - ruby-head
#   - truffleruby-head
appraise "ar-8-0" do
  eval_gemfile "modular/activerecord/r3/v8.0.gemfile"
  eval_gemfile "modular/mutex_m/r2/v0.3.gemfile"
  eval_gemfile "modular/stringio/r2/v3.0.gemfile"
  eval_gemfile "modular/omniauth/r3/v2.1.gemfile"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Compat: Ruby >= 2.2.2 (due to AR >= 5)
# Test Matrix:
#   - Ruby 2.4
appraise "couch-1.17-r2.4" do
  gem "couch_potato", "~> 1.17"
  gem "ostruct", "~> 0.1" # Ruby >= 0, all newer releases of ostruct require Ruby >= 2.5

  eval_gemfile "modular/activerecord/r2/v5.2.gemfile"
  eval_gemfile "modular/mutex_m/r2.4/v0.1.gemfile"
  eval_gemfile "modular/stringio/r2.4/v0.0.2.gemfile"
  eval_gemfile "modular/omniauth/r2/v1.6.gemfile"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Compat: Ruby >= 2.2.2 (due to AR >= 5)
# Test Matrix:
#   - Ruby 2.5
#   - Ruby 2.6
#   - JRuby 9.3
#   - Ruby 2.7
appraise "couch-1.17-r2" do
  gem "couch_potato", "~> 1.17"
  # TODO: Bump when old dropping old Ruby from this gem.
  gem "ostruct", "~> 0.6", ">= 0.6.1" # Ruby >= 2.5

  eval_gemfile "modular/activerecord/r2/v5.2.gemfile"
  eval_gemfile "modular/mutex_m/r2/v0.3.gemfile"
  eval_gemfile "modular/stringio/r2/v3.0.gemfile"
  eval_gemfile "modular/omniauth/r2/v1.7.gemfile"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Compat: Ruby >= 2.2.2 (due to AR >= 5)
# Test Matrix:
#   - Ruby 3.0
#   - Ruby 3.1
#   - JRuby 9.4
#   - Ruby 3.2
#   - Ruby 3.3
#   - Ruby 3.4
#   - JRuby 10.0
#   - ruby-head
#   - truffleruby-head
#   - jruby-head
appraise "couch-1.17-r3" do
  gem "couch_potato", "~> 1.17"
  gem "ostruct", "~> 0.6", ">= 0.6.1" # Ruby >= 2.5

  eval_gemfile "modular/activerecord/r3/v7.1.gemfile"
  eval_gemfile "modular/mutex_m/r2/v0.3.gemfile"
  eval_gemfile "modular/stringio/r2/v3.0.gemfile"
  eval_gemfile "modular/omniauth/r3/v2.1.gemfile"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Compat: Ruby >= 2.3
# Test Matrix:
#   - Ruby 2.4
appraise "mongoid-7.3-b4.12" do
  gem "mongoid", "~> 7.3", ">= 7.3.5"
  gem "mongoid-rspec", "~> 4.1"
  eval_gemfile "modular/bson/r2.4/v4.12.gemfile"

  eval_gemfile "modular/activerecord/r2.4/v5.2.gemfile"
  eval_gemfile "modular/mutex_m/r2.4/v0.1.gemfile"
  eval_gemfile "modular/stringio/r2.4/v0.0.2.gemfile"
  eval_gemfile "modular/omniauth/r2/v1.8.gemfile"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Compat: Ruby >= 2.3
# Test Matrix:
#   - Ruby 2.5
#   - JRuby 9.2
appraise "mongoid-7.3-b4.15" do
  gem "mongoid", "~> 7.3", ">= 7.3.5"
  gem "mongoid-rspec", "~> 4.1"
  eval_gemfile "modular/bson/r2/v4.15.gemfile"

  eval_gemfile "modular/activerecord/r2/v5.2.gemfile"
  eval_gemfile "modular/mutex_m/r2/v0.3.gemfile"
  eval_gemfile "modular/stringio/r2/v3.0.gemfile"
  eval_gemfile "modular/omniauth/r2/v1.9.gemfile"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Compat: Ruby >= 2.5
# Test Matrix:
#   - Ruby 2.5
#   - JRuby 9.2
appraise "mongoid-7.4-b4.15" do
  gem "mongoid", "~> 7.4", ">= 7.4.3"
  gem "mongoid-rspec", "~> 4.1"
  eval_gemfile "modular/bson/r2/v4.15.gemfile"

  eval_gemfile "modular/activerecord/r2/v5.2.gemfile"
  eval_gemfile "modular/mutex_m/r2/v0.3.gemfile"
  eval_gemfile "modular/stringio/r2/v3.0.gemfile"
  eval_gemfile "modular/omniauth/r2/v2.0.gemfile"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Compat: Ruby >= 2.5
# Test Matrix:
#   - Ruby 2.6
#   - JRuby 9.3
#   - Ruby 2.7
appraise "mongoid-7.4-b5" do
  gem "mongoid", "~> 7.4", ">= 7.4.3"
  gem "mongoid-rspec", "~> 4.1"
  eval_gemfile "modular/bson/r2/v5.0.gemfile"

  eval_gemfile "modular/activerecord/r2/v5.2.gemfile"
  eval_gemfile "modular/mutex_m/r2/v0.3.gemfile"
  eval_gemfile "modular/stringio/r2/v3.0.gemfile"
  eval_gemfile "modular/omniauth/r2/v2.0.gemfile"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Compat: Ruby >= 2.6
# Test Matrix:
#   - Ruby 2.6
#   - JRuby 9.3
#   - Ruby 2.7
appraise "mongoid-8.1-r2" do
  gem "mongoid", "~> 8.1", ">= 8.1.7"
  gem "mongoid-rspec", "~> 4.2"
  eval_gemfile "modular/bson/r2/v5.0.gemfile"

  eval_gemfile "modular/activerecord/r2/v5.2.gemfile"
  eval_gemfile "modular/mutex_m/r2/v0.3.gemfile"
  eval_gemfile "modular/stringio/r2/v3.0.gemfile"
  eval_gemfile "modular/omniauth/r2/v2.0.gemfile"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Compat: Ruby >= 2.6
# Test Matrix:
#   - Ruby 3.0
appraise "mongoid-8.1-r3.0" do
  gem "mongoid", "~> 8.1", ">= 8.1.7"
  gem "mongoid-rspec", "~> 4.2"
  eval_gemfile "modular/bson/r3/v5.0.gemfile"

  eval_gemfile "modular/activerecord/r3/v7.1.gemfile"
  eval_gemfile "modular/mutex_m/r2/v0.3.gemfile"
  eval_gemfile "modular/stringio/r2/v3.0.gemfile"
  eval_gemfile "modular/omniauth/r3/v2.1.gemfile"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Compat: Ruby >= 2.6
# Test Matrix:
#   - Ruby 3.1
#   - JRuby 9.4
#   - Ruby 3.2
#   - Ruby 3.3
#   - Ruby 3.4
appraise "mongoid-8.1-r3" do
  gem "mongoid", "~> 8.1", ">= 8.1.7"
  gem "mongoid-rspec", "~> 4.2"
  eval_gemfile "modular/bson/r3/v5.0.gemfile"

  eval_gemfile "modular/activerecord/r3/v7.1.gemfile"
  eval_gemfile "modular/mutex_m/r2/v0.3.gemfile"
  eval_gemfile "modular/stringio/r2/v3.0.gemfile"
  eval_gemfile "modular/omniauth/r3/v2.1.gemfile"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Compat: Ruby >= 2.7
# Test Matrix:
#   - Ruby 2.7
appraise "mongoid-9.0-r2-omni1.9" do
  gem "mongoid", "~> 9.0", ">= 9.0.3"
  gem "mongoid-rspec", "~> 4.2"
  eval_gemfile "modular/bson/r2/v5.0.gemfile"

  eval_gemfile "modular/activerecord/r2/v7.1.gemfile"
  eval_gemfile "modular/mutex_m/r2/v0.3.gemfile"
  eval_gemfile "modular/stringio/r2/v3.0.gemfile"
  eval_gemfile "modular/omniauth/r2/v1.9.gemfile"
  gem "ostruct", "~> 0.6", ">= 0.6.1" # Ruby >= 2.5
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Compat: Ruby >= 2.7
# Test Matrix:
#   - Ruby 2.7
appraise "mongoid-9.0-r2-omni2.0" do
  gem "mongoid", "~> 9.0", ">= 9.0.3"
  gem "mongoid-rspec", "~> 4.2"
  eval_gemfile "modular/bson/r2/v5.0.gemfile"

  eval_gemfile "modular/activerecord/r2/v7.1.gemfile"
  eval_gemfile "modular/mutex_m/r2/v0.3.gemfile"
  eval_gemfile "modular/stringio/r2/v3.0.gemfile"
  eval_gemfile "modular/omniauth/r2/v2.0.gemfile"
  gem "ostruct", "~> 0.6", ">= 0.6.1" # Ruby >= 2.5
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Compat: Ruby >= 2.7
# Test Matrix:
#   - Ruby 2.7
appraise "mongoid-9.0-r2-omni2.1" do
  gem "mongoid", "~> 9.0", ">= 9.0.3"
  gem "mongoid-rspec", "~> 4.2"
  eval_gemfile "modular/bson/r2/v5.0.gemfile"

  eval_gemfile "modular/activerecord/r2/v7.1.gemfile"
  eval_gemfile "modular/mutex_m/r2/v0.3.gemfile"
  eval_gemfile "modular/stringio/r2/v3.0.gemfile"
  eval_gemfile "modular/omniauth/r2/v2.1.gemfile"
  gem "ostruct", "~> 0.6", ">= 0.6.1" # Ruby >= 2.5
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Compat: Ruby >= 2.7
# Test Matrix:
#   - Ruby 3.0
appraise "mongoid-9.0-r3.0" do
  gem "mongoid", "~> 9.0", ">= 9.0.3"
  gem "mongoid-rspec", "~> 4.2"
  eval_gemfile "modular/bson/r3/v5.0.gemfile"

  eval_gemfile "modular/activerecord/r3/v7.1.gemfile"
  eval_gemfile "modular/mutex_m/r2/v0.3.gemfile"
  eval_gemfile "modular/stringio/r2/v3.0.gemfile"
  eval_gemfile "modular/omniauth/r3/v2.1.gemfile"
  gem "ostruct", "~> 0.6", ">= 0.6.1" # Ruby >= 2.5
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Compat: Ruby >= 2.7
# Test Matrix:
#   - Ruby 3.1
#   - Ruby 3.2
#   - Ruby 3.3
#   - Ruby 3.4
#   - ruby-head
#   - truffleruby-head
#   - jruby-head
appraise "mongoid-9.0-r3" do
  gem "mongoid", "~> 9.0", ">= 9.0.3"
  gem "mongoid-rspec", "~> 4.2"
  eval_gemfile "modular/bson/r3/v5.0.gemfile"

  eval_gemfile "modular/activerecord/r3/v7.1.gemfile"
  eval_gemfile "modular/mutex_m/r2/v0.3.gemfile"
  eval_gemfile "modular/stringio/r2/v3.0.gemfile"
  eval_gemfile "modular/omniauth/r3/v2.1.gemfile"
  gem "ostruct", "~> 0.6", ">= 0.6.1" # Ruby >= 2.5
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# 1. While the Ruby driver, nobrainer, is maintained,
#   RethinkDB itself is currently a zombie project.
# 2. There are zero examples in the wild of a GitHub Actions workflow
#   that sets up a RethinkDB service to test client code against.
# As long as above points remain current, no attempt will be made to get nobrainer specs running in CI,
#   unless a RethinkDB-fan wants to take a shot at it.
# You might be inspired by the existing other services this library is currently
#   tested against (e.g. CouchDB, MongoDB)
# See: https://github.com/rethinkdb/rethinkdb/issues/6981
# Compat: Ruby >= 1.9
# Test Matrix:
#   - Ruby 2.4
#   - Ruby 2.5
#   - Ruby 2.6
#   - Ruby 2.7
#   - Ruby 3.0
#   - Ruby 3.1
#   - Ruby 3.2
#   - Ruby 3.3
#   - ruby-head
#   - truffleruby-head
#   - jruby-head
# appraise "nobrainer-0.44" do
#   gem "nobrainer", "~> 0.44", ">= 0.44.1"
#   gem "mutex_m", "~> 0.1"
#   gem "stringio", ">= 0.0.2"
# end

# Compat: Ruby >= 1.9.2
# Test Matrix:
#   - Ruby 2.4
appraise "sequel-5.86-r2.4" do
  gem "sequel", "~> 5.86", ">= 5.86.0"
  eval_gemfile "modular/activerecord/r2.4/v5.2.gemfile"
  eval_gemfile "modular/mutex_m/r2.4/v0.1.gemfile"
  eval_gemfile "modular/stringio/r2.4/v0.0.2.gemfile"
  eval_gemfile "modular/omniauth/r2/v2.0.gemfile"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Compat: Ruby >= 1.9.2
# Test Matrix:
#   - Ruby 2.5
#   - Ruby 2.6
#   - Ruby 2.7
appraise "sequel-5.86-r2" do
  gem "sequel", "~> 5.86", ">= 5.86.0"
  eval_gemfile "modular/activerecord/r2/v7.1.gemfile"
  eval_gemfile "modular/mutex_m/r2/v0.3.gemfile"
  eval_gemfile "modular/stringio/r2/v3.0.gemfile"
  eval_gemfile "modular/omniauth/r2/v2.1.gemfile"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Compat: Ruby >= 1.9.2
# Test Matrix:
#   - Ruby 3.0
appraise "sequel-5.86-r3.0" do
  gem "sequel", "~> 5.86", ">= 5.86.0"
  eval_gemfile "modular/activerecord/r3/v7.1.gemfile"
  eval_gemfile "modular/mutex_m/r2/v0.3.gemfile"
  eval_gemfile "modular/stringio/r2/v3.0.gemfile"
  eval_gemfile "modular/omniauth/r3/v2.1.gemfile"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Compat: Ruby >= 1.9.2
# Test Matrix:
#   - Ruby 3.1
#   - Ruby 3.2
#   - Ruby 3.3
#   - Ruby 3.4
#   - JRuby 9.4
#   - JRuby 10.0
#   - ruby-head
#   - truffleruby-head
#   - jruby-head
appraise "sequel-5.86-r3" do
  gem "sequel", "~> 5.86", ">= 5.86.0"
  eval_gemfile "modular/activerecord/r3/v7.1.gemfile"
  eval_gemfile "modular/mutex_m/r2/v0.3.gemfile"
  eval_gemfile "modular/stringio/r2/v3.0.gemfile"
  eval_gemfile "modular/omniauth/r3/v2.1.gemfile"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Only run security audit on the latest version of Ruby
appraise "audit" do
  eval_gemfile "modular/mutex_m/r2/v0.3.gemfile"
  eval_gemfile "modular/stringio/r2/v3.0.gemfile"
  eval_gemfile "modular/omniauth/r3/v2.1.gemfile"
  eval_gemfile "modular/audit.gemfile"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Only run coverage on the latest version of Ruby
appraise "coverage" do
  gem "couch_potato", "~> 1.17"
  gem "sequel", "~> 5.86", ">= 5.86.0"
  gem "mongoid", "~> 9.0", ">= 9.0.3"
  gem "mongoid-rspec", "~> 4.2"
  eval_gemfile "modular/activerecord/r3/v8.0.gemfile"
  eval_gemfile "modular/bson/r3/v5.0.gemfile"
  eval_gemfile "modular/mutex_m/r2/v0.3.gemfile"
  eval_gemfile "modular/stringio/r2/v3.0.gemfile"
  eval_gemfile "modular/omniauth/r3/v2.1.gemfile"
  gem "ostruct", "~> 0.6", ">= 0.6.1" # Ruby >= 2.5
  eval_gemfile "modular/coverage.gemfile"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Only run linter on the latest version of Ruby (but, in support of the oldest supported Ruby version)
appraise "style" do
  eval_gemfile "modular/mutex_m/r2/v0.3.gemfile"
  eval_gemfile "modular/stringio/r2/v3.0.gemfile"
  eval_gemfile "modular/style.gemfile"
  eval_gemfile "modular/omniauth/r3/v2.1.gemfile"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end
