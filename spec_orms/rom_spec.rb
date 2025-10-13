# frozen_string_literal: true

# Bugfixes
# JRuby needed an explicit "require 'logger'" for Rails < 7.1
# See: https://github.com/rails/rails/issues/54260#issuecomment-2594650047
# Placing above omniauth because it is a dependency of omniauth,
#   which is undeclared in older versions.
require "logger"

# :nocov:
DB = if RUBY_ENGINE == "jruby"
  require "jdbc/sqlite3"
  require "sequel"
  Sequel.connect("jdbc:sqlite::memory:")
else
  require "sqlite3"
  require "sequel"
  Sequel.sqlite
end
# :nocov:

require "rom"
require "rom-sql"

# Define the ROM relations
class RomTestIdentities < ROM::Relation[:sql]
  schema(:rom_test_identities) do
    attribute :id, ROM::SQL::Types::Serial
    attribute :email, ROM::SQL::Types::String
    attribute :password_digest, ROM::SQL::Types::String
    attribute :owner_id, ROM::SQL::Types::Integer
  end
end

class RomTestOwners < ROM::Relation[:sql]
  schema(:rom_test_owners) do
    attribute :id, ROM::SQL::Types::Serial
    attribute :name, ROM::SQL::Types::String
  end
end

RSpec.describe(OmniAuth::Identity::Models::Rom, :sqlite3) do
  ROM_CONTAINER = begin
    # Set up ROM container with Sequel adapter
    rom_config = ROM::Configuration.new(:sql, DB)
    rom_config.register_relation(RomTestIdentities)
    rom_config.register_relation(RomTestOwners)
    ROM.container(rom_config)
  end

  before(:all) do
    # Create the tables
    DB.create_table(:rom_test_identities) do
      primary_key :id
      String :email, null: false
      String :password_digest, null: false
      Integer :owner_id
    end

    DB.create_table(:rom_test_owners) do
      primary_key :id
      String :name, null: false
    end
  end

  before do
    # Clear the tables before each test
    DB[:rom_test_identities].delete
    DB[:rom_test_owners].delete

    rom_test_identity = Class.new do
      include OmniAuth::Identity::Models::Rom

      self.rom_container = ROM_CONTAINER
      self.rom_relation_name = :rom_test_identities
      self.auth_key_field = :email
      self.password_field = :password_digest
    end
    stub_const("RomTestIdentity", rom_test_identity)
  end

  describe "model", type: :model do
    subject(:model_klass) { RomTestIdentity }

    include_context "model with class methods"

    describe "::locate" do
      it "finds a record by auth key" do
        # Insert test data
        identity_data = {email: "test@example.com", password_digest: BCrypt::Password.create("password")}
        ROM_CONTAINER.relations[:rom_test_identities].insert(identity_data)

        located = model_klass.locate("test@example.com")
        expect(located).to(be_a(RomTestIdentity))
        expect(located.email).to(eq("test@example.com"))
      end

      it "returns nil if not found" do
        located = model_klass.locate("nonexistent@example.com")
        expect(located).to(be_nil)
      end
    end

    describe "::authenticate" do
      it "authenticates with correct password" do
        # Insert test data
        password_digest = BCrypt::Password.create("password")
        identity_data = {email: "test@example.com", password_digest: password_digest}
        ROM_CONTAINER.relations[:rom_test_identities].insert(identity_data)

        authenticated = model_klass.authenticate({email: "test@example.com"}, "password")
        expect(authenticated).to(be_a(RomTestIdentity))
        expect(authenticated.email).to(eq("test@example.com"))
      end

      it "returns false with incorrect password" do
        # Insert test data
        password_digest = BCrypt::Password.create("password")
        identity_data = {email: "test@example.com", password_digest: password_digest}
        ROM_CONTAINER.relations[:rom_test_identities].insert(identity_data)

        authenticated = model_klass.authenticate({email: "test@example.com"}, "wrong")
        expect(authenticated).to(be(false))
      end

      it "returns false for non-existent user" do
        authenticated = model_klass.authenticate({email: "nonexistent@example.com"}, "password")
        expect(authenticated).to(be(false))
      end
    end

    describe "owner_relation_name" do
      it "loads associated owner data when owner_relation_name is configured" do
        # Set up owner_relation_name
        model_klass.owner_relation_name = :rom_test_owners

        # Insert owner data
        owner_data = {name: "John Doe"}
        owner_id = ROM_CONTAINER.relations[:rom_test_owners].insert(owner_data)

        # Insert identity data with owner_id
        identity_data = {email: "test@example.com", password_digest: BCrypt::Password.create("password"), owner_id: owner_id}
        ROM_CONTAINER.relations[:rom_test_identities].insert(identity_data)

        located = model_klass.locate("test@example.com")
        expect(located).to(be_a(RomTestIdentity))
        expect(located.email).to(eq("test@example.com"))
        expect(located.name).to(eq("John Doe"))
        expect(located.owner).to(eq({id: owner_id, name: "John Doe"}))
      end
    end
  end
end
