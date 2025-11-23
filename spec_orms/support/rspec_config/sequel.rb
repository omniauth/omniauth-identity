# frozen_string_literal: true

require "logger"

# :nocov:
DB = if RUBY_ENGINE == "jruby"
  require "jdbc/sqlite3"
  require "sequel"
  Sequel.connect("jdbc:sqlite::memory:")
else
  require "sqlite3"
  require "sequel"
  Sequel.connect("sqlite::memory:")
end
# :nocov:
