# frozen_string_literal: true

require "bcrypt"

module OmniAuth
  module Identity
    # This is lightly edited from Rails 6.1 code and is used if
    # the version of ActiveModel that's being used does not
    # include SecurePassword. The only difference is that instead of
    # using ActiveSupport::Concern, it checks to see if there is already
    # a has_secure_password method.
    #
    # Provides secure password hashing and authentication using BCrypt.
    #
    # @example Basic Usage
    #   class User
    #     include OmniAuth::Identity::SecurePassword
    #
    #     has_secure_password
    #   end
    #
    #   user = User.new(password: 'secret')
    #   user.authenticate('secret') # => user
    module SecurePassword
      # Called when this module is included in a model class.
      #
      # Extends the base class with ClassMethods unless it already responds to has_secure_password.
      #
      # @param base [Class] the model class including this module
      # @return [void]
      def self.included(base)
        base.extend(ClassMethods) unless base.respond_to?(:has_secure_password)
      end

      # @!attribute [r] MAX_PASSWORD_LENGTH_ALLOWED
      # BCrypt hash function can handle maximum 72 bytes, and if we pass
      # password of length more than 72 bytes it ignores extra characters.
      # Hence need to put a restriction on password length.
      # @return [Integer] The maximum allowed password length in bytes.
      MAX_PASSWORD_LENGTH_ALLOWED = BCrypt::Engine::MAX_SECRET_BYTESIZE

      class << self
        # @!attribute [rw] min_cost
        # Controls whether to use minimum cost for BCrypt hashing (for testing).
        # @return [true, false]
        attr_accessor :min_cost # :nodoc:
      end
      self.min_cost = false

      # @module ClassMethods
      # Class-level methods for secure password functionality.
      module ClassMethods
        # Adds methods to set and authenticate against a BCrypt password.
        # This mechanism requires you to have a +XXX_digest+ attribute.
        # Where +XXX+ is the attribute name of your desired password.
        #
        # For Supported ActiveModel-based ORMs:
        #
        #  * ActiveRecord
        #  * CouchPotato
        #  * Mongoid
        #  * NoBrainer
        #
        # the following validations are added automatically:
        #
        # * Password must be present on creation
        # * Password length should be less than or equal to 72 bytes
        # * Confirmation of password (using a +XXX_confirmation+ attribute)
        #
        # If confirmation validation is not needed, simply leave out the
        # value for +XXX_confirmation+ (i.e. don't provide a form field for
        # it). When this attribute has a +nil+ value, the validation will not be
        # triggered.
        #
        # For Supported non-ActiveModel-based ORMs:
        #
        #  * Sequel
        #
        # validations are disabled by default.
        #
        # It is possible to disable the default validations in any ORM
        # by passing <tt>validations: false</tt> as an argument.
        #
        # Add bcrypt (~> 3.1.7) to Gemfile to use #has_secure_password:
        #
        #   gem 'bcrypt', '~> 3.1.7'
        #
        # Example using Active Record (which automatically includes ActiveModel::SecurePassword):
        #
        #   # Schema: User(name:string, password_digest:string, recovery_password_digest:string)
        #   class User < ActiveRecord::Base
        #     has_secure_password
        #     has_secure_password :recovery_password, validations: false
        #   end
        #
        #   user = User.new(name: 'david', password: '', password_confirmation: 'nomatch')
        #   user.save                                                  # => false, password required
        #   user.password = 'mUc3m00RsqyRe'
        #   user.save                                                  # => false, confirmation doesn't match
        #   user.password_confirmation = 'mUc3m00RsqyRe'
        #   user.save                                                  # => true
        #   user.recovery_password = "42password"
        #   user.recovery_password_digest                              # => "$2a$04$iOfhwahFymCs5weB3BNH/uXkTG65HR.qpW.bNhEjFP3ftli3o5DQC"
        #   user.save                                                  # => true
        #   user.authenticate('notright')                              # => false
        #   user.authenticate('mUc3m00RsqyRe')                         # => user
        #   user.authenticate_recovery_password('42password')          # => user
        #   User.find_by(name: 'david')&.authenticate('notright')      # => false
        #   User.find_by(name: 'david')&.authenticate('mUc3m00RsqyRe') # => user
        #
        # @param attribute [Symbol, String] the attribute name for the password (default: :password)
        # @param validations [true, false] whether to add validations (default: true)
        # @return [void]
        def has_secure_password(attribute = :password, validations: true)
          # Load bcrypt gem only when has_secure_password is used.
          # This is to avoid ActiveModel (and by extension the entire framework)
          # being dependent on a binary library.
          begin
            require "bcrypt"
          rescue LoadError
            warn("You don't have bcrypt installed in your application. Please add it to your Gemfile and run bundle install")
            raise
          end

          include(InstanceMethodsOnActivation.new(attribute))

          if validations
            if !defined?(ActiveModel)
              warn("[DEPRECATION][omniauth-identity v3.1][w/ Sequel ORM] has_secure_password(validations: true) is default, but incurs dependency on ActiveModel. v4 will default to `has_secure_password(validations: false)`.")
              begin
                require "active_model"
              rescue LoadError
                warn("You don't have active_model installed in your application. Please add it to your Gemfile and run bundle install")
                raise
              end
            end
            include(ActiveModel::Validations)

            # This ensures the model has a password by checking whether the password_digest
            # is present, so that this works with both new and existing records. However,
            # when there is an error, the message is added to the password attribute instead
            # so that the error message will make sense to the end-user.
            validate do |record|
              record.errors.add(attribute, :blank) unless record.public_send(:"#{attribute}_digest").present?
            end

            validates_length_of(attribute, maximum: MAX_PASSWORD_LENGTH_ALLOWED)
            validates_confirmation_of(attribute, allow_blank: true)
          end
        end
      end

      # @class InstanceMethodsOnActivation
      # A module that defines instance methods for password handling.
      # Methods are defined dynamically based on the attribute name.
      class InstanceMethodsOnActivation < Module
        # Initializes the module with the password attribute name.
        #
        # @param attribute [Symbol, String] the password attribute name
        def initialize(attribute)
          attr_reader(attribute)

          define_method(:"#{attribute}=") do |unencrypted_password|
            if unencrypted_password.nil?
              public_send(:"#{attribute}_digest=", nil)
            elsif !unencrypted_password.empty?
              instance_variable_set(:"@#{attribute}", unencrypted_password)
              cost = if defined?(ActiveModel::SecurePassword)
                ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
              else
                BCrypt::Engine.cost
              end
              public_send(:"#{attribute}_digest=", BCrypt::Password.create(unencrypted_password, cost: cost))
            end
          end

          define_method(:"#{attribute}_confirmation=") do |unencrypted_password|
            instance_variable_set(:"@#{attribute}_confirmation", unencrypted_password)
          end

          # Returns +self+ if the password is correct, otherwise +false+.
          #
          #   class User < ActiveRecord::Base
          #     has_secure_password validations: false
          #   end
          #
          #   user = User.new(name: 'david', password: 'mUc3m00RsqyRe')
          #   user.save
          #   user.authenticate_password('notright')      # => false
          #   user.authenticate_password('mUc3m00RsqyRe') # => user
          define_method(:"authenticate_#{attribute}") do |unencrypted_password|
            attribute_digest = public_send(:"#{attribute}_digest")
            BCrypt::Password.new(attribute_digest).is_password?(unencrypted_password) && self
          end

          alias_method(:authenticate, :authenticate_password) if attribute == :password
        end
      end
    end
  end
end
