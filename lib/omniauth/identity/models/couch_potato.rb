# frozen_string_literal: true

require "couch_potato"

module OmniAuth
  module Identity
    module Models
      # CouchPotato is an ORM adapter for CouchDB:
      # https://github.com/langalex/couch_potato
      #
      # This module provides OmniAuth Identity functionality for CouchPotato models,
      # including secure password handling and authentication key management.
      #
      # @example Usage
      #   class User
      #     include CouchPotato::Persistence
      #
      #     include OmniAuth::Identity::Models::CouchPotatoModule
      #
      #     property :email
      #     property :password_digest
      #   end
      #
      #   user = User.new(email: 'user@example.com', password: 'password')
      #   user.save
      #
      #   # Authenticate a user
      #   authenticated_user = User.locate(email: 'user@example.com')
      #   authenticated_user.authenticate('password') # => user or false
      #
      # @note CouchPotato is based on ActiveModel, so validations are enabled by default.
      # @note CouchPotato::Persistence must be included before OmniAuth::Identity::Models::CouchPotatoModule.
      # @note Includes "Module" in the name for invalid legacy reasons. Rename only with a major version bump.
      module CouchPotatoModule
        # Called when this module is included in a model class.
        #
        # This method extends the base class with OmniAuth Identity functionality,
        # including secure password support and authentication key validation.
        #
        # @param base [Class] the model class including this module
        # @return [void]
        def self.included(base)
          base.class_eval do
            include(::OmniAuth::Identity::Model)
            include(::OmniAuth::Identity::SecurePassword)

            # validations: true (default) incurs a dependency on ActiveModel, but CouchPotato is ActiveModel based.
            has_secure_password

            # @!method self.auth_key=(key)
            # Sets the authentication key for the model and adds uniqueness validation.
            #
            # @param key [Symbol, String] the attribute to use as the authentication key
            # @return [void]
            # @example
            #   class User
            #     include OmniAuth::Identity::Models::CouchPotatoModule
            #     self.auth_key = :email
            #   end
            def self.auth_key=(key)
              super
              validates_uniqueness_of(key, case_sensitive: false)
            end

            # @!method self.locate(search_hash)
            # Finds a record by the given search criteria.
            #
            # @param search_hash [Hash] the attributes to search for
            # @return [Object, nil] the first matching record or nil
            # @example
            #   User.locate(email: 'user@example.com')
            def self.locate(search_hash)
              where(search_hash).first
            end

            # @!method save
            # Saves the document to the CouchDB database.
            #
            # @return [Boolean] true if saved successfully, false otherwise
            # @example
            #   user = User.new(email: 'user@example.com', password: 'password')
            #   user.save # => true
            def save
              CouchPotato.database.save_document(self)
            end
          end
        end
      end
    end
  end
end
