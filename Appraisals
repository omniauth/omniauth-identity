# frozen_string_literal: true

# HOW TO UPDATE APPRAISALS:
#   BUNDLE_GEMFILE=Appraisal.root.gemfile bundle
#   BUNDLE_GEMFILE=Appraisal.root.gemfile bundle exec appraisal update

# Used for HEAD (nightly) releases of ruby, truffleruby, and jruby.
# Split into discrete appraisals if one of them needs a dependency locked discretely.
appraise "ar-head" do
  gem "mutex_m", ">= 0.2"
  gem "stringio", ">= 3.0"
  eval_gemfile "modular/ar_heads.gemfile"
  eval_gemfile "modular/runtime_heads.gemfile"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Used for current releases of ruby, truffleruby, and jruby.
# Split into discrete appraisals if one of them needs a dependency locked discretely.
appraise "current" do
  gem "mutex_m", ">= 0.2"
  gem "stringio", ">= 3.0"
  eval_gemfile "modular/omniauth_v2_1.gemfile"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
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
  gem "stringio", ">= 0.0.2"
  gem "sqlite3", "~> 1.3", platforms: [:ruby]
  eval_gemfile "modular/omniauth_v1_0.gemfile"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Compat: Ruby >= 2.5
# Test Matrix:
#   - Ruby 2.5
#   - Ruby 2.6
#   - Ruby 2.7
appraise "ar-6-0" do
  gem "activerecord", "~> 6.0.6.1"
  gem "mutex_m", "~> 0.2"
  gem "stringio", "~> 3.0"
  gem "sqlite3", "~> 1.4", platforms: [:ruby]
  eval_gemfile "modular/omniauth_v1_1.gemfile"
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
  gem "activerecord", "~> 6.1.7.10"
  gem "mutex_m", "~> 0.1"
  gem "stringio", "~> 3.0"
  gem "sqlite3", "~> 1.4", platforms: [:ruby]
  platforms :jruby do
    gem "jdbc-sqlite3" # github: "jruby/activerecord-jdbc-adapter", branch: '61-stable'
    # gem 'jdbc-mysql', # github: "jruby/activerecord-jdbc-adapter", branch: '61-stable'
    # gem 'jdbc-postgres', # github: "jruby/activerecord-jdbc-adapter", branch: '61-stable'
    gem "activerecord-jdbc-adapter", "~> 61.0" # github: "jruby/activerecord-jdbc-adapter", branch: '61-stable'
    gem "activerecord-jdbcsqlite3-adapter", "~> 61.0" # github: "jruby/activerecord-jdbc-adapter", branch: '61-stable'
    # gem "activerecord-jdbcmysql-adapter", "~> 71.0" # github: "jruby/activerecord-jdbc-adapter", branch: '61-stable'
    # gem "activerecord-jdbcpostgresql-adapter", "~> 71.0" # github: "jruby/activerecord-jdbc-adapter", branch: '61-stable'
  end
  eval_gemfile "modular/omniauth_v1_2.gemfile"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Compat: Ruby >= 2.5
# Test Matrix:
#   - Ruby 3.0
appraise "ar-6-1-r3" do
  gem "activerecord", "~> 6.1.7.10"
  gem "mutex_m", "~> 0.1"
  gem "stringio", "~> 3.0"
  gem "sqlite3", "~> 1.4", platforms: [:ruby]
  platforms :jruby do
    gem "jdbc-sqlite3" # github: "jruby/activerecord-jdbc-adapter", branch: '61-stable'
    # gem 'jdbc-mysql', # github: "jruby/activerecord-jdbc-adapter", branch: '61-stable'
    # gem 'jdbc-postgres', # github: "jruby/activerecord-jdbc-adapter", branch: '61-stable'
    gem "activerecord-jdbc-adapter", "~> 61.0" # github: "jruby/activerecord-jdbc-adapter", branch: '61-stable'
    gem "activerecord-jdbcsqlite3-adapter", "~> 61.0" # github: "jruby/activerecord-jdbc-adapter", branch: '61-stable'
    # gem "activerecord-jdbcmysql-adapter", "~> 71.0" # github: "jruby/activerecord-jdbc-adapter", branch: '61-stable'
    # gem "activerecord-jdbcpostgresql-adapter", "~> 71.0" # github: "jruby/activerecord-jdbc-adapter", branch: '61-stable'
  end
  eval_gemfile "modular/omniauth_v2_1.gemfile"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Compat: Ruby >= 2.7
