# frozen_string_literal: true

require "bundler/gem_tasks"

defaults = []

# See: https://docs.gitlab.com/ci/variables/predefined_variables/
is_gitlab = ENV.fetch("GITLAB_CI", "false").casecmp("true") == 0

### DEVELOPMENT TASKS
# Setup Kettle Soup Cover
begin
  require "kettle-soup-cover"

  Kettle::Soup::Cover.install_tasks
  # NOTE: Coverage on CI is configured independent of this task.
  #       This task is for local development, as it opens results in browser
  defaults << "coverage" unless Kettle::Soup::Cover::IS_CI
rescue LoadError
  desc("(stub) coverage is unavailable")
  task("coverage") do
    warn("NOTE: kettle-soup-cover isn't installed, or is disabled for #{RUBY_VERSION} in the current environment")
  end
end

# Setup Bundle Audit
begin
  require "bundler/audit/task"

  Bundler::Audit::Task.new
  defaults.push("bundle:audit:update", "bundle:audit")
rescue LoadError
  desc("(stub) bundle:audit is unavailable")
  task("bundle:audit") do
    warn("NOTE: bundler-audit isn't installed, or is disabled for #{RUBY_VERSION} in the current environment")
  end
  desc("(stub) bundle:audit:update is unavailable")
  task("bundle:audit:update") do
    warn("NOTE: bundler-audit isn't installed, or is disabled for #{RUBY_VERSION} in the current environment")
  end
end

begin
  require "rspec/core/rake_task"

  # Define a default test task which will run only specs which work on sqlite3 because,
  #   when running sqlite3-based tests you don't need any additional services running.
  %w(active_record sequel).each do |orm|
    RSpec::Core::RakeTask.new("test") do |task|
      task.pattern = "{spec/**/*,spec_orms/active_record,spec_orms/sequel}_spec.rb"
    end
  end

  ### Combo Test Tasks for Continuous Integration
  # Define a task for each ORM which will run all ORM-agnostic specs + the specs for a specific ORM.
  # See spec_ignored/nobrainer_spec.rb for details on why that spec is skipped in CI.
  %w(active_record couch_potato mongoid sequel).each do |orm|
    RSpec::Core::RakeTask.new("spec:orm:#{orm}") do |task|
      task.pattern = "{spec/**/*,spec_orms/#{orm}}_spec.rb"
    end
  end
  ### Combo Test Task for Code Coverage Workflow in Continuous Integration
  # Requires all services (CouchDB, and MongoDB) to be running.
  # See spec_ignored/nobrainer_spec.rb for details on why that spec is skipped in CI.
  RSpec::Core::RakeTask.new("spec:orm:all") do |task|
    task.pattern = "{spec,spec_orms}/**/*_spec.rb"
  end

  ### Combo Test Tasks for local development...
  # Define tasks which only run the ORM-specific tests in isolation
  active_record = RSpec::Core::RakeTask.new(:spec_orm_active_record)
  active_record.pattern = "spec_orms/active_record_spec.rb"
  couch_potato = RSpec::Core::RakeTask.new(:spec_orm_couch_potato)
  couch_potato.pattern = "spec_orms/couch_potato_spec.rb"
  mongoid = RSpec::Core::RakeTask.new(:spec_orm_mongoid)
  mongoid.pattern = "spec_orms/mongoid_spec.rb"
  sequel = RSpec::Core::RakeTask.new(:spec_orm_sequel)
  sequel.pattern = "spec_orms/sequel_spec.rb"

  # See spec_ignored/nobrainer_spec.rb for details on why that spec is skipped in CI.
  nobrainer = RSpec::Core::RakeTask.new(:spec_orm_nobrainer)
  nobrainer.pattern = "spec_ignored/nobrainer_spec.rb"

  # When running all tests you must have CouchDB, and MongoDB running.  See README.md
  task(spec: %i[
    test
    spec_orm_active_record
    spec_orm_couch_potato
    spec_orm_mongoid
    spec_orm_sequel
  ])
rescue LoadError
  desc("spec task stub")
  task(:spec) do
    warn("NOTE: rspec isn't installed, or is disabled for #{RUBY_VERSION} in the current environment")
  end
end

# Setup RuboCop-LTS
begin
  require "rubocop/lts"

  Rubocop::Lts.install_tasks
  # Make autocorrect the default rubocop task
  defaults << "rubocop_gradual:autocorrect"
rescue LoadError
  desc("(stub) rubocop_gradual is unavailable")
  task(:rubocop_gradual) do
    warn("NOTE: rubocop-lts isn't installed, or is disabled for #{RUBY_VERSION} in the current environment")
  end
end

# Setup Yard
begin
  require "yard"

  YARD::Rake::YardocTask.new(:yard) do |t|
    t.files = [
      # Source Splats (alphabetical)
      "lib/**/*.rb",
      "-", # source and extra docs are separated by "-"
      # Extra Files (alphabetical)
      "*.cff",
      "*.md",
      "*.txt",
    ]
  end
  defaults << "yard"
rescue LoadError
  desc("(stub) yard is unavailable")
  task(:yard) do
    warn("NOTE: yard isn't installed, or is disabled for #{RUBY_VERSION} in the current environment")
  end
end

# Setup Reek
begin
  require "reek/rake/task"

  Reek::Rake::Task.new do |t|
    t.fail_on_error = true
    t.verbose = false
    t.source_files = "{lib,spec,spec_ignored,spec_orms}/**/*.rb"
  end
  defaults << "reek" unless is_gitlab
rescue LoadError
  desc("(stub) reek is unavailable")
  task(:reek) do
    warn("NOTE: reek isn't installed, or is disabled for #{RUBY_VERSION} in the current environment")
  end
end

### RELEASE TASKS
# Setup stone_checksums
begin
  require "stone_checksums"

  GemChecksums.install_tasks
rescue LoadError
  desc("(stub) build:generate_checksums is unavailable")
  task("build:generate_checksums") do
    warn("NOTE: stone_checksums isn't installed, or is disabled for #{RUBY_VERSION} in the current environment")
  end
end

task default: defaults
