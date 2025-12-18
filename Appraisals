# frozen_string_literal: true

# HOW TO UPDATE APPRAISALS (will run rubocop_gradual's autocorrect afterward):
#   bin/rake appraisals:update

# Lock/Unlock Deps Pattern
#
# Two often conflicting goals resolved!
#
#  - unlocked_deps.yml
#    - All runtime & dev dependencies, but does not have a `gemfiles/*.gemfile.lock` committed
#    - Uses an Appraisal2 "unlocked_deps" gemfile, and the current MRI Ruby release
#    - Know when new dependency releases will break local dev with unlocked dependencies
#    - Broken workflow indicates that new releases of dependencies may not work
#
#  - locked_deps.yml
#    - All runtime & dev dependencies, and has a `Gemfile.lock` committed
#    - Uses the project's main Gemfile, and the current MRI Ruby release
#    - Matches what contributors and maintainers use locally for development
#    - Broken workflow indicates that a new contributor will have a bad time
#
appraise "unlocked_deps" do
  eval_gemfile "modular/omniauth/r3/v2.1.gemfile"
  eval_gemfile "modular/rails/r3/v8.1.gemfile"
  eval_gemfile "modular/coverage.gemfile"
  eval_gemfile "modular/documentation.gemfile"
  eval_gemfile "modular/style.gemfile"
  eval_gemfile "modular/optional.gemfile"
  eval_gemfile "modular/x_std_libs.gemfile"
  eval_gemfile "modular/integration.gemfile"
end

# Used for head (nightly) releases of ruby, truffleruby, and jruby.
# Split into discrete appraisals if one of them needs a dependency locked discretely.
appraise "head" do
  # Why is gem "cgi" here? See: https://github.com/vcr/vcr/issues/1057
  #  gem "cgi", ">= 0.5"
  gem "benchmark", "~> 0.4", ">= 0.4.1"
  eval_gemfile "modular/x_std_libs.gemfile"
  eval_gemfile "modular/rack/vHEAD.gemfile"
end

# Used for current releases of ruby, truffleruby, and jruby.
# Split into discrete appraisals if one of them needs a dependency locked discretely.
appraise "current" do
  eval_gemfile "modular/x_std_libs.gemfile"
  eval_gemfile "modular/integration.gemfile"
end

# Test current Rubies against head versions of runtime dependencies
appraise "dep-heads" do
  eval_gemfile "modular/runtime_heads.gemfile"
  # eval_gemfile "modular/integration.gemfile" # favor individual vHEAD gemfiles
  eval_gemfile "modular/combustion/vHEAD.gemfile"
  eval_gemfile "modular/hanami/vHEAD.gemfile"
  eval_gemfile "modular/rack/vHEAD.gemfile"
  eval_gemfile "modular/rails/vHEAD.gemfile"
  eval_gemfile "modular/roda/vHEAD.gemfile"
  eval_gemfile "modular/rom-sql/vHEAD.gemfile"
  eval_gemfile "modular/sequel/vHEAD.gemfile"
  eval_gemfile "modular/sinatra/vHEAD.gemfile"
end

# Compatibility: Ruby >= 2.2.2
# Test Matrix:
#   - Ruby 2.4
appraise "ar-5-2-r2.4" do
  eval_gemfile "modular/activerecord/r2.4/v5.2.gemfile"
  eval_gemfile "modular/omniauth/r2/v1.0.gemfile"
  eval_gemfile "modular/rack/r2/v1.6.gemfile"
  eval_gemfile "modular/x_std_libs/r2.4/libs.gemfile"
end

# Compatibility: Ruby >= 2.2.2
# Test Matrix:
#   - Ruby 2.5
appraise "ar-5-2-r2" do
  eval_gemfile "modular/activerecord/r2/v5.2.gemfile"
  eval_gemfile "modular/omniauth/r2/v1.1.gemfile"
  eval_gemfile "modular/rack/r2/v1.6.gemfile"
  eval_gemfile "modular/x_std_libs/r2.6/libs.gemfile"
end

# Compatibility: Ruby >= 2.5
# Test Matrix:
#   - Ruby 2.5
appraise "ar-6-0" do
  eval_gemfile "modular/activerecord/r2/v6.0.gemfile"
  eval_gemfile "modular/omniauth/r2/v1.2.gemfile"
  eval_gemfile "modular/rack/r2/v1.6.gemfile"
  eval_gemfile "modular/x_std_libs/r2.6/libs.gemfile"
