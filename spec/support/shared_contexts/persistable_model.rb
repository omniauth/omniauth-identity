# frozen_string_literal: true

RSpec.shared_context "persistable model" do
  include_context "model with class methods"

  describe "instance methods" do
    subject(:instance) { model_klass.new }

    include_context "instance with instance methods"

    describe "#save" do
      subject(:save) do
        instance.email = DEFAULT_EMAIL
        instance.password = DEFAULT_PASSWORD
        instance.password_confirmation = DEFAULT_PASSWORD
        instance.save
      end

      it "does not raise an error" do
        save
      end
    end
  end
end
