# frozen_string_literal: true

# Bugfixes
# JRuby needed an explicit "require 'logger'" for Rails < 7.1
# See: https://github.com/rails/rails/issues/54260#issuecomment-2594650047
# Placing above omniauth because it is a dependency of omniauth,
#   which is undeclared in older versions.
require "logger"

require "active_record"
require "anonymous_active_record"

class TestIdentity < OmniAuth::Identity::Models::ActiveRecord; end

RSpec.describe(OmniAuth::Identity::Models::ActiveRecord, :sqlite3) do
  describe "model", type: :model do
    subject(:model_klass) do
      AnonymousActiveRecord.generate(
        parent_klass: "OmniAuth::Identity::Models::ActiveRecord",
        columns: OmniAuth::Identity::Model::SCHEMA_ATTRIBUTES | %w[provider password_digest],
        connection_params: {adapter: distinguish_jdbc_driver ? "jdbcsqlite3" : "sqlite3", encoding: "utf8", database: ":memory:"},
      ) do
        auth_key :email
        def flower
          "🌸"
        end
      end
    end

    let(:distinguish_jdbc_driver) { RUBY_PLATFORM == "java" && defined?(ArJdbc::Version) && Gem::Version.create(ArJdbc::Version) >= Gem::Version.create("72.0") }

    include_context "persistable model"

    describe "::table_name" do
      it "does not use STI rules for its table name" do
        expect(TestIdentity.table_name).to(eq("test_identities"))
      end
    end

    describe "::locate" do
      it "delegates locate to the where query method" do
        args = {
          email: "open faced",
          category: "sandwiches",
          provider: "identity",
        }
        allow(model_klass).to(receive(:where).with(args).and_return(["wakka"]))
        expect(model_klass.locate(args)).to(eq("wakka"))
      end
    end
  end
end