end

# Compatibility: Ruby >= 2.5
# Test Matrix:
#   - JRuby 9.2
#   - Ruby 2.5
#   - JRuby 9.3
#   - Ruby 2.6
appraise "ar-6-1-r2.6" do
  eval_gemfile "modular/activerecord/r2/v6.1.gemfile"
  eval_gemfile "modular/omniauth/r2/v1.3.gemfile"
  eval_gemfile "modular/rack/r2/v1.6.gemfile"
  eval_gemfile "modular/x_std_libs/r2.6/libs.gemfile"
end

# Compatibility: Ruby >= 2.7
# Test Matrix:
#   - Ruby 2.7
appraise "ar-6-1-r2" do
  eval_gemfile "modular/activerecord/r2/v6.1.gemfile"
  eval_gemfile "modular/omniauth/r2/v1.3.gemfile"
  eval_gemfile "modular/rack/r2/v1.6.gemfile"
  eval_gemfile "modular/x_std_libs/r2/libs.gemfile"
end

# Compatibility: Ruby >= 2.5
# Test Matrix:
#   - Ruby 3.0
appraise "ar-6-1-r3" do
  eval_gemfile "modular/activerecord/r3/v6.1.gemfile"
  eval_gemfile "modular/omniauth/r3/v2.1.gemfile"
  eval_gemfile "modular/rack/r3/v3.2.gemfile"
  eval_gemfile "modular/x_std_libs/r3.1/libs.gemfile"
end

# Compatibility: Ruby >= 2.7
# Test Matrix:
#   - Ruby 2.7
appraise "ar-7-0-r2" do
  eval_gemfile "modular/activerecord/r2/v7.0.gemfile"
  eval_gemfile "modular/omniauth/r2/v1.4.gemfile"
  eval_gemfile "modular/rack/r2/v1.6.gemfile"
  eval_gemfile "modular/x_std_libs/r2/libs.gemfile"
end

# Compatibility: Ruby >= 2.7
# Test Matrix:
#   - Ruby 3.0
#   - Ruby 3.1
#   - JRuby 9.4
appraise "ar-7-0-r3" do
  eval_gemfile "modular/activerecord/r3/v7.0.gemfile"
  eval_gemfile "modular/omniauth/r3/v2.1.gemfile"
  eval_gemfile "modular/rack/r3/v3.2.gemfile"
  eval_gemfile "modular/x_std_libs/r3.1/libs.gemfile"
end

# Compatibility: Ruby >= 2.7
# Test Matrix:
#   - Ruby 2.7
appraise "ar-7-1-r2" do
  eval_gemfile "modular/activerecord/r2/v7.1.gemfile"
  eval_gemfile "modular/omniauth/r2/v1.5.gemfile"
  eval_gemfile "modular/rack/r2/v1.6.gemfile"
  eval_gemfile "modular/x_std_libs/r2/libs.gemfile"
end

# Compatibility: Ruby >= 2.7
# Test Matrix:
#   - Ruby 3.0
#   - Ruby 3.1
#   - TruffleRuby 23.1
appraise "ar-7-1-r3.1" do
  eval_gemfile "modular/activerecord/r3/v7.1.gemfile"
  eval_gemfile "modular/omniauth/r3/v2.1.gemfile"
  eval_gemfile "modular/rack/r3/v3.2.gemfile"
  eval_gemfile "modular/x_std_libs/r3.1/libs.gemfile"
end

# Compatibility: Ruby >= 2.7
# Test Matrix:
#   - Ruby 3.2
#   - Ruby 3.3
#   - Ruby 3.4
#   - JRuby 10.0
appraise "ar-7-1-r3" do
  # eval_gemfile "modular/activerecord/r3/v7.1.gemfile" # favor the dependency on rails instead
  eval_gemfile "modular/omniauth/r3/v2.1.gemfile"
  eval_gemfile "modular/rails/r3/v7.1.gemfile"
  eval_gemfile "modular/x_std_libs/r3/libs.gemfile"
  eval_gemfile "modular/integration.gemfile"
end

