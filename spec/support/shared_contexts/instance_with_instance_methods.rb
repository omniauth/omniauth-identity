# frozen_string_literal: true

RSpec.shared_examples "instance with instance methods" do
  describe "#initialize" do
    it "does not raise an error" do
      block_is_expected.not_to raise_error
    end
  end

  describe "#uid" do
    it "defaults to #id" do
      allow(instance).to receive(:respond_to?).with(:id).and_return(true)
      allow(instance).to receive(:id).and_return "wakka-do"
      expect(instance.uid).to eq("wakka-do")
    end

    it "stringifies it" do
      allow(instance).to receive(:id).and_return 123
      expect(instance.uid).to eq("123")
    end

    it "raises NotImplementedError if #id is not defined" do
      allow(instance).to receive(:respond_to?).with(:id).and_return(false)
      expect { instance.uid }.to raise_error(NotImplementedError)
    end
  end

  describe "#auth_key" do
    it "defaults to #email" do
      allow(instance).to receive(:respond_to?).with(:email).and_return(true)
      allow(instance).to receive(:email).and_return("bob@bob.com")
      expect(instance.auth_key).to eq("bob@bob.com")
    end

    it "uses the class .auth_key" do
      instance.class.auth_key "login"
      allow(instance).to receive(:login).and_return "bob"
      expect(instance.auth_key).to eq("bob")
      instance.class.auth_key nil
    end
  end

  describe "#auth_key=" do
    it "defaults to setting email" do
      allow(instance).to receive(:respond_to?).with(:email=).and_return(true)
      expect(instance).to receive(:email=).with "abc"

      instance.auth_key = "abc"
    end

    it "uses a custom .auth_key if one is provided" do
      instance.class.auth_key "login"
      allow(instance).to receive(:respond_to?).with(:login=).and_return(true)
      expect(instance).to receive(:login=).with("abc")

      instance.auth_key = "abc"
    end
  end

  describe "#info" do
    it "includes all attributes as they have been set" do
      allow(instance).to receive(:name).and_return("Bob Bobson")
      allow(instance).to receive(:nickname).and_return("bob")

      expect(instance.info).to include({
        "name" => "Bob Bobson",
        "nickname" => "bob",
      })
    end

    it "uses firstname and lastname, over nickname, to set missing name" do
      allow(instance).to receive(:first_name).and_return("shoeless")
      allow(instance).to receive(:last_name).and_return("joe")
      allow(instance).to receive(:nickname).and_return("george")
      instance.info["name"] == "shoeless joe"
    end

    it "uses nickname to set missing name when first and last are not set" do
      allow(instance).to receive(:nickname).and_return("bob")
      instance.info["name"] == "bob"
    end

    it "does not overwrite a provided name" do
      allow(instance).to receive(:name).and_return("Awesome Dude")
      allow(instance).to receive(:first_name).and_return("Frank")
      expect(instance.info["name"]).to eq("Awesome Dude")
    end
  end
end
