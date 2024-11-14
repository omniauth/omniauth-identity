# frozen_string_literal: true

# NOTE: mongoid and no_brainer can't be loaded at the same time.
#       If you try it, one or both of them will not work.
require_relative "support/rspec_config/mongoid"

RSpec.describe(OmniAuth::Identity::Models::Mongoid, :mongodb) do
  describe "model", type: :model do
    subject(:model_klass) { MongoidTestIdentity }

    it { is_expected.to(be_mongoid_document) }

    it "does not munge collection name" do
      expect(subject).to(be_stored_in(database: "db1", collection: "mongoid_test_identities", client: "default"))
    end

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