# Compatibility: Ruby >= 3.1
# Test Matrix:
#   - Ruby 3.3
#   - Ruby 3.4
appraise "ar-7-2" do
  # eval_gemfile "modular/activerecord/r3/v7.2.gemfile" # favor the dependency on rails instead
  eval_gemfile "modular/omniauth/r3/v2.1.gemfile"
  eval_gemfile "modular/rails/r3/v7.2.gemfile"
  eval_gemfile "modular/x_std_libs/r3/libs.gemfile"
  eval_gemfile "modular/integration.gemfile"
end

# Compatibility: Ruby >= 3.2
# Test Matrix:
#   - Ruby 3.2
#   - Ruby 3.3
#   - Ruby 3.4
appraise "ar-8-0" do
  # eval_gemfile "modular/activerecord/r3/v8.0.gemfile" # favor the dependency on rails instead
  eval_gemfile "modular/omniauth/r3/v2.1.gemfile"
  eval_gemfile "modular/rails/r3/v8.0.gemfile"
  eval_gemfile "modular/x_std_libs/r3/libs.gemfile"
  eval_gemfile "modular/integration.gemfile"
end

# Compatibility: Ruby >= 3.2
# Test Matrix:
#   - Ruby 3.2
#   - Ruby 3.3
#   - Ruby 3.4
appraise "ar-8-1" do
  # eval_gemfile "modular/activerecord/r3/v8.1.gemfile" # favor the dependency on rails instead
  eval_gemfile "modular/omniauth/r3/v2.1.gemfile"
  eval_gemfile "modular/rails/r3/v8.1.gemfile"
  eval_gemfile "modular/x_std_libs/r3/libs.gemfile"
  eval_gemfile "modular/integration.gemfile"
end

# Compatibility: Ruby >= 2.2.2 (due to AR >= 5)
# Test Matrix:
#   - Ruby 2.4
appraise "couch-1.17-r2.4" do
  gem "couch_potato", "~> 1.17"
  gem "ostruct", "~> 0.1" # Ruby >= 0, all newer releases of ostruct require Ruby >= 2.5

  eval_gemfile "modular/activerecord/r2.4/v5.2.gemfile"
  eval_gemfile "modular/omniauth/r2/v1.6.gemfile"
  eval_gemfile "modular/rack/r2/v1.6.gemfile"
  eval_gemfile "modular/x_std_libs/r2.4/libs.gemfile"
end

# Compatibility: Ruby >= 2.2.2 (due to AR >= 5)
# Test Matrix:
#   - Ruby 2.5
appraise "couch-1.17-r2.5" do
  gem "couch_potato", "~> 1.17"
  # TODO: Bump when dropping old Ruby from this gem.
  gem "ostruct", "~> 0.6", ">= 0.6.1" # Ruby >= 2.5

  eval_gemfile "modular/activerecord/r2/v6.0.gemfile"
  eval_gemfile "modular/omniauth/r2/v1.7.gemfile"
  eval_gemfile "modular/rack/r2/v1.6.gemfile"
  eval_gemfile "modular/x_std_libs/r2.6/libs.gemfile"
end

# Compatibility: Ruby >= 2.2.2 (due to AR >= 5)
# Test Matrix:
#   - Ruby 2.6
#   - JRuby 9.3
appraise "couch-1.17-r2.6" do
  gem "couch_potato", "~> 1.17"
  # TODO: Bump when dropping old Ruby from this gem.
  gem "ostruct", "~> 0.6", ">= 0.6.1" # Ruby >= 2.5

  eval_gemfile "modular/activerecord/r2/v6.1.gemfile"
  eval_gemfile "modular/omniauth/r2/v1.7.gemfile"
  eval_gemfile "modular/rack/r2/v1.6.gemfile"
  eval_gemfile "modular/x_std_libs/r2.6/libs.gemfile"
end

# Compatibility: Ruby >= 2.2.2 (due to AR >= 5)
# Test Matrix:
#   - Ruby 2.7
appraise "couch-1.17-r2.7" do
  gem "couch_potato", "~> 1.17"
  # TODO: Bump when dropping old Ruby from this gem.
  gem "ostruct", "~> 0.6", ">= 0.6.1" # Ruby >= 2.5

  eval_gemfile "modular/activerecord/r2/v6.1.gemfile"
  eval_gemfile "modular/omniauth/r2/v1.7.gemfile"
  eval_gemfile "modular/rack/r2/v1.6.gemfile"
  eval_gemfile "modular/x_std_libs/r2/libs.gemfile"
