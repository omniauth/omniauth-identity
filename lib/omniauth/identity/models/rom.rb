# frozen_string_literal: true

require "bcrypt"

require "rom"
require "rom-sql"

module OmniAuth
  module Identity
    module Models
      # ROM adapter for OmniAuth::Identity
      # This provides a reusable adapter that makes ROM entities compatible with OmniAuth::Identity
      #
      # Usage:
      #   class Identity
      #     include OmniAuth::Identity::Models::Rom
      #
      #     # Configure the ROM container and relation using the DSL (no `self.`):
      #     rom_container -> { MyDatabase.rom } # accepts a proc or a container object
      #     rom_relation_name :identities # optional, defaults to :identities
      #     owner_relation_name :owners  # optional, for loading associated owner
      #     # Uses OmniAuth::Identity::Model.auth_key to set the auth key (defaults to :email)
      #     auth_key :email
      #     # Optional: override the password digest field name (defaults to :password_digest)
      #     password_field :password_digest
      #   end
      module Rom
        def self.included(base)
          # Align with other adapters: rely on OmniAuth::Identity::Model for API
          base.include(::OmniAuth::Identity::Model)
          base.extend(ClassMethods)

          base.class_eval do
            # OmniAuth::Identity required instance API
            # Authenticates the instance with the provided password
            # Returns self on success, false otherwise (to match Model.authenticate contract)
            def authenticate(password)
              digest_key = self.class.password_field
              password_digest = @identity_data[digest_key]
              return false unless password_digest

              begin
                BCrypt::Password.new(password_digest) == password && self
              rescue BCrypt::Errors::InvalidHash
                false
              end
            end
          end
        end

        module ClassMethods
          # Default ROM relation name when none is configured
          DEFAULT_RELATION_NAME = :identities

          # Configuration DSL
          # These methods act like the DSL on `OmniAuth::Identity::Model` (e.g. `auth_key`) —
          # when called with an argument they set the configuration, and when called
          # without an argument they return the current value (with sensible defaults).
          def rom_container(value = false)
            @rom_container = value unless value == false
            container = @rom_container
            container.respond_to?(:call) ? container.call : container
          end

          def rom_relation_name(value = false)
            @rom_relation_name = value unless value == false
            @rom_relation_name || DEFAULT_RELATION_NAME
          end

          def owner_relation_name(value = false)
            @owner_relation_name = value unless value == false
            @owner_relation_name
          end

          def password_field(value = false)
            @password_field = value unless value == false
            (@password_field || :password_digest).to_sym
          end

          # Align with other adapters: use Model.auth_key (getter/setter) for the login attribute
          # Model.auth_key returns a String; convert to Symbol for ROM queries when needed.
          def auth_key_symbol
            (auth_key || "email").to_sym
          end

          # Locate an identity given conditions (Hash) or a raw key value.
          # Mirrors other adapters by accepting a conditions hash.
          # Returns an instance or nil.
          def locate(conditions)
            key_value = if conditions.is_a?(Hash)
              conditions[auth_key_symbol] || conditions[auth_key.to_s]
            else
              conditions
            end
            return nil if key_value.nil?

            relation = rom_container.relations[rom_relation_name]
            identity_data = relation.where(auth_key_symbol => key_value).one
            return nil unless identity_data

            if owner_relation_name && identity_data[:owner_id]
              owner_data = rom_container.relations[owner_relation_name].where(id: identity_data[:owner_id]).one
              new(identity_data, owner_data)
            else
              new(identity_data)
            end
          end
        end

        # Instance shape matches other adapters for downstream usage
        attr_reader :uid, :email, :name, :info, :owner

        def initialize(identity_data, owner_data = nil)
          @identity_data = identity_data
          @owner_data = owner_data
          @uid = identity_data[:id]
          @email = identity_data[:email]

          # Prefer owner name if available, else fall back to email
          @name = if owner_data && owner_data[:name]
            owner_data[:name]
          else
            identity_data[:email]
          end

          @info = {
            "email" => @email,
            "name" => @name,
          }

          @owner = owner_data
        end

        # Hash-like access to underlying ROM tuple
        def [](key)
          @identity_data[key]
        end

        # Convenience accessor for owner id
        def owner_id
          @identity_data[:owner_id]
        end

        # OmniAuth info hash
        def to_hash
          @info
        end
      end
    end
  end
end
