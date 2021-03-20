# frozen_string_literal: true

require 'mongoid'

module OmniAuth
  module Identity
    module Models
      # NOTE: Mongoid is based on ActiveModel.
      module Mongoid
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
          end
        end
      end
    end
  end
end
