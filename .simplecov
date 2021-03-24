# frozen_string_literal: true

SimpleCov.start do
  add_filter '/.github/'
  add_filter '/coverage/'
  add_filter '/rethinkdb_data/'
  add_filter '/spec/'
  add_filter '/spec_orms/'
  add_filter '/vendor/bundle/'
end
