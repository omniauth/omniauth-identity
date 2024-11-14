# frozen_string_literal: true

require "sequel"

module OmniAuth
  module Identity
    module Models
      # Sequel is an ORM adapter for the following databases:
      #   ADO, Amalgalite, IBM_DB, JDBC, MySQL, Mysql2, ODBC, Oracle, PostgreSQL, SQLAnywhere, SQLite3, and TinyTDS
      # The homepage is: http://sequel.jeremyevans.net/
      # NOTE: Sequel is *not* based on ActiveModel, but supports the API we need, except for `persisted?`:
      # * create
      # * save
      module Sequel
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

            def self.auth_key=(key)
              super
              # Sequel version of validates_uniqueness_of! Does not incur ActiveRecord dependency!
              validates_uniqueness_of(:key, case_sensitive: false)
            end

            # @param arguments [any] -
            #   Filtering is probably the most common dataset modifying action done in Sequel.
            #   Both the where and filter methods filter the dataset by modifying the dataset’s WHERE clause.
            #   Both accept a wide variety of input formats, which are passed as arguments below.
            #   See: https://sequel.jeremyevans.net/rdoc/files/doc/querying_rdoc.html#label-Filters
            def self.locate(arguments)
              where(arguments).first
            end

            def persisted?
              exists?
            end

            def save
              super
            end
          end
        end
      end
    end
  end
end