# Test Matrix:
#   - Ruby 2.7
appraise "ar-7-0-r2" do
  gem "activerecord", "~> 7.0.8.6"
  gem "mutex_m", "~> 0.2"
  gem "stringio", "~> 3.0"
  gem "sqlite3", "~> 1.4", platforms: [:ruby]
  platforms :jruby do
    gem "jdbc-sqlite3" # github: "jruby/activerecord-jdbc-adapter", branch: '61-stable'
    # gem 'jdbc-mysql', # github: "jruby/activerecord-jdbc-adapter", branch: '61-stable'
    # gem 'jdbc-postgres', # github: "jruby/activerecord-jdbc-adapter", branch: '61-stable'
    gem "activerecord-jdbc-adapter", "~> 70.0" # github: "jruby/activerecord-jdbc-adapter", branch: '61-stable'
    gem "activerecord-jdbcsqlite3-adapter", "~> 70.0" # github: "jruby/activerecord-jdbc-adapter", branch: '61-stable'
    # gem "activerecord-jdbcmysql-adapter", "~> 71.0" # github: "jruby/activerecord-jdbc-adapter", branch: '61-stable'
    # gem "activerecord-jdbcpostgresql-adapter", "~> 71.0" # github: "jruby/activerecord-jdbc-adapter", branch: '61-stable'
  end

  eval_gemfile "modular/omniauth_v1_3.gemfile"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Compat: Ruby >= 2.7
# Test Matrix:
#   - Ruby 3.0
#   - Ruby 3.1
appraise "ar-7-0-r3" do
  gem "activerecord", "~> 7.0.8.6"
  gem "mutex_m", "~> 0.2"
  gem "stringio", "~> 3.0"
  gem "sqlite3", "~> 1.4", platforms: [:ruby]
  platforms :jruby do
    gem "jdbc-sqlite3" # github: "jruby/activerecord-jdbc-adapter", branch: '61-stable'
    # gem 'jdbc-mysql', # github: "jruby/activerecord-jdbc-adapter", branch: '61-stable'
    # gem 'jdbc-postgres', # github: "jruby/activerecord-jdbc-adapter", branch: '61-stable'
    gem "activerecord-jdbc-adapter", "~> 70.0" # github: "jruby/activerecord-jdbc-adapter", branch: '61-stable'
    gem "activerecord-jdbcsqlite3-adapter", "~> 70.0" # github: "jruby/activerecord-jdbc-adapter", branch: '61-stable'
    # gem "activerecord-jdbcmysql-adapter", "~> 71.0" # github: "jruby/activerecord-jdbc-adapter", branch: '61-stable'
    # gem "activerecord-jdbcpostgresql-adapter", "~> 71.0" # github: "jruby/activerecord-jdbc-adapter", branch: '61-stable'
  end

  eval_gemfile "modular/omniauth_v2_1.gemfile"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Compat: Ruby >= 2.7
# Test Matrix:
#   - Ruby 2.7
appraise "ar-7-1-r2" do
  gem "activerecord", "~> 7.1.5"
  gem "mutex_m", "~> 0.2"
  gem "stringio", "~> 3.0"
  gem "sqlite3", "~> 1.5", platforms: [:ruby]
  platforms :jruby do
    gem "jdbc-sqlite3" # github: "jruby/activerecord-jdbc-adapter", branch: '61-stable'
    # gem 'jdbc-mysql', # github: "jruby/activerecord-jdbc-adapter", branch: '61-stable'
    # gem 'jdbc-postgres', # github: "jruby/activerecord-jdbc-adapter", branch: '61-stable'
    gem "activerecord-jdbc-adapter", "~> 71.0" # github: "jruby/activerecord-jdbc-adapter", branch: '61-stable'
    gem "activerecord-jdbcsqlite3-adapter", "~> 71.0" # github: "jruby/activerecord-jdbc-adapter", branch: '61-stable'
    # gem "activerecord-jdbcmysql-adapter", "~> 71.0" # github: "jruby/activerecord-jdbc-adapter", branch: '61-stable'
    # gem "activerecord-jdbcpostgresql-adapter", "~> 71.0" # github: "jruby/activerecord-jdbc-adapter", branch: '61-stable'
  end
  eval_gemfile "modular/omniauth_v1_4.gemfile"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Compat: Ruby >= 2.7
