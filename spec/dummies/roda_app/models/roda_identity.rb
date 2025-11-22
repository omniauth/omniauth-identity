# frozen_string_literal: true

require "rom"
require "rom-sql"
require "bcrypt"
require "sequel"
require "omniauth/identity/models/rom"

# Set up database connection
RODA_ROM_DB = Sequel.connect("sqlite::memory:")

# Create the identities table
RODA_ROM_DB.create_table?(:roda_identities) do
  primary_key :id
  String :name, null: false
  String :email, null: false, unique: true
  String :password_digest, null: false
  Time :created_at, null: false
  Time :updated_at, null: false
end

# Define the ROM relation class
class RodaIdentities < ROM::Relation[:sql]
  schema(:roda_identities, infer: true) do
    attribute :id, ROM::SQL::Types::Serial
    attribute :name, ROM::SQL::Types::String
    attribute :email, ROM::SQL::Types::String
    attribute :password_digest, ROM::SQL::Types::String
    attribute :created_at, ROM::SQL::Types::Time
    attribute :updated_at, ROM::SQL::Types::Time
  end

  auto_struct true
end

# Set up ROM container
ROM_CONFIG = ROM::Configuration.new(:sql, RODA_ROM_DB)
ROM_CONFIG.register_relation(RodaIdentities)
ROM_CONTAINER = ROM.container(ROM_CONFIG)

# RodaIdentity class using ROM adapter
class RodaIdentity
  include OmniAuth::Identity::Models::Rom

  # Configure ROM
  rom_container ROM_CONTAINER
  rom_relation_name :roda_identities
  password_field :password_digest
  auth_key :email

  class << self
    # Create a new identity
    # Returns the created identity on success, or an unpersisted identity on failure
    def create(attributes)
      # Validate required fields
      unless attributes[:name] && !attributes[:name].to_s.strip.empty?
        return new_unpersisted(attributes.merge(password_digest: nil))
      end

      unless attributes[:email] && !attributes[:email].to_s.strip.empty?
        return new_unpersisted(attributes.merge(password_digest: nil))
      end

      unless attributes[:password] && !attributes[:password].to_s.strip.empty?
        return new_unpersisted(attributes.merge(password_digest: nil))
      end

      # Validate password confirmation matches
      if attributes[:password_confirmation] && attributes[:password] != attributes[:password_confirmation]
        return new_unpersisted(attributes.merge(password_digest: nil))
      end

      # Hash password
      attributes[:password_digest] = BCrypt::Password.create(attributes[:password])
      attributes.delete(:password)
      attributes.delete(:password_confirmation)

      # Add timestamps
      now = Time.now
      attributes[:created_at] ||= now
      attributes[:updated_at] ||= now

      # Insert directly via Sequel for simplicity
      begin
        RODA_ROM_DB[:roda_identities].insert(attributes)
        # Fetch and return the created identity
        locate(email: attributes[:email])
      rescue Sequel::UniqueConstraintViolation, Sequel::ConstraintViolation
        # Return an unpersisted identity on validation failure
        # This allows the strategy to detect the failure via persisted? => false
        new_unpersisted(attributes)
      end
    end

    # Create an unpersisted identity (for validation failures)
    def new_unpersisted(attributes)
      identity_data = {
        id: nil,
        name: attributes[:name],
        email: attributes[:email],
        password_digest: attributes[:password_digest],
        created_at: attributes[:created_at],
        updated_at: attributes[:updated_at],
      }
      new(identity_data)
    end

    # Ready the database (for compatibility with other adapters)
    def ready!(_db = nil)
      # ROM is already initialized, nothing to do
      true
    end

    # Clear all identities (for testing)
    def delete_all
      RODA_ROM_DB[:roda_identities].delete
    end
  end
end
