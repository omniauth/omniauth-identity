# frozen_string_literal: true

require "fileutils"
require "pathname"
require "time"
require "logger"
require "sequel"
require "sequel/extensions/migration"

module OmniAuthIdentity
  module IntegrationLogger
    module_function

    class NullLogger
      def initialize
        severity_constants.each do |severity|
          severity_name = severity.to_s.downcase
          define_singleton_method(severity_name) { |_msg = nil| nil }
          define_singleton_method("#{severity_name}?") { false }
        end
      end

      def add(*_args)
      end

      def method_missing(*_args, &_block)
      end

      def respond_to_missing?(*_args)
        true
      end

      private

      def severity_constants
        defined?(Logger::Severity) ? Logger::Severity.constants : []
      end
    end

    LoggerState = Struct.new(:loggers, :log_level_cache, :mutex)
    NULL_LOGGER = NullLogger.new

    def state
      @state ||= LoggerState.new({}, {}, Mutex.new)
    end

    def for(framework)
      level = log_level
      st = state
      st.mutex.synchronize do
        st.loggers[framework] ||= build_logger(framework, level)
      end
    end

    def build_logger(framework, level = log_level)
      return NULL_LOGGER if level.nil?

      Logger.new($stdout).tap do |logger|
        logger.level = level
        logger.progname = "integration:#{framework}"
        logger.formatter = proc do |severity, datetime, progname, msg|
          "[#{datetime.utc.iso8601}] #{progname} #{severity}: #{msg}\n"
        end
      end
    end

    def log_level
      st = state
      level_name = ENV.fetch("INTEGRATION_LOG_LEVEL", "").strip
      st.mutex.synchronize do
        cache = st.log_level_cache
        return cache[:value] if cache[:name] == level_name

        cache[:name] = level_name
        cache[:value] = resolve_level(level_name)
      end
    end

    def resolve_level(level_name)
      return if level_name.empty? || level_name.casecmp("off").zero?

      Logger.const_get(level_name.upcase)
    rescue NameError
      warn("[integration] Unknown INTEGRATION_LOG_LEVEL=#{level_name.inspect}, defaulting to off")
      nil
    end
  end

  module IntegrationHelpers
    module_function

    SPEC_ROOT = Pathname.new(File.expand_path("..", __dir__)).freeze
    REPO_ROOT = SPEC_ROOT.parent.freeze
    TMP_ROOT = REPO_ROOT.join("tmp").freeze
    TMP_DB_ROOT = TMP_ROOT.join("db").freeze
    DUMMIES_ROOT = SPEC_ROOT.join("dummies").freeze

    def integration_tmp_db_root
      FileUtils.mkdir_p(TMP_DB_ROOT)
      TMP_DB_ROOT
    end

    def integration_database_path(framework)
      integration_tmp_db_root.join("#{framework_key(framework)}.sqlite3")
    end

    def integration_logger(framework)
      OmniAuthIdentity::IntegrationLogger.for(framework)
    end

    def framework_key(framework)
      framework.to_s.downcase.to_sym
    end

    def registries
      @registries ||= {initializers: {}, truncators: {}}
    end

    def registry_mutex
      @registry_mutex ||= Mutex.new
    end

    def register_database_initializer(framework, &block)
      raise ArgumentError, "initializer block required" unless block

      registry_mutex.synchronize do
        registries[:initializers][framework_key(framework)] = block
      end
    end

    def register_database_truncator(framework, &block)
      registry_mutex.synchronize do
        registries[:truncators][framework_key(framework)] = block
      end
    end

    def database_initializer(framework)
      registries[:initializers][framework_key(framework)]
    end

    def database_truncator(framework)
      registries[:truncators][framework_key(framework)]
    end

    def with_sequel_db(path)
      Sequel.sqlite(path.to_s) { |db| yield db }
    end

    def reset_integration_database!(framework)
      path = integration_database_path(framework)
      FileUtils.rm_f(path)
      integration_logger(framework).info { "reset database #{path}" }
      path
    end

    def ensure_clean_database_for(framework)
      path = reset_integration_database!(framework)
      apply_framework_database_env(framework, path)
      database_initializer(framework)&.call(path)
      yield(path) if block_given?
    ensure
      truncate_database_for(framework)
    end

    def apply_framework_database_env(framework, path)
      case framework_key(framework)
      when :sinatra
        ENV["DATABASE_URL"] = path.to_s
        ENV["SINATRA_DATABASE_URL"] = path.to_s
      end
    end

    def truncate_database_for(framework)
      return unless (truncator = database_truncator(framework))

      truncator.call(integration_database_path(framework))
    end

    def register_sinatra_hooks
      migrations_path = DUMMIES_ROOT.join("sinatra_app", "db", "migrate")

      register_database_initializer(:sinatra) do |db_path|
        with_sequel_db(db_path) do |db|
          Sequel::Migrator.run(db, migrations_path)
          Identity.ready!(db) if defined?(Identity)
        end
      end

      register_database_truncator(:sinatra) do |db_path|
        with_sequel_db(db_path) do |db|
          db.tables.reject { |table| table == :schema_info }.each { |table| db[table].truncate }
        end
      end
    end

    def register_roda_hooks
      # Roda uses in-memory ROM, so no file-based initialization needed
      # Just need to clear data between tests
      register_database_truncator(:roda) do |_db_path|
        RodaIdentity.delete_all if defined?(RodaIdentity)
      end
    end

    def register_hanami_hooks
      # Hanami uses in-memory ROM, so no file-based initialization needed
      # Just need to clear data between tests
      register_database_truncator(:hanami) do |_db_path|
        HanamiIdentity.delete_all if defined?(HanamiIdentity)
      end
    end

    def register_default_database_hooks
      register_sinatra_hooks
      register_roda_hooks
      register_hanami_hooks
    end

    register_default_database_hooks
  end
end

OmniAuthIdentity::IntegrationHelpers.register_default_database_hooks

RSpec.configure do |config|
  config.include OmniAuthIdentity::IntegrationHelpers, type: :integration

  config.before(:suite) do
    OmniAuthIdentity::IntegrationHelpers.integration_tmp_db_root
  end

  config.around(:example, :integration_framework) do |example|
    framework = example.metadata[:integration_framework]
    unless framework
      warn("[integration] :integration_framework metadata missing")
      next example.run
    end

    OmniAuthIdentity::IntegrationHelpers.ensure_clean_database_for(framework) do
      example.run
    end
  end
end