end

# Compatibility: Ruby >= 2.2.2 (due to AR >= 5)
# Test Matrix:
#   - Ruby 3.0
#   - Ruby 3.1
#   - JRuby 9.4
appraise "couch-1.17-r3.1" do
  gem "couch_potato", "~> 1.17"
  gem "ostruct", "~> 0.6", ">= 0.6.1" # Ruby >= 2.5

  eval_gemfile "modular/activerecord/r3/v7.1.gemfile"
  eval_gemfile "modular/omniauth/r3/v2.1.gemfile"
  eval_gemfile "modular/rack/r3/v3.2.gemfile"
  eval_gemfile "modular/x_std_libs/r3.1/libs.gemfile"
end

# Compatibility: Ruby >= 2.2.2 (due to AR >= 5)
# Test Matrix:
#   - Ruby 3.2
#   - Ruby 3.3
#   - Ruby 3.4
appraise "couch-1.17-r3" do
  gem "couch_potato", "~> 1.17"
  gem "ostruct", "~> 0.6", ">= 0.6.1" # Ruby >= 2.5

  # eval_gemfile "modular/activerecord/r3/v7.1.gemfile" # favor the dependency on rails instead
  eval_gemfile "modular/omniauth/r3/v2.1.gemfile"
  eval_gemfile "modular/rails/r3/v7.1.gemfile"
  eval_gemfile "modular/integration.gemfile"
  eval_gemfile "modular/x_std_libs/r3/libs.gemfile"
end

# Compatibility: Ruby >= 2.3
# Test Matrix:
#   - Ruby 2.4
appraise "mongoid-7.3-b4.12" do
  gem "mongoid", "~> 7.3", ">= 7.3.5"
  gem "mongoid-rspec", "~> 4.1"
  eval_gemfile "modular/bson/r2.4/v4.12.gemfile"

  eval_gemfile "modular/activerecord/r2.4/v5.2.gemfile"
  eval_gemfile "modular/omniauth/r2/v1.8.gemfile"
  eval_gemfile "modular/rack/r2/v1.6.gemfile"
  eval_gemfile "modular/x_std_libs/r2.4/libs.gemfile"
end

# Compatibility: Ruby >= 2.3
# Test Matrix:
#   - JRuby 9.2
appraise "mongoid-7.3-b4.15" do
  gem "mongoid", "~> 7.3", ">= 7.3.5"
  gem "mongoid-rspec", "~> 4.1"
  eval_gemfile "modular/bson/r2/v4.15.gemfile"

  eval_gemfile "modular/activerecord/r2/v6.1.gemfile"
  eval_gemfile "modular/omniauth/r2/v1.9.gemfile"
  eval_gemfile "modular/rack/r2/v1.6.gemfile"
  eval_gemfile "modular/x_std_libs/r2.6/libs.gemfile"
end

# Compatibility: Ruby >= 2.5
# Test Matrix:
#   - Ruby 2.5
#   - JRuby 9.2
#   - Ruby 2.6
appraise "mongoid-7.4-b4.15" do
  gem "mongoid", "~> 7.4", ">= 7.4.3"
  gem "mongoid-rspec", "~> 4.1"
  eval_gemfile "modular/bson/r2/v4.15.gemfile"

  eval_gemfile "modular/activerecord/r2/v6.1.gemfile"
  eval_gemfile "modular/omniauth/r2/v2.0.gemfile"
  eval_gemfile "modular/rack/r2/v1.6.gemfile"
  eval_gemfile "modular/x_std_libs/r2.6/libs.gemfile"
end

# Compatibility: Ruby >= 2.6 (because of bson v5)
# Test Matrix:
#   - JRuby 9.3
appraise "mongoid-7.4-b5" do
  gem "mongoid", "~> 7.4", ">= 7.4.3"
  gem "mongoid-rspec", "~> 4.1"
  eval_gemfile "modular/bson/r2/v5.0.gemfile"

  eval_gemfile "modular/activerecord/r2/v6.1.gemfile"
  eval_gemfile "modular/omniauth/r2/v2.0.gemfile"
  eval_gemfile "modular/rack/r2/v1.6.gemfile"
  eval_gemfile "modular/x_std_libs/r2.6/libs.gemfile"
end

