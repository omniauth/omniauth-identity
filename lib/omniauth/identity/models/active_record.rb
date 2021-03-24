# frozen_string_literal: true

require 'active_record'

module OmniAuth
  module Identity
    module Models
      class ActiveRecord < ::ActiveRecord::Base
        include ::OmniAuth::Identity::Model
        include ::OmniAuth::Identity::SecurePassword

        self.abstract_class = true
        has_secure_password

        def self.auth_key=(key)
          super
          validates_uniqueness_of key, case_sensitive: false
        end

        def self.locate(search_hash)
          search_hash = search_hash.reverse_merge!('provider' => 'identity') if column_names.include?('provider')
          where(search_hash).first
        end
      end
    end
  end
end
