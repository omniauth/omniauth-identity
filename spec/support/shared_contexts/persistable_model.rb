# frozen_string_literal: true

RSpec.shared_context "persistable model" do
  include_context "model with class methods"

  describe "instance methods" do
    subject(:instance) { model_klass.new }

    include_context "instance with instance methods"

    before do
      instance.email = DEFAULT_EMAIL
      instance.password = DEFAULT_PASSWORD
      instance.password_confirmation = DEFAULT_PASSWORD
    end

    describe "#valid?" do
      subject(:is_valid) do
        instance.valid?
      end

      it "is valid" do
        expect(is_valid).to eq(true)
      end
    end

    describe "#save" do
      subject(:is_saved) do
        instance.save
      end

      it "does not raise an error" do
        block_is_expected.not_to raise_error
      end
    end
  end
end