# Compatibility: Ruby >= 2.6
# Test Matrix:
#   - JRuby 9.3
appraise "mongoid-8.1-r2.6" do
  gem "mongoid", "~> 8.1", ">= 8.1.7"
  gem "mongoid-rspec", "~> 4.2"
  eval_gemfile "modular/bson/r2/v5.0.gemfile"

  eval_gemfile "modular/activerecord/r2/v6.1.gemfile"
  eval_gemfile "modular/omniauth/r2/v2.0.gemfile"
  eval_gemfile "modular/rack/r2/v1.6.gemfile"
  eval_gemfile "modular/x_std_libs/r2.6/libs.gemfile"
end

# Compatibility: Ruby >= 2.7
# Test Matrix:
#   - Ruby 2.7
appraise "mongoid-8.1-r2" do
  gem "mongoid", "~> 8.1", ">= 8.1.7"
  gem "mongoid-rspec", "~> 4.2"
  eval_gemfile "modular/bson/r2/v5.0.gemfile"

  eval_gemfile "modular/activerecord/r2/v6.1.gemfile"
  eval_gemfile "modular/omniauth/r2/v2.0.gemfile"
  eval_gemfile "modular/rack/r2/v1.6.gemfile"
  eval_gemfile "modular/x_std_libs/r2/libs.gemfile"
end

# Compatibility: Ruby >= 2.6
# Test Matrix:
#   - Ruby 3.1
#   - JRuby 9.4
appraise "mongoid-8.1-r3.1" do
  gem "mongoid", "~> 8.1", ">= 8.1.7"
  gem "mongoid-rspec", "~> 4.2"
  eval_gemfile "modular/bson/r3/v5.1.gemfile"

  eval_gemfile "modular/activerecord/r3/v7.1.gemfile"
  eval_gemfile "modular/omniauth/r3/v2.1.gemfile"
  eval_gemfile "modular/rack/r3/v3.2.gemfile"
  eval_gemfile "modular/x_std_libs/r3.1/libs.gemfile"
end

# Compatibility: Ruby >= 2.6
# Test Matrix:
#   - Ruby 3.2
#   - Ruby 3.3
#   - Ruby 3.4
appraise "mongoid-8.1-r3" do
  gem "mongoid", "~> 8.1", ">= 8.1.7"
  gem "mongoid-rspec", "~> 4.2"
  eval_gemfile "modular/bson/r3/v5.1.gemfile"

  # eval_gemfile "modular/activerecord/r3/v7.1.gemfile" # favor the dependency on rails instead
  eval_gemfile "modular/omniauth/r3/v2.1.gemfile"
  eval_gemfile "modular/rails/r3/v7.1.gemfile"
  eval_gemfile "modular/rom-sql/r3/v3.7.gemfile"
  eval_gemfile "modular/sequel/r3/v5.86.gemfile"
  eval_gemfile "modular/integration.gemfile"
  eval_gemfile "modular/x_std_libs/r3/libs.gemfile"
end

# Compatibility: Ruby >= 2.7
# Test Matrix:
#   - Ruby 2.7
appraise "mongoid-9.0-r2-omni1.9" do
  gem "mongoid", "~> 9.0", ">= 9.0.3"
  gem "mongoid-rspec", "~> 4.2"
  eval_gemfile "modular/bson/r2/v5.0.gemfile"

  eval_gemfile "modular/activerecord/r2/v7.1.gemfile"
  eval_gemfile "modular/omniauth/r2/v1.9.gemfile"
  eval_gemfile "modular/rack/r2/v1.6.gemfile"
  eval_gemfile "modular/x_std_libs/r2/libs.gemfile"
  gem "ostruct", "~> 0.6", ">= 0.6.1" # Ruby >= 2.5
end

# Compatibility: Ruby >= 2.7
# Test Matrix:
#   - Ruby 2.7
appraise "mongoid-9.0-r2-omni2.0" do
  gem "mongoid", "~> 9.0", ">= 9.0.3"
  gem "mongoid-rspec", "~> 4.2"
  eval_gemfile "modular/bson/r2/v5.0.gemfile"

  eval_gemfile "modular/activerecord/r2/v7.1.gemfile"
  eval_gemfile "modular/omniauth/r2/v2.0.gemfile"
  eval_gemfile "modular/rack/r2/v1.6.gemfile"
  eval_gemfile "modular/x_std_libs/r2/libs.gemfile"
  gem "ostruct", "~> 0.6", ">= 0.6.1" # Ruby >= 2.5
