# rubocop:disable RSpec/SpecFilePathFormat

require "anonymous_loader"
require "omniauth-identity"
RSpec.describe OmniAuth::Identity::Version do
  it_behaves_like "a Version module", described_class

  it "is greater than 1.0.0" do
    expect(Gem::Version.new(described_class) >= Gem::Version.new("1.0.0")).to be(true)
  end

  it "executes the version file for coverage without redefining constants" do
    paths = [
      File.expand_path("../../../lib/omniauth/identity/version.rb", __dir__),
      File.expand_path("../../../lib/omniauth/identity/version_gem.rb", __dir__)
    ].select { |path| File.file?(path) }
    anonymous_namespace = AnonymousLoader.load(files: paths)

    expect(anonymous_namespace::OmniAuth::Identity::Version::VERSION).to eq(described_class::VERSION)
  end
end

# rubocop:enable RSpec/SpecFilePathFormat
