# frozen_string_literal: true

require "couch_potato"

RSpec.describe(OmniAuth::Identity::Models::CouchPotatoModule, :couchdb) do
  before(:all) do
    CouchPotato::Config.database_host = "http://admin:#{ENV.fetch("COUCHDB_PASSWORD", "password")}@127.0.0.1:5984"
    CouchPotato::Config.database_name = "test"
    CouchPotato.couchrest_database.recreate!
  end

  before do
    couch_potato_test_identity = Class.new do
      # NOTE: CouchPotato::Persistence must be included before OmniAuth::Identity::Models::CouchPotatoModule
      include CouchPotato::Persistence
      include OmniAuth::Identity::Models::CouchPotatoModule
      property :email
      property :password_digest
    end
    stub_const("CouchPotatoTestIdentity", couch_potato_test_identity)
  end

  describe "model", type: :model do
    subject(:model_klass) { CouchPotatoTestIdentity }

    include_context "persistable model"

    describe "::locate" do
      it "delegates to the where query method" do
        args = {
          "email" => "open faced",
          "category" => "sandwiches",
        }
        allow(model_klass).to(receive(:where).with(args).and_return(["wakka"]))
        expect(model_klass.locate(args)).to(eq("wakka"))
      end
    end
  end
end
