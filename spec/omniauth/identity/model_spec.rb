# frozen_string_literal: true

RSpec.describe OmniAuth::Identity::Model do
  before do
    identity_test_klass = Class.new do
      include OmniAuth::Identity::Model
    end
    stub_const("IdentityTestClass", identity_test_klass)
  end

  describe "Class Methods" do
    subject(:model_klass) { IdentityTestClass }

    include_context "model with class methods"

    describe "::locate" do
      it("is abstract") do
        expect { model_klass.locate("email" => "example") }.to raise_error(NotImplementedError)
      end
    end
  end

  describe "Instance Methods" do
    subject(:instance) { IdentityTestClass.new }

    include_context "instance with instance methods"

    describe "#authenticate" do
      it("is abstract") { expect { instance.authenticate("my-password") }.to raise_error(NotImplementedError) }
    end

    describe "#auth_key" do
      it "raises a NotImplementedError if the auth_key method is not defined" do
        expect { instance.auth_key }.to raise_error(NotImplementedError)
      end
    end

    describe "#auth_key=" do
      it "raises a NotImplementedError if the auth_key method is not defined" do
        expect { instance.auth_key = "broken" }.to raise_error(NotImplementedError)
      end
    end
  end
end
