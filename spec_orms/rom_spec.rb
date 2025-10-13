# frozen_string_literal: true

require_relative "support/rspec_config/rom"

RSpec.describe(OmniAuth::Identity::Models::Rom, :sqlite3) do
  before(:all) do
    # Create the tables
    ROM_DB.create_table(:rom_test_identities) do
      primary_key :id
      String :email, null: false
      String :password_digest, null: false
      # Add the login column to support tests that use a non-standard auth_key
      String :login
      Integer :owner_id
    end

    ROM_DB.create_table(:rom_test_owners) do
      primary_key :id
      String :name, null: false
    end
  end

  before do
    # Clear the tables before each test
    ROM_DB[:rom_test_identities].delete
    ROM_DB[:rom_test_owners].delete
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

      it "finds a record by custom auth key (login) when auth_key is set to :login" do
        # Temporarily switch the auth key to :login using the public Model.auth_key API
        original = model_klass.auth_key
        model_klass.auth_key :login

        begin
          # Insert test data using the login field
          identity_data = {login: "bob", email: "bob@example.com", password_digest: BCrypt::Password.create("secret")}
          ROM_CONTAINER.relations[:rom_test_identities].insert(identity_data)

          located = model_klass.locate("bob")
          expect(located).to(be_a(RomTestIdentity))
          expect(located.login).to(eq("bob"))
        ensure
          # Restore original auth_key to avoid leaking state between tests
          model_klass.auth_key original
        end
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

      it "authenticates with custom auth_key (login) when auth_key is set to :login" do
        original = model_klass.auth_key
        model_klass.auth_key :login

        begin
          # Insert test data using login field
          password_digest = BCrypt::Password.create("password")
          identity_data = {login: "bob", email: "bob@example.com", password_digest: password_digest}
          ROM_CONTAINER.relations[:rom_test_identities].insert(identity_data)

          authenticated = model_klass.authenticate({login: "bob"}, "password")
          expect(authenticated).to(be_a(RomTestIdentity))
          expect(authenticated.login).to(eq("bob"))
        ensure
          model_klass.auth_key original
        end
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
        model_klass.owner_relation_name :rom_test_owners

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