end

# Compatibility: Ruby >= 2.7
# Test Matrix:
#   - Ruby 2.7
appraise "mongoid-9.0-r2-omni2.1" do
  gem "mongoid", "~> 9.0", ">= 9.0.3"
  gem "mongoid-rspec", "~> 4.2"
  eval_gemfile "modular/bson/r2/v5.0.gemfile"

  eval_gemfile "modular/activerecord/r2/v7.1.gemfile"
  eval_gemfile "modular/omniauth/r2/v2.1.gemfile"
  eval_gemfile "modular/rack/r2/v3.2.gemfile"
  eval_gemfile "modular/x_std_libs/r2/libs.gemfile"
  gem "ostruct", "~> 0.6", ">= 0.6.1" # Ruby >= 2.5
end

# Compatibility: Ruby >= 2.7
# Test Matrix:
#   - Ruby 3.0
#   - JRuby 9.4
appraise "mongoid-9.0-r3.1" do
  gem "mongoid", "~> 9.0", ">= 9.0.3"
  gem "mongoid-rspec", "~> 4.2"
  eval_gemfile "modular/bson/r3/v5.1.gemfile"

  eval_gemfile "modular/activerecord/r3/v7.1.gemfile"
  eval_gemfile "modular/omniauth/r3/v2.1.gemfile"
  eval_gemfile "modular/rack/r3/v3.2.gemfile"
  eval_gemfile "modular/x_std_libs/r3.1/libs.gemfile"
  gem "ostruct", "~> 0.6", ">= 0.6.1" # Ruby >= 2.5
end

# Compatibility: Ruby >= 2.7
# Test Matrix:
#   - Ruby 3.2
#   - Ruby 3.3
#   - Ruby 3.4
appraise "mongoid-9.0-r3" do
  gem "mongoid", "~> 9.0", ">= 9.0.3"
  gem "mongoid-rspec", "~> 4.2"
  eval_gemfile "modular/bson/r3/v5.1.gemfile"

  eval_gemfile "modular/omniauth/r3/v2.1.gemfile"
  eval_gemfile "modular/rack/r3/v3.2.gemfile"
  eval_gemfile "modular/rails/r3/v7.1.gemfile"
  eval_gemfile "modular/integration.gemfile"
  eval_gemfile "modular/x_std_libs/r3/libs.gemfile"
  gem "ostruct", "~> 0.6", ">= 0.6.1" # Ruby >= 2.5
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
# Compatibility: Ruby >= 1.9
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

# Compatibility: Ruby >= 3.1.0
# Test Matrix:
#   - Ruby 3.1
#   - TruffleRuby 23.1
#   - JRuby 9.4
appraise "rom-r3.1" do
  gem "rom-sql", "~> 3.7"
  eval_gemfile "modular/activerecord/r3/v7.1.gemfile"
  eval_gemfile "modular/omniauth/r3/v2.1.gemfile"
  eval_gemfile "modular/rack/r3/v3.2.gemfile"
  eval_gemfile "modular/x_std_libs/r3.1/libs.gemfile"
end

# Compatibility: Ruby >= 3.1.0
# Test Matrix:
#   - Ruby 3.2
#   - TruffleRuby 24.1
#   - Ruby 3.3
#   - Ruby 3.4
#   - JRuby 10.0
appraise "rom-r3" do
  eval_gemfile "modular/activerecord/r3/v7.1.gemfile"
  eval_gemfile "modular/omniauth/r3/v2.1.gemfile"
  eval_gemfile "modular/x_std_libs/r3/libs.gemfile"
  eval_gemfile "modular/integration.gemfile"
end

# Compatibility: Ruby >= 1.9.2
# Test Matrix:
#   - Ruby 2.4
appraise "sequel-5.86-r2.4" do
  eval_gemfile "modular/activerecord/r2.4/v5.2.gemfile"
  eval_gemfile "modular/omniauth/r2/v2.0.gemfile"
  eval_gemfile "modular/rack/r2/v1.6.gemfile"
  eval_gemfile "modular/sequel/r3/v5.86.gemfile"
  eval_gemfile "modular/x_std_libs/r2.4/libs.gemfile"
