# frozen_string_literal: true

require "kettle/soup/cover/config"

SimpleCov.start do
  add_filter "/rethinkdb_data/"
  add_filter "/spec_orms/"
end
