# frozen_string_literal: true

require "nobrainer"

module OmniAuth
  module Identity
    module Models
      # NoBrainer is an ORM adapter for RethinkDB:
      #   http://nobrainer.io/
      # NOTE: NoBrainer is based on ActiveModel.
      module NoBrainer
        def self.included(base)
          base.class_eval do
            include(::OmniAuth::Identity::Model)
            include(::OmniAuth::Identity::SecurePassword)

            # validations: true (default) incurs a dependency on ActiveModel, but NoBrainer is ActiveModel based.
            has_secure_password

            def self.auth_key=(key)
              super
              validates_uniqueness_of(key, case_sensitive: false)
            end

            def self.locate(search_hash)
              where(search_hash).first
            end
          end
        end
      end
    end
  end
end
