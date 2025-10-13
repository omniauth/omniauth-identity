# frozen_string_literal: true

require "sequel"

module OmniAuth
  module Identity
    module Models
      # Sequel is an ORM adapter for the following databases:
      # ADO, Amalgalite, IBM_DB, JDBC, MySQL, Mysql2, ODBC, Oracle, PostgreSQL, SQLAnywhere, SQLite3, and TinyTDS
      # The homepage is: http://sequel.jeremyevans.net/
      #
      # This module provides OmniAuth Identity functionality for Sequel models,
      # including secure password handling and authentication key management.
      #
      # @example Usage
      #   class User < Sequel::Model(:users)
      #     include OmniAuth::Identity::Models::Sequel
      #   end
      #
      #   # Schema example:
      #   # DB.create_table :users do
      #   #   primary_key :id
      #   #   String :email, null: false, unique: true
      #   #   String :password_digest, null: false
      #   # end
      #
      #   user = User.new(email: 'user@example.com', password: 'password')
      #   user.save
      #
      #   # Authenticate a user
      #   authenticated_user = User.locate(email: 'user@example.com')
      #   authenticated_user.authenticate('password') # => user or false
      #
      # @note Sequel is *not* based on ActiveModel, but supports the API we need, except for `persisted?`.
      # @note Validations are enabled by default in versions < 4, but may change to disabled in v4 if ActiveModel is not present.
      module Sequel
        # Called when this module is included in a model class.
        #
        # This method extends the base class with OmniAuth Identity functionality,
        # including secure password support and authentication key validation.
        #
        # @param base [Class] the model class including this module
        # @return [void]
        def self.included(base)
          base.class_eval do
            # NOTE: Using the deprecated :validations_class_methods because it defines
            #       validates_confirmation_of, while current :validation_helpers does not.
            # plugin :validation_helpers
            plugin(:validation_class_methods)

            include(::OmniAuth::Identity::Model)
            include(::OmniAuth::Identity::SecurePassword)

            # `validations: true` (default) would normally incur a dependency on ActiveModel.
            # Starting in v3.1 we check if ActiveModel is defined before we actually set validations.
            # If ActiveModel isn't defined, it may be unexpected that validations are not being set,
            #   so this will result in a warning deprecation until release of v4,
            #   at which point the default (for Sequel ORM only) will change to `validations: false`
            has_secure_password(validations: OmniAuth::Identity::Version.major < 4)

            class << self
              # @!method self.auth_key=(key)
              # Sets the authentication key for the model and adds uniqueness validation.
              #
              # @param key [Symbol, String] the attribute to use as the authentication key
              # @return [void]
              # @example
              #   class User < Sequel::Model(:users)
              #     include OmniAuth::Identity::Models::Sequel
              #     self.auth_key = :email
              #   end
              def auth_key=(key)
                super
                # Sequel version of validates_uniqueness_of! Does not incur ActiveRecord dependency!
                validates_uniqueness_of(:key, case_sensitive: false)
              end

              # @!method self.locate(arguments)
              # Finds a record by the given search criteria.
              #
              # Filtering is probably the most common dataset modifying action done in Sequel.
              # Both the where and filter methods filter the dataset by modifying the dataset's WHERE clause.
              # Both accept a wide variety of input formats.
              # See: https://sequel.jeremyevans.net/rdoc/files/doc/querying_rdoc.html#label-Filters
              #
              # @param arguments [any] the search criteria
              # @return [Sequel::Model, nil] the first matching record or nil
              # @example
              #   User.locate(email: 'user@example.com')
              def locate(arguments)
                where(arguments).first
              end
            end

            # @!method persisted?
            # Checks if the record exists in the database.
            #
            # @return [Boolean] true if the record exists, false otherwise
            # @example
            #   user = User.new
            #   user.persisted? # => false
            #   user.save
            #   user.persisted? # => true
            def persisted?
              exists?
            end

            # @!method save
            # Saves the record to the database.
            #
            # @return [Boolean] true if saved successfully, false otherwise
            # @example
            #   user = User.new(email: 'user@example.com', password: 'password')
            #   user.save # => true
            def save
              super
            end
          end
        end
      end
    end
  end
end