# Test Matrix:
#   - Ruby 3.0
#   - Ruby 3.1
#   - Ruby 3.2
#   - JRuby 10.0
appraise "ar-7-1-r3" do
  gem "activerecord", "~> 7.1.5"
  gem "mutex_m", "~> 0.2"
  gem "stringio", "~> 3.0"
  gem "sqlite3", "~> 1.5", platforms: [:ruby]
  platforms :jruby do
    gem "jdbc-sqlite3" # github: "jruby/activerecord-jdbc-adapter", branch: '61-stable'
    # gem 'jdbc-mysql', # github: "jruby/activerecord-jdbc-adapter", branch: '61-stable'
    # gem 'jdbc-postgres', # github: "jruby/activerecord-jdbc-adapter", branch: '61-stable'
    gem "activerecord-jdbc-adapter", "~> 71.0" # github: "jruby/activerecord-jdbc-adapter", branch: '61-stable'
    gem "activerecord-jdbcsqlite3-adapter", "~> 71.0" # github: "jruby/activerecord-jdbc-adapter", branch: '61-stable'
    # gem "activerecord-jdbcmysql-adapter", "~> 71.0" # github: "jruby/activerecord-jdbc-adapter", branch: '61-stable'
    # gem "activerecord-jdbcpostgresql-adapter", "~> 71.0" # github: "jruby/activerecord-jdbc-adapter", branch: '61-stable'
  end
  eval_gemfile "modular/omniauth_v2_1.gemfile"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Compat: Ruby >= 3.1
