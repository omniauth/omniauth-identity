# frozen_string_literal: true

require "mongoid"

module OmniAuth
  module Identity
    module Models
      # Mongoid is an ORM adapter for MongoDB:
      # https://github.com/mongodb/mongoid
      #
      # This module provides OmniAuth Identity functionality for Mongoid models,
      # including secure password handling and authentication key management.
      #
      # @example Usage
      #   class User
      #     include Mongoid::Document
      #
      #     include OmniAuth::Identity::Models::Mongoid
      #
      #     field :email, type: String
      #     field :password_digest, type: String
      #   end
      #
      #   user = User.new(email: 'user@example.com', password: 'password')
      #   user.save
      #
      #   # Authenticate a user
      #   authenticated_user = User.locate(email: 'user@example.com')
      #   authenticated_user.authenticate('password') # => user or false
      #
      # @note Mongoid is based on ActiveModel, so validations are enabled by default.
      module Mongoid
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

            # validations: true (default) incurs a dependency on ActiveModel, but Mongoid is ActiveModel based.
            has_secure_password

            # @!method self.auth_key=(key)
            # Sets the authentication key for the model and adds uniqueness validation.
            #
            # @param key [Symbol, String] the attribute to use as the authentication key
            # @return [void]
            # @example
            #   class User
            #     include OmniAuth::Identity::Models::Mongoid
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
            # @return [Mongoid::Document, nil] the first matching record or nil
            # @example
            #   User.locate(email: 'user@example.com')
            def self.locate(search_hash)
              where(search_hash).first
            end
          end
        end
      end
    end
  end
end
