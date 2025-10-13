# frozen_string_literal: true

require "logger"

# :nocov:
ROM_DB = if RUBY_ENGINE == "jruby"
  require "jdbc/sqlite3"
  require "sequel"
  Sequel.connect("jdbc:sqlite::memory:rom")
else
  require "sqlite3"
  require "sequel"
  Sequel.connect("sqlite::memory:rom")
end
# :nocov:

require "rom"
require "rom-sql"

# Define the ROM relations
class RomTestIdentities < ROM::Relation[:sql]
  schema(:rom_test_identities) do
    attribute :id, ROM::SQL::Types::Serial
    attribute :email, ROM::SQL::Types::String
    attribute :login, ROM::SQL::Types::String
    attribute :password_digest, ROM::SQL::Types::String
    attribute :pwd_hash, ROM::SQL::Types::String
    attribute :owner_id, ROM::SQL::Types::Integer
  end
end

class RomTestOwners < ROM::Relation[:sql]
  schema(:rom_test_owners) do
    attribute :id, ROM::SQL::Types::Serial
    attribute :name, ROM::SQL::Types::String
  end
end

# Set up ROM container
ROM_CONFIG = ROM::Configuration.new(:sql, ROM_DB)
ROM_CONFIG.register_relation(RomTestIdentities)
ROM_CONFIG.register_relation(RomTestOwners)
ROM_CONTAINER = ROM.container(ROM_CONFIG)

class RomTestIdentity
  include OmniAuth::Identity::Models::Rom

  # Configure via the new DSL (no `self.`): accepts a value or a proc
  rom_container -> { ROM_CONTAINER }
  rom_relation_name :rom_test_identities
  # Use the standard Model.auth_key API to configure the auth key
  auth_key :email
  password_field :password_digest

  # Provide a simple reader for the :login attribute for specs that use a
  # non-standard auth key (e.g. `auth_key :login`). The ROM adapter stores the
  # underlying tuple in @identity_data, so delegate to it here.
  def login
    @identity_data && @identity_data[:login]
  end
end
