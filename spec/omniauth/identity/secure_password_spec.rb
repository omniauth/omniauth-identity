# frozen_string_literal: true

RSpec.describe OmniAuth::Identity::SecurePassword do
  it "extends with the class methods if it does not have the method" do
    klass = Class.new
    expect(klass).to receive(:extend).with(OmniAuth::Identity::SecurePassword::ClassMethods)
    klass.include described_class
  end

  it "does not extend if the method is already defined" do
    klass = Class.new do
      class << self
        def has_secure_password
        end
      end
    end
    expect(klass).not_to receive(:extend)
    klass.include described_class
  end

  it "responds to has_secure_password afterwards" do
    klass_without = Class.new
    klass_without.include described_class
    expect(klass_without).to respond_to(:has_secure_password)

    klass_with = Class.new do
      class << self
        def has_secure_password
        end
      end
    end
    klass_with.include described_class
    expect(klass_with).to respond_to(:has_secure_password)
  end
end
