# frozen_string_literal: true

# 1. While the Ruby driver, nobrainer, is maintained,
#   RethinkDB itself is currently a zombie project.
# 2. There are zero examples in the wild of a GitHub Actions workflow
#   that sets up a RethinkDB service to test client code against.
# As long as above points remain current, no attempt will be made to get nobrainer specs running in CI,
#   unless a RethinkDB-fan wants to take a shot at it.
# You might be inspired by the existing other services this library is currently
#   tested against (e.g. CouchDB, MongoDB)
# See: https://github.com/rethinkdb/rethinkdb/issues/6981
#
# NOTE: mongoid and nobrainer can't be loaded at the same time.
#       If you try it, one or both of them will not work.
#
# However, if you have RethinkDB installed locally, this spec should work in isolation!
require "nobrainer"

RSpec.describe(OmniAuth::Identity::Models::NoBrainer, :rethinkdb) do
  before(:all) do
    NoBrainer.configure do |config|
      config.app_name = "DeezBrains"
      config.rethinkdb_urls = ["rethinkdb://127.0.0.1:28015/DeezBrains_test"]
      config.table_options = {
        shards: 1,
        replicas: 1,
        write_acks: :majority,
      }
    end
    NoBrainer.sync_schema
  end

  before do
    nobrainer_test_identity = Class.new do
      include NoBrainer::Document
      include OmniAuth::Identity::Models::NoBrainer
      field :email
      field :password_digest
    end
    stub_const("NoBrainerTestIdentity", nobrainer_test_identity)
    NoBrainer.purge!
  end

  describe "model", type: :model do
    subject(:model_klass) { NoBrainerTestIdentity }

    include_context "persistable model"

    describe "::locate" do
      it "delegates locate to the where query method" do
        allow(model_klass).to(receive(:where).with(
          "email" => "open faced",
          "category" => "sandwiches",
        ).and_return(["wakka"]))
        expect(model_klass.locate("email" => "open faced", "category" => "sandwiches")).to(eq("wakka"))
      end
    end
  end
end
