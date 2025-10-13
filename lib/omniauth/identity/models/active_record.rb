# frozen_string_literal: true

require "active_record"

module OmniAuth
  module Identity
    module Models
      # ActiveRecord is an ORM for MySQL, PostgreSQL, and SQLite3:
      # https://guides.rubyonrails.org/active_record_basics.html
      #
      # This class provides a base for OmniAuth Identity models using ActiveRecord,
      # including secure password handling and authentication key management.
      #
      # @example Usage
      #   class User < OmniAuth::Identity::Models::ActiveRecord
      #     # Add your fields here, e.g.:
      #     # self.table_name = 'users'
      #     # has_many :posts
      #   end
      #
      #   # Migration example:
      #   # create_table :users do |t|
      #   #   t.string :email, null: false
      #   #   t.string :password_digest, null: false
      #   #   t.timestamps
      #   # end
      #
      #   user = User.new(email: 'user@example.com', password: 'password')
      #   user.save
      #
      #   # Authenticate a user
      #   authenticated_user = User.locate(email: 'user@example.com')
      #   authenticated_user.authenticate('password') # => user or false
      #
      # @note ActiveRecord is based on ActiveModel, so validations are enabled by default.
      # @note This is an abstract class; inherit from it to create your user model.
      class ActiveRecord < ::ActiveRecord::Base
        include ::OmniAuth::Identity::Model
        include ::OmniAuth::Identity::SecurePassword

        self.abstract_class = true
        # validations: true (default) incurs a dependency on ActiveModel, but ActiveRecord is ActiveModel based.
        has_secure_password

        # @!method self.auth_key=(key)
        # Sets the authentication key for the model and adds uniqueness validation.
        #
        # @param key [Symbol, String] the attribute to use as the authentication key
        # @return [void]
        # @example
        #   class User < OmniAuth::Identity::Models::ActiveRecord
        #     self.auth_key = :email
        #   end
        def self.auth_key=(key)
          super
          validates_uniqueness_of(key, case_sensitive: false)
        end

        # @!method self.locate(search_hash)
        # Finds a record by the given search criteria.
        #
        # If the model has a 'provider' column, it defaults to 'identity'.
        #
        # @param search_hash [Hash] the attributes to search for
        # @return [ActiveRecord::Base, nil] the first matching record or nil
        # @example
        #   User.locate(email: 'user@example.com')
        def self.locate(search_hash)
          search_hash = search_hash.reverse_merge!("provider" => "identity") if column_names.include?("provider")
          where(search_hash).first
        end
      end
    end
  end
end
