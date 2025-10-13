# frozen_string_literal: true

# Bugfixes
# JRuby needed an explicit "require 'logger'" for Rails < 7.1
# See: https://github.com/rails/rails/issues/54260#issuecomment-2594650047
# Placing above omniauth because it is a dependency of omniauth,
#   which is undeclared in older versions.
require "logger"

require_relative "support/rspec_config/sequel"

RSpec.describe(OmniAuth::Identity::Models::Sequel, :sqlite3) do
  before(:all) do
    # Connect to an in-memory sqlite3 database.
    DB.create_table(:sequel_test_identities) do
      primary_key :id
      String :email, null: false
      String :password_digest, null: false
    end
  end

  before do
    sequel_test_identity = Class.new(Sequel::Model(DB[:sequel_test_identities])) do
      include OmniAuth::Identity::Models::Sequel

      auth_key :email
    end
    stub_const("SequelTestIdentity", sequel_test_identity)
  end

  describe "model", type: :model do
    subject(:model_klass) { SequelTestIdentity }

    include_context "persistable model"

    describe "::locate" do
      it "delegates to the where query method" do
        args = {email: "open faced", category: "sandwiches"}
        allow(model_klass).to(receive(:where).with(args).and_return(["wakka"]))
        expect(model_klass.locate(args)).to(eq("wakka"))
      end
    end
  end
end
