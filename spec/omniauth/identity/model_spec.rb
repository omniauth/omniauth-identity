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

    describe "#inspect" do
      subject(:inspected) { inspectable_instance.inspect }

      let(:inspectable_klass) do
        Class.new do
          include OmniAuth::Identity::Model

          attr_accessor :email, :password, :password_confirmation, :password_digest, :password_hint
        end
      end
      let(:inspectable_instance) do
        inspectable_klass.new.tap do |model|
          model.email = DEFAULT_EMAIL
          model.password = DEFAULT_PASSWORD
          model.password_confirmation = DEFAULT_PASSWORD
          model.password_digest = "bcrypt-secret"
          model.password_hint = "diner"
        end
      end

      it "filters password-related attributes" do
        expect(inspected).not_to include(DEFAULT_PASSWORD)
        expect(inspected).not_to include("bcrypt-secret")
        expect(inspected).to include("[FILTERED]")
      end

      it "does not filter non-sensitive attributes" do
        expect(inspected).to include(DEFAULT_EMAIL)
        expect(inspected).to include("diner")
      end
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
