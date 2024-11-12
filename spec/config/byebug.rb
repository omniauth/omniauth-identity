if VersionGem::Ruby.gte_minimum_version?("2.7")
  require "byebug" if ENV.fetch("DEBUG", "false").casecmp?("true")
end
