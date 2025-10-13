# frozen_string_literal: true

require "bcrypt"

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
      #     # Configure the ROM container and relation
      #     self.rom_container = -> { MyDatabase.rom } # See spec_orms/rom_spec.rb for example
      #     self.rom_relation_name = :identities
      #     self.owner_relation_name = :owners  # optional, for loading associated owner
      #     self.auth_key_field = :email  # optional, defaults to :email
      #     self.password_field = :password_digest  # optional, defaults to :password_digest
      #   end
      module Rom
        def self.included(base)
          base.include(::OmniAuth::Identity::Model)
          base.extend(ClassMethods)

          base.class_eval do
            # OmniAuth::Identity required method
            # Authenticates the instance with the provided password
            #
            # @param password [String] The password to check
            # @return [self, false] Self if authenticated, false if not
            def authenticate(password)
              password_digest = @identity_data[@password_field || :password_digest]
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
          attr_accessor :rom_container, :rom_relation_name, :owner_relation_name, :auth_key_field, :password_field

          # OmniAuth::Identity required method
          def auth_key
            @auth_key_field || :email
          end

          # OmniAuth::Identity required method
          # Locates a user based on the provided conditions
          #
          # @param conditions [Hash] The search conditions
          # @return [Object, nil] An instance of the identity model or nil if not found
          def locate(conditions)
            key = conditions.is_a?(Hash) ? conditions[auth_key] || conditions[auth_key.to_s] : conditions
            container = rom_container.respond_to?(:call) ? rom_container.call : rom_container
            relation = container.relations[rom_relation_name || :identities]
            identity_data = relation.where(auth_key => key).one

            if identity_data
              # Load the associated owner if configured
              if @owner_relation_name && identity_data[:owner_id]
                owner_relation = container.relations[@owner_relation_name]
                owner_data = owner_relation.where(id: identity_data[:owner_id]).one
                new(identity_data, owner_data)
              else
                new(identity_data)
              end
            end
          end
        end

        # Instance methods for OmniAuth::Identity compatibility
        attr_reader :uid, :email, :name, :info, :owner

        def initialize(identity_data, owner_data = nil)
          @identity_data = identity_data
          @owner_data = owner_data
          @uid = identity_data[:id]
          @email = identity_data[:email]

          # Get name from owner if available, otherwise use email
          @name = if owner_data && owner_data[:name]
            owner_data[:name]
          else
            identity_data[:email]
          end

          @info = {
            "email" => @email,
            "name" => @name,
          }

          # Expose owner for application use
          @owner = owner_data
        end

        # Access to the underlying identity data hash
        def [](key)
          @identity_data[key]
        end

        # Access to owner data
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