end

# Compatibility: Ruby >= 1.9.2
# Test Matrix:
#   - Ruby 2.5
appraise "sequel-5.86-r2.5" do
  eval_gemfile "modular/activerecord/r2/v6.0.gemfile"
  eval_gemfile "modular/omniauth/r2/v2.1.gemfile"
  eval_gemfile "modular/rack/r2/v3.2.gemfile"
  eval_gemfile "modular/sequel/r3/v5.86.gemfile"
  eval_gemfile "modular/x_std_libs/r2.6/libs.gemfile"
end

# Compatibility: Ruby >= 1.9.2
# Test Matrix:
#   - Ruby 2.6
appraise "sequel-5.86-r2.6" do
  eval_gemfile "modular/activerecord/r2/v6.1.gemfile"
  eval_gemfile "modular/omniauth/r2/v2.1.gemfile"
  eval_gemfile "modular/rack/r2/v3.2.gemfile"
  eval_gemfile "modular/sequel/r3/v5.86.gemfile"
  eval_gemfile "modular/x_std_libs/r2.6/libs.gemfile"
end

# Compatibility: Ruby >= 1.9.2
# Test Matrix:
#   - Ruby 2.7
appraise "sequel-5.86-r2.7" do
  eval_gemfile "modular/activerecord/r2/v7.1.gemfile"
  eval_gemfile "modular/omniauth/r2/v2.1.gemfile"
  eval_gemfile "modular/rack/r2/v3.2.gemfile"
  eval_gemfile "modular/sequel/r3/v5.86.gemfile"
  eval_gemfile "modular/x_std_libs/r2/libs.gemfile"
end

# Compatibility: Ruby >= 1.9.2
# Test Matrix:
#   - Ruby 3.0
#   - Ruby 3.1
appraise "sequel-5.86-r3.1" do
  eval_gemfile "modular/activerecord/r3/v7.1.gemfile"
  eval_gemfile "modular/omniauth/r3/v2.1.gemfile"
  eval_gemfile "modular/rack/r3/v3.2.gemfile"
  eval_gemfile "modular/sequel/r3/v5.86.gemfile"
  eval_gemfile "modular/x_std_libs/r3.1/libs.gemfile"
end

# Compatibility: Ruby >= 1.9.2
# Test Matrix:
#   - Ruby 3.2
#   - Ruby 3.3
#   - Ruby 3.4
#   - JRuby 10.0
appraise "sequel-5.86-r3" do
  # eval_gemfile "modular/activerecord/r3/v7.1.gemfile" # favor the dependency on rails instead
  eval_gemfile "modular/omniauth/r3/v2.1.gemfile"
  eval_gemfile "modular/rails/r3/v7.1.gemfile"
  eval_gemfile "modular/integration.gemfile"
  eval_gemfile "modular/x_std_libs/r3/libs.gemfile"
end

# Only run security audit on the latest version of Ruby
appraise "audit" do
  eval_gemfile "modular/omniauth/r3/v2.1.gemfile"
  eval_gemfile "modular/x_std_libs.gemfile"
end

# Only run coverage on the latest version of Ruby
appraise "coverage" do
  gem "couch_potato", "~> 1.17"
  gem "mongoid", "~> 9.0", ">= 9.0.3"
  gem "mongoid-rspec", "~> 4.2"
  # eval_gemfile "modular/activerecord/r3/v8.0.gemfile" # favor the dependency on rails instead
  eval_gemfile "modular/bson/r3/v5.1.gemfile"
  eval_gemfile "modular/omniauth/r3/v2.1.gemfile"
  eval_gemfile "modular/rails/r3/v8.0.gemfile" # TODO: Once mongoid support AR v8.1, update here
  eval_gemfile "modular/coverage.gemfile"
  gem "ostruct", "~> 0.6", ">= 0.6.1" # Ruby >= 2.5
  eval_gemfile "modular/optional.gemfile"
  eval_gemfile "modular/x_std_libs.gemfile"
  eval_gemfile "modular/integration.gemfile"
end

# Only run linter on the latest version of Ruby (but, in support of oldest supported Ruby version)
appraise "style" do
  eval_gemfile "modular/style.gemfile"
  eval_gemfile "modular/omniauth/r3/v2.1.gemfile"
  eval_gemfile "modular/x_std_libs.gemfile"
end
