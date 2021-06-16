# frozen_string_literal: true

require 'sequel'

module OmniAuth
  module Identity
    module Models
      # http://sequel.jeremyevans.net/ an SQL ORM
      # NOTE: Sequel is *not* based on ActiveModel, but supports the API we need, except for `persisted?`:
      # * create
      # * save
      module Sequel
        def self.included(base)
          base.class_eval do
            # NOTE: Using the deprecated :validations_class_methods because it defines
            #       validates_confirmation_of, while current :validation_helpers does not.
            # plugin :validation_helpers
            plugin :validation_class_methods

            include ::OmniAuth::Identity::Model
            include ::OmniAuth::Identity::SecurePassword

            has_secure_password

            def self.auth_key=(key)
              super
              validates_uniqueness_of :key, case_sensitive: false
            end

            def self.locate(search_hash)
              where(search_hash).first
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
