require 'dm-core'
require 'dm-validations'

module OmniAuth
  module Identity
    module Models
      module DataMapper
        def self.included(base)
          base.class_eval do
            include OmniAuth::Identity::Model
            include OmniAuth::Identity::SecurePassword

            # http://api.rubyonrails.org/classes/ActiveRecord/Persistence.html#method-i-persisted-3F
            # http://rubydoc.info/github/mongoid/mongoid/master/Mongoid/State#persisted%3F-instance_method
            alias persisted? valid?

            has_secure_password

            def self.auth_key=(key)
              super
              validates_uniqueness_of :key
            end

            def self.locate(search_hash)
              all(search_hash).first
            end
          end
        end
      end # DataMapper
    end
  end
end
