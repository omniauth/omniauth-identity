# frozen_string_literal: true

require 'active_record'

module OmniAuth
  module Identity
    module Models
      # ActiveRecord is an ORM for MySQL, PostgreSQL, and SQLite3:
      #   https://guides.rubyonrails.org/active_record_basics.html
      # NOTE: ActiveRecord is based on ActiveModel.
      class ActiveRecord < ::ActiveRecord::Base
        include ::OmniAuth::Identity::Model
        include ::OmniAuth::Identity::SecurePassword

        self.abstract_class = true
        # validations: true (default) incurs a dependency on ActiveModel, but ActiveRecord is ActiveModel based.
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