# Test Matrix:
#   - JRuby 9.4
#   - Ruby 3.1
#   - Ruby 3.2
#   - Ruby 3.3
#   - JRuby 10.0
#   - jruby-head
appraise "ar-7-2" do
  gem "activerecord", "~> 7.2.2"
  gem "mutex_m", "~> 0.2"
  gem "stringio", "~> 3.0"
  gem "sqlite3", "~> 1.6", platforms: [:ruby]

  # NOTE: JRuby is still working on compatibility with Rails 7.2
  platforms :jruby do
    gem "activerecord-jdbc-adapter", github: "jruby/activerecord-jdbc-adapter", branch: "master"
    gem "activerecord-jdbcsqlite3-adapter", github: "jruby/activerecord-jdbc-adapter", branch: "master"
    gem "jdbc-sqlite3", github: "jruby/activerecord-jdbc-adapter", branch: "master"
    # gem "activerecord-jdbc-adapter", github: "JesseChavez/activerecord-jdbc-adapter", branch: "stable-dev"
    # gem "activerecord-jdbcsqlite3-adapter", github: "JesseChavez/activerecord-jdbc-adapter", branch: "stable-dev"
    # gem "jdbc-sqlite3", github: "JesseChavez/activerecord-jdbc-adapter", branch: "stable-dev"
  end

  # platforms :jruby do
  # # gem "jdbc-sqlite3", github: "jruby/activerecord-jdbc-adapter", branch: "master"
  # # gem "jdbc-mysql", github: "jruby/activerecord-jdbc-adapter", branch: "master"
  # # gem "jdbc-postgres", github: "jruby/activerecord-jdbc-adapter", branch: "master"
  # gem "activerecord-jdbc-adapter", github: "jruby/activerecord-jdbc-adapter", branch: "master"
  # gem "activerecord-jdbcsqlite3-adapter", github: "jruby/activerecord-jdbc-adapter", branch: "master"
  # # gem "activerecord-jdbcmysql-adapter", github: "jruby/activerecord-jdbc-adapter", branch: "master"
  # # gem "activerecord-jdbcpostgresql-adapter", github: "jruby/activerecord-jdbc-adapter", branch: "master"
  # end
  eval_gemfile "modular/omniauth_v2_1.gemfile"
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
  gem "activerecord", "~> 8.0.0"
  gem "mutex_m", "~> 0.2"
  gem "stringio", "~> 3.0"
  gem "sqlite3", ">= 1.7", platforms: [:ruby]

  # NOTE: JRuby is still working on compatibility with Rails 7.2
  #       There is no way to install for Rails 8
  # platforms :jruby do
  #   gem "activerecord-jdbc-adapter", github: "JesseChavez/activerecord-jdbc-adapter", branch: "stable-dev"
  #   # gem "activerecord-jdbcsqlite3-adapter", github: "JesseChavez/activerecord-jdbc-adapter", branch: "stable-dev"
  #   gem "jdbc-sqlite3", "~> 3.46", ">= 3.46.1.1"
  # # gem "jdbc-sqlite3", github: "jruby/activerecord-jdbc-adapter", branch: "master"
  # # gem "jdbc-mysql", github: "jruby/activerecord-jdbc-adapter", branch: "master"
  # # gem "jdbc-postgres", github: "jruby/activerecord-jdbc-adapter", branch: "master"
  # gem "activerecord-jdbc-adapter", github: "jruby/activerecord-jdbc-adapter", branch: "master"
  # gem "activerecord-jdbcsqlite3-adapter", github: "jruby/activerecord-jdbc-adapter", branch: "master"
  # # gem "activerecord-jdbcmysql-adapter", github: "jruby/activerecord-jdbc-adapter", branch: "master"
  # # gem "activerecord-jdbcpostgresql-adapter", github: "jruby/activerecord-jdbc-adapter", branch: "master"
  # end
  eval_gemfile "modular/omniauth_v2_1.gemfile"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Compat: Ruby >= 2.2.2 (due to AR >= 5)
# Test Matrix:
#   - Ruby 2.4
#   - Ruby 2.5
#   - Ruby 2.6
#   - Ruby 2.7
appraise "couch-1.17-r2" do
  gem "couch_potato", "~> 1.17"
  gem "mutex_m", "~> 0.1"
  gem "sqlite3", ">= 1", platforms: [:ruby]
  gem "stringio", ">= 0.0.2"
  # TODO: Bump when old dropping old Ruby from this gem.
  gem "ostruct", "~> 0.1" # Ruby >= 0, all newer releases of ostruct require Ruby >= 2.5

  platforms :jruby do
    gem "jdbc-sqlite3", github: "jruby/activerecord-jdbc-adapter", branch: "master"
  end
  eval_gemfile "modular/omniauth_v1_6.gemfile"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Compat: Ruby >= 2.2.2 (due to AR >= 5)
# Test Matrix:
#   - JRuby 9.3
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
  gem "mutex_m", "~> 0.1"
  gem "sqlite3", ">= 1", platforms: [:ruby]
  gem "stringio", ">= 0.0.2"
  # TODO: Bump when old dropping old Ruby from this gem.
  gem "ostruct", "~> 0.1" # Ruby >= 0, all newer releases of ostruct require Ruby >= 2.5

  platforms :jruby do
    gem "jdbc-sqlite3", github: "jruby/activerecord-jdbc-adapter", branch: "master"
  end

  eval_gemfile "modular/omniauth_v2_1.gemfile"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Compat: Ruby >= 2.3
# Test Matrix:
#   - Ruby 2.4
#   - Ruby 2.5
appraise "mongoid-7.3" do
  gem "mongoid", "~> 7.3", ">= 7.3.5"
  gem "mongoid-rspec", "~> 4.1"
  gem "mutex_m", "~> 0.1"
  gem "sqlite3", ">= 1", platforms: [:ruby]
  gem "stringio", ">= 0.0.2"

  platforms :jruby do
    gem "jdbc-sqlite3", github: "jruby/activerecord-jdbc-adapter", branch: "master"
  end

  eval_gemfile "modular/omniauth_v1_7.gemfile"
  eval_gemfile "modular/bson_v5.gemfile"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Compat: Ruby >= 2.5
