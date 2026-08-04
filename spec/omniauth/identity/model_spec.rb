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

    describe "::inherited" do
      it "copies filtered attributes to subclasses" do
        expect(IdentityTestClass).to receive(:filtered_attributes).with(*OmniAuth::Identity::Model::FILTERED_INSPECT_ATTRIBUTES)

        Class.new(IdentityTestClass)
      end
    end

    describe "::auth_key" do
      it "uses a configured key and resets an empty key to the default" do
        expect(model_klass.auth_key(:login)).to eq("login")
        expect(model_klass.auth_key).to eq("login")

        expect(model_klass.auth_key("")).to eq("email")
      end
    end

    describe "fallback APIs" do
      it "adds create, save, and persisted? only when they are absent" do
        expect(model_klass).to respond_to(:create)
        expect(model_klass.new).to respond_to(:save, :persisted?)
        expect { model_klass.create }.to raise_error(NotImplementedError)
        expect { model_klass.new.save }.to raise_error(NotImplementedError)
        expect { model_klass.new.persisted? }.to raise_error(NotImplementedError)
      end

      it "does not replace existing APIs" do
        klass = Class.new do
          def self.create(*)
            :created
          end

          def save(*)
            :saved
          end

          def persisted?
            :persisted
          end

          include OmniAuth::Identity::Model
        end

        expect(klass.create).to eq(:created)
        expect(klass.new.save).to eq(:saved)
        expect(klass.new.persisted?).to eq(:persisted)
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

    describe "#uid" do
      it "returns nil when the id is nil" do
        klass = Class.new do
          include OmniAuth::Identity::Model

          attr_accessor :id
        end

        expect(klass.new.uid).to be_nil
      end
    end
  end

  it "can be loaded again after its version has already been configured" do
    identity_path = File.expand_path("../../../lib/omniauth/identity.rb", __dir__)

    expect { load identity_path }.not_to raise_error
  end
end
