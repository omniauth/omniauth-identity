# frozen_string_literal: true

require "couch_potato"

module OmniAuth
  module Identity
    module Models
      # CouchPotato is an ORM adapter for CouchDB:
      #   https://github.com/langalex/couch_potato
      # NOTE: CouchPotato is based on ActiveModel.
      # NOTE: CouchPotato::Persistence must be included before OmniAuth::Identity::Models::CouchPotatoModule
      # NOTE: Includes "Module" in the name for invalid legacy reasons. Rename only with a major version bump.
      module CouchPotatoModule
        def self.included(base)
          base.class_eval do
            include(::OmniAuth::Identity::Model)
            include(::OmniAuth::Identity::SecurePassword)

            # validations: true (default) incurs a dependency on ActiveModel, but CouchPotato is ActiveModel based.
            has_secure_password

            def self.auth_key=(key)
              super
              validates_uniqueness_of(key, case_sensitive: false)
            end

            def self.locate(search_hash)
              where(search_hash).first
            end

            def save
              CouchPotato.database.save_document(self)
            end
          end
        end
      end
    end
  end
end