# Test Matrix:
#   - Ruby 2.5
#   - JRuby 9.2
#   - Ruby 2.6
#   - Ruby 2.7
appraise "mongoid-7.4" do
  gem "mongoid", "~> 7.4", ">= 7.4.3"
  gem "mongoid-rspec", "~> 4.1"
  gem "mutex_m", "~> 0.2"
  gem "sqlite3", ">= 1", platforms: [:ruby]
  gem "stringio", "~> 3.0"

  platforms :jruby do
    gem "jdbc-sqlite3", github: "jruby/activerecord-jdbc-adapter", branch: "master"
  end

  eval_gemfile "modular/omniauth_v1_9.gemfile"
  eval_gemfile "modular/bson_v5.gemfile"
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
  gem "mutex_m", "~> 0.2"
  gem "sqlite3", ">= 1", platforms: [:ruby]
  gem "stringio", "~> 3.0"

  platforms :jruby do
    gem "jdbc-sqlite3", github: "jruby/activerecord-jdbc-adapter", branch: "master"
  end

  eval_gemfile "modular/omniauth_v2_0.gemfile"
  eval_gemfile "modular/bson_v5.gemfile"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Compat: Ruby >= 2.6
# Test Matrix:
#   - Ruby 3.0
#   - Ruby 3.1
#   - JRuby 9.4
#   - Ruby 3.2
#   - Ruby 3.3
#   - Ruby 3.4
appraise "mongoid-8.1-r3" do
  gem "mongoid", "~> 8.1", ">= 8.1.7"
  gem "mongoid-rspec", "~> 4.2"
  gem "mutex_m", "~> 0.2"
  gem "sqlite3", ">= 1", platforms: [:ruby]
  gem "stringio", "~> 3.0"

  platforms :jruby do
    gem "jdbc-sqlite3", github: "jruby/activerecord-jdbc-adapter", branch: "master"
  end

  eval_gemfile "modular/omniauth_v2_1.gemfile"
  eval_gemfile "modular/bson_v5.gemfile"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Compat: Ruby >= 2.7
# Test Matrix:
#   - Ruby 2.7
appraise "mongoid-9.0-r2-omni1.9" do
  gem "mongoid", "~> 9.0", ">= 9.0.3"
  gem "mongoid-rspec", "~> 4.2"
  gem "mutex_m", "~> 0.2"
  gem "sqlite3", ">= 1", platforms: [:ruby]
  gem "stringio", "~> 3.1", ">= 3.1.2"
  # TODO: Bump when old dropping old Ruby from this gem.
  gem "ostruct", "~> 0.1" # Ruby >= 0, all newer releases of ostruct require Ruby >= 2.5

  platforms :jruby do
    gem "jdbc-sqlite3", github: "jruby/activerecord-jdbc-adapter", branch: "master"
  end

  eval_gemfile "modular/omniauth_v1_9.gemfile"
  eval_gemfile "modular/bson_v5.gemfile"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Compat: Ruby >= 2.7
# Test Matrix:
#   - Ruby 2.7
appraise "mongoid-9.0-r2-omni2.0" do
  gem "mongoid", "~> 9.0", ">= 9.0.3"
  gem "mongoid-rspec", "~> 4.2"
  gem "mutex_m", "~> 0.2"
  gem "sqlite3", ">= 1", platforms: [:ruby]
  gem "stringio", "~> 3.1", ">= 3.1.2"
  # TODO: Bump when old dropping old Ruby from this gem.
  gem "ostruct", "~> 0.1" # Ruby >= 0, all newer releases of ostruct require Ruby >= 2.5

  platforms :jruby do
    gem "jdbc-sqlite3", github: "jruby/activerecord-jdbc-adapter", branch: "master"
  end

  eval_gemfile "modular/omniauth_v2_0.gemfile"
  eval_gemfile "modular/bson_v5.gemfile"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Compat: Ruby >= 2.7
