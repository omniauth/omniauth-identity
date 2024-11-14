# frozen_string_literal: true

# Compat: Ruby >= 2.2.2
# Test Matrix:
#   - Ruby 2.4
appraise "ar-5-0" do
  gem "activerecord", "~> 5.0.7.2"
  gem "mutex_m", "~> 0.1"
end

# Compat: Ruby >= 2.2.2
# Test Matrix:
#   - Ruby 2.4
#   - Ruby 2.5
appraise "ar-5-1" do
  gem "activerecord", "~> 5.1.7"
  gem "mutex_m", "~> 0.1"
end

# Compat: Ruby >= 2.2.2
# Test Matrix:
#   - Ruby 2.4
#   - Ruby 2.5
#   - Ruby 2.6
#   - Ruby 2.7
appraise "ar-5-2" do
  gem "activerecord", "~> 5.2.8.1"
  gem "mutex_m", "~> 0.1"
end

# Compat: Ruby >= 2.5
# Test Matrix:
#   - Ruby 2.5
#   - Ruby 2.6
#   - Ruby 2.7
appraise "ar-6-0" do
  gem "activerecord", "~> 6.0.6.1"
  gem "mutex_m", "~> 0.2"
end

# Compat: Ruby >= 2.5
# Test Matrix:
#   - Ruby 2.5
#   - Ruby 2.6
#   - Ruby 2.7
#   - Ruby 3.0
appraise "ar-6-1" do
  gem "activerecord", "~> 6.1.7.10"
  gem "mutex_m", "~> 0.2"
end

# Compat: Ruby >= 2.7
# Test Matrix:
#   - Ruby 2.7
#   - Ruby 3.0
#   - Ruby 3.1
appraise "ar-7-0" do
  gem "activerecord", "~> 7.0.8.6"
  gem "mutex_m", "~> 0.2"
end

# Compat: Ruby >= 2.7
# Test Matrix:
#   - Ruby 2.7
#   - Ruby 3.0
#   - Ruby 3.1
#   - Ruby 3.2
appraise "ar-7-1" do
  gem "activerecord", "~> 7.1.5"
  gem "mutex_m", "~> 0.2"
end

# Compat: Ruby >= 3.1
# Test Matrix:
#   - Ruby 3.1
#   - Ruby 3.2
#   - Ruby 3.3
appraise "ar-7-2" do
  gem "activerecord", "~> 7.2.2"
  gem "mutex_m", "~> 0.2"
end

# Compat: Ruby >= 3.2
# Test Matrix:
#   - Ruby 3.2
#   - Ruby 3.3
#   - ruby-head
#   - truffleruby-head
#   - jruby-head
appraise "ar-8-0" do
  gem "activerecord", "~> 8.0.0"
  gem "mutex_m", "~> 0.2"
end

# Compat: Ruby >= 2.2.2 (due to AR >= 5)
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
appraise "couch-1.17" do
  gem "couch_potato", "~> 1.17"
  gem "mutex_m", "~> 0.1"
end

# Compat: Ruby >= 2.3
# Test Matrix:
#   - Ruby 2.4
#   - Ruby 2.5
appraise "mongoid-7.3" do
  gem "mongoid", "~> 7.3", ">= 7.3.5"
  gem "mutex_m", "~> 0.1"
end

# Compat: Ruby >= 2.5
# Test Matrix:
#   - Ruby 2.5
#   - Ruby 2.6
#   - Ruby 2.7
appraise "mongoid-7.4" do
  gem "mongoid", "~> 7.4", ">= 7.4.3"
  gem "mutex_m", "~> 0.2"
end

# Compat: Ruby >= 2.6
# Test Matrix:
#   - Ruby 2.6
#   - Ruby 2.7
#   - Ruby 3.0
#   - Ruby 3.1
#   - Ruby 3.2
#   - Ruby 3.3
appraise "mongoid-8.1" do
  gem "mongoid", "~> 8.1", ">= 8.1.7"
  gem "mutex_m", "~> 0.2"
end

# Compat: Ruby >= 2.7
# Test Matrix:
#   - Ruby 2.7
#   - Ruby 3.0
#   - Ruby 3.1
#   - Ruby 3.2
#   - Ruby 3.3
#   - ruby-head
#   - truffleruby-head
#   - jruby-head
appraise "mongoid-9.0" do
  gem "mongoid", "~> 9.0", ">= 9.0.3"
  gem "mutex_m", "~> 0.2"
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
# end

# Compat: Ruby >= 1.9.2
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
appraise "sequel-5.86" do
  gem "sequel", "~> 5.86", ">= 5.86.0"
  gem "mutex_m", "~> 0.1"
end
