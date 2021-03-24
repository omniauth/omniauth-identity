# frozen_string_literal: true

require 'couch_potato'

module OmniAuth
  module Identity
    module Models
      # can not be named CouchPotato since there is a class with that name
      # NOTE: CouchPotato is based on ActiveModel.
      # NOTE: CouchPotato::Persistence must be included before OmniAuth::Identity::Models::CouchPotatoModule
      module CouchPotatoModule
        def self.included(base)
          base.class_eval do
            include ::OmniAuth::Identity::Model
            include ::OmniAuth::Identity::SecurePassword

            has_secure_password

            def self.auth_key=(key)
              super
              validates_uniqueness_of key, case_sensitive: false
            end

            def self.locate(search_hash)
              where(search_hash).first
            end

            def save
              CouchPotato.database.save(self)
            end
          end
        end
      end
    end
  end
end