# Test Matrix:
#   - Ruby 2.7
appraise "mongoid-9.0-r2-omni2.1" do
  gem "mongoid", "~> 9.0", ">= 9.0.3"
  gem "mongoid-rspec", "~> 4.2"
  gem "mutex_m", "~> 0.2"
  gem "sqlite3", ">= 1", platforms: [:ruby]
  gem "stringio", "~> 3.1", ">= 3.1.2"
  # TODO: Bump when old dropping old Ruby from this gem.
  gem "ostruct", "~> 0.1" # Ruby >= 0, all newer releases of ostruct require Ruby >= 2.5

  platforms :jruby do
    gem "jdbc-sqlite3", github: "jruby/activerecord-jdbc-adapter", branch: "master"
  end

  eval_gemfile "modular/omniauth_v2_1.gemfile"
  eval_gemfile "modular/bson_v5.gemfile"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Compat: Ruby >= 2.7
# Test Matrix:
#   - Ruby 3.0
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
  gem "mutex_m", "~> 0.2"
  gem "sqlite3", ">= 1", platforms: [:ruby]
  gem "stringio", "~> 3.1", ">= 3.1.2"
  # TODO: Bump when old dropping old Ruby from this gem.
  gem "ostruct", "~> 0.1" # Ruby >= 0, all newer releases of ostruct require Ruby >= 2.5

  platforms :jruby do
    gem "jdbc-sqlite3", github: "jruby/activerecord-jdbc-adapter", branch: "master"
  end

  eval_gemfile "modular/omniauth_v2_1.gemfile"
  eval_gemfile "modular/bson_v5.gemfile"
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
#   - Ruby 2.5
#   - Ruby 2.6
#   - Ruby 2.7
appraise "sequel-5.86-r2" do
  gem "sequel", "~> 5.86", ">= 5.86.0"
  gem "mutex_m", "~> 0.1"
  gem "stringio", ">= 0.0.2"
  gem "sqlite3", ">= 1", platforms: [:ruby]

  platforms :jruby do
    gem "jdbc-sqlite3", github: "jruby/activerecord-jdbc-adapter", branch: "master"
  end

  eval_gemfile "modular/omniauth_v2_0.gemfile"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Compat: Ruby >= 1.9.2
# Test Matrix:
#   - Ruby 3.0
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
  gem "mutex_m", "~> 0.1"
  gem "stringio", ">= 0.0.2"
  gem "sqlite3", ">= 1", platforms: [:ruby]

  platforms :jruby do
    gem "jdbc-sqlite3", github: "jruby/activerecord-jdbc-adapter", branch: "master"
  end

  eval_gemfile "modular/omniauth_v2_1.gemfile"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Only run security audit on the latest version of Ruby
appraise "audit" do
  gem "mutex_m", "~> 0.2"
  gem "stringio", "~> 3.0"
  eval_gemfile "modular/audit.gemfile"
  eval_gemfile "modular/omniauth_v2_1.gemfile"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Only run coverage on the latest version of Ruby
appraise "coverage" do
  gem "activerecord", "~> 8.0.0"
  gem "couch_potato", "~> 1.17"
  gem "sequel", "~> 5.86", ">= 5.86.0"
  gem "mongoid", "~> 9.0", ">= 9.0.3"
  gem "mongoid-rspec", "~> 4.2"
  gem "mutex_m", "~> 0.2"
  gem "ostruct", "~> 0.1" # Ruby >= 0, all newer releases of ostruct require Ruby >= 2.5
  gem "stringio", "~> 3.0"
  gem "sqlite3", ">= 1.7", platforms: [:ruby]
  eval_gemfile "modular/coverage.gemfile"
  eval_gemfile "modular/omniauth_v2_1.gemfile"
  eval_gemfile "modular/bson_v5.gemfile"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Only run linter on the latest version of Ruby (but, in support of the oldest supported Ruby version)
appraise "style" do
  gem "mutex_m", "~> 0.2"
  gem "stringio", "~> 3.0"
  eval_gemfile "modular/style.gemfile"
  eval_gemfile "modular/omniauth_v2_1.gemfile"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end
