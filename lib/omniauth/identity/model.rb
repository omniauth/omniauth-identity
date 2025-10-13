# frozen_string_literal: true

module OmniAuth
  module Identity
    # This module provides an include-able interface for implementing the
    # necessary API for OmniAuth Identity to properly locate identities
    # and provide all necessary information.
    #
    # All methods marked as abstract must be implemented in the
    # including class for things to work properly.
    #
    # ### Singleton API
    #
    # * locate(key)
    # * create(*args) - Deprecated in v3.0.5; Will be removed in v4.0
    #
    # ### Instance API
    #
    # * save
    # * persisted?
    # * authenticate(password)
    #
    # @example Including the Model
    #   class User
    #     include OmniAuth::Identity::Model
    #     # Implement required methods...
    #   end
    module Model
      # @!attribute [r] SCHEMA_ATTRIBUTES
      # Standard OmniAuth schema attributes that may be stored in the model.
      # @return [Array<String>] List of attribute names.
      SCHEMA_ATTRIBUTES = %w[name email nickname first_name last_name location description image phone].freeze

      class << self
        # Called when this module is included in a model class.
        #
        # Extends the base class with ClassMethods and includes necessary APIs
        # if they are not already defined.
        #
        # @param base [Class] the model class including this module
        # @return [void]
        def included(base)
          base.extend(ClassMethods)
          base.extend(ClassCreateApi) unless base.respond_to?(:create)
          i_methods = base.instance_methods
          base.include(InstanceSaveApi) unless i_methods.include?(:save)
          base.include(InstancePersistedApi) unless i_methods.include?(:persisted?)
        end
      end

      # Class-level methods for OmniAuth Identity models.
      module ClassMethods
        # Authenticate a user with the given key and password.
        #
        # @param [String] conditions The unique login key provided for a given identity.
        # @param [String] password The presumed password for the identity.
        # @return [Model, false] An instance of the identity model class or false if authentication fails.
        def authenticate(conditions, password)
          instance = locate(conditions)
          return false unless instance

          instance.authenticate(password)
        end

        # Used to set or retrieve the method that will be used to get
        # and set the user-supplied authentication key.
        #
        # @param method [String, Symbol, false] The method name to set, or false to retrieve.
        # @return [String] The method name.
        def auth_key(method = false)
          @auth_key = method.to_s unless method == false
          @auth_key = nil if !defined?(@auth_key) || @auth_key == ""

          @auth_key || "email"
        end

        # Locate an identity given its unique login key.
        #
        # @abstract Subclasses must implement this method.
        # @param [String] _key The unique login key.
        # @return [Model] An instance of the identity model class.
        def locate(_key)
          raise NotImplementedError
        end
      end

      # @module ClassCreateApi
      # Provides a create method for models that don't have one.
      module ClassCreateApi
        # Persists a new Identity object to the ORM.
        # Only included if the class doesn't define create, as a reminder to define create.
        # Override as needed per ORM.
        #
        # @deprecated v4.0 will begin using {#new} with {#save} instead.
        # @abstract
        # @param [Hash] _args Attributes of the new instance.
        # @return [Model] An instance of the identity model class.
        # @since 3.0.5
        def create(*_args)
          raise NotImplementedError
        end
      end

      # @module InstanceSaveApi
      # Provides a save method for models that don't have one.
      module InstanceSaveApi
        # Persists a new Identity object to the ORM.
        # Default raises an error.  Override as needed per ORM.
        # This base version's arguments are modeled after ActiveModel
        #   since it is a pattern many ORMs follow
        #
        # @abstract
        # @param options [Hash] Options for saving.
        # @return [Model] An instance of the identity model class.
        # @since 3.0.5
        def save(**_options, &_block)
          raise NotImplementedError
        end
      end

      # @module InstancePersistedApi
      # Provides a persisted? method for models that don't have one.
      module InstancePersistedApi
        # Checks if the Identity object is persisted in the ORM.
        # Default raises an error.  Override as needed per ORM.
        #
        # @abstract
        # @return [true, false] true if object exists, false if not.
        # @since 3.0.5
        def persisted?
          raise NotImplementedError
        end
      end

      # Returns self if the provided password is correct, false
      # otherwise.
      #
      # @abstract Subclasses must implement this method.
      # @param [String] _password The password to check.
      # @return [self, false] Self if authenticated, false if not.
      def authenticate(_password)
        raise NotImplementedError
      end

      # An identifying string that must be globally unique to the
      # application. Defaults to stringifying the `id` method.
      #
      # @return [String] An identifier string unique to this identity.
      def uid
        if respond_to?(:id)
          return if id.nil?

          id.to_s
        else
          raise NotImplementedError
        end
      end

      # Used to retrieve the user-supplied authentication key (e.g. a
      # username or email). Determined using the class method of the same name,
      # defaults to `:email`.
      #
      # @return [String] An identifying string that will be entered by
      #   users upon sign in.
      def auth_key
        if respond_to?(self.class.auth_key.to_sym)
          send(self.class.auth_key)
        else
          raise NotImplementedError
        end
      end

      # Used to set the user-supplied authentication key (e.g. a
      # username or email. Determined using the `.auth_key` class
      # method.
      #
      # @param [String] value The value to which the auth key should be
      #   set.
      def auth_key=(value)
        auth_key_setter = "#{self.class.auth_key}=".to_sym
        if respond_to?(auth_key_setter)
          send(auth_key_setter, value)
        else
          raise NotImplementedError
        end
      end

      # A hash of as much of the standard OmniAuth schema as is stored
      # in this particular model. By default, this will call instance
      # methods for each of the attributes it needs in turn, ignoring
      # any for which `#respond_to?` is `false`.
      #
      # If `first_name`, `nickname`, and/or `last_name` is provided but
      # `name` is not, it will be automatically calculated.
      #
      # @return [Hash] A string-keyed hash of user information.
      def info
        info = {}
        SCHEMA_ATTRIBUTES.each_with_object(info) do |attribute, hash|
          hash[attribute] = send(attribute) if respond_to?(attribute)
        end
        info["name"] ||= [info["first_name"], info["last_name"]].join(" ").strip if info["first_name"] || info["last_name"]
        info["name"] ||= info["nickname"]
        info
      end
    end
  end
end
