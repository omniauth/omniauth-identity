# frozen_string_literal: true

require "logger"

# simplecov:disable
DB = if RUBY_ENGINE == "jruby"
  require "jdbc/sqlite3"
  require "sequel"
  Sequel.connect("jdbc:sqlite::memory:")
else
  require "sqlite3"
  require "sequel"
  Sequel.sqlite
end
# simplecov:enable
