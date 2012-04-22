require 'active_record'

module OmniAuth
  module Identity
    module Models
      class ActiveRecord < ::ActiveRecord::Base
        include OmniAuth::Identity::Model
        include OmniAuth::Identity::SecurePassword

        self.abstract_class = true
        has_secure_password

        # http://techblog.floorplanner.com/post/20528527222/case-insensitive-validates-uniqueness-of-slowness
        def self.auth_key=(key)
          method = super
          unless key == false
            index method, :type => :exact
            before_validation :downcase_auth_key
            validates method, :uniqueness => true
          end
          method
        end

        def self.locate(key)
          where(auth_key => key.downcase).first
        end

        def downcase_auth_key
          if self.auth_key.present?
            self.auth_key = self.auth_key.downcase
          end
        end
      end
    end
  end
end
