# frozen_string_literal: true

# kettle-dev Rakefile v1.1.38 - 2025-10-21
# Ruby 2.3 (Safe Navigation) or higher required
#
# MIT License (see License.txt)
#
# Copyright (c) 2025 Peter H. Boling (galtzo.com)
#
# Expected to work in any project that uses Bundler.
#
# Sets up tasks for appraisal, floss_funding, rspec, minitest, rubocop, reek, yard, and stone_checksums.
#
# rake appraisal:update                       # Update Appraisal gemfiles and run RuboCop...
# rake bench                                  # Run all benchmarks (alias for bench:run)
# rake bench:list                             # List available benchmark scripts
# rake bench:run                              # Run all benchmark scripts (skips on CI)
# rake build:generate_checksums               # Generate both SHA256 & SHA512 checksums i...
# rake bundle:audit:check                     # Checks the Gemfile.lock for insecure depe...
# rake bundle:audit:update                    # Updates the bundler-audit vulnerability d...
# rake ci:act[opt]                            # Run 'act' with a selected workflow
# rake coverage                               # Run specs w/ coverage and open results in...
# rake default                                # Default tasks aggregator
# rake install                                # Build and install kettle-dev-1.0.0.gem in...
# rake install:local                          # Build and install kettle-dev-1.0.0.gem in...
# rake kettle:dev:install                     # Install kettle-dev GitHub automation and ...
# rake kettle:dev:template                    # Template kettle-dev files into the curren...
# rake reek                                   # Check for code smells
# rake reek:update                            # Run reek and store the output into the RE...
# rake release[remote]                        # Create tag v1.0.0 and build and push kett...
# rake rubocop_gradual                        # Run RuboCop Gradual
# rake rubocop_gradual:autocorrect            # Run RuboCop Gradual with autocorrect (onl...
# rake rubocop_gradual:autocorrect_all        # Run RuboCop Gradual with autocorrect (saf...
# rake rubocop_gradual:check                  # Run RuboCop Gradual to check the lock file
# rake rubocop_gradual:force_update           # Run RuboCop Gradual to force update the l...
# rake rubocop_gradual_debug                  # Run RuboCop Gradual
# rake rubocop_gradual_debug:autocorrect      # Run RuboCop Gradual with autocorrect (onl...
# rake rubocop_gradual_debug:autocorrect_all  # Run RuboCop Gradual with autocorrect (saf...
# rake rubocop_gradual_debug:check            # Run RuboCop Gradual to check the lock file
# rake rubocop_gradual_debug:force_update     # Run RuboCop Gradual to force update the l...
# rake spec                                   # Run RSpec code examples
# rake test                                   # Run tests
# rake yard                                   # Generate YARD Documentation
#

require "bundler/gem_tasks" if !Dir[File.join(__dir__, "*.gemspec")].empty?

# Define a base default task early so other files can enhance it.
desc "Default tasks aggregator"
task :default do
  puts "Default task complete."
end

# External gems that define tasks - add here!
require "kettle/dev"

### RELEASE TASKS
# Setup stone_checksums
begin
  require "stone_checksums"
rescue LoadError
  desc("(stub) build:generate_checksums is unavailable")
  task("build:generate_checksums") do
    warn("NOTE: stone_checksums isn't installed, or is disabled for #{RUBY_VERSION} in the current environment")
  end
end

# rubocop:disable Rake/DuplicateTask
begin
  require "rspec/core/rake_task"

  # Define a default test task which will run only specs which work on sqlite3 because,
  #   when running sqlite3-based tests you don't need any additional services running.
  RSpec::Core::RakeTask.new("test") do |task|
    task.pattern = "{spec/**/*,spec_orms/active_record,spec_orms/rom,spec_orms/sequel}_spec.rb"
  end

  ### Combo Test Tasks for Continuous Integration
  # Define a task for each ORM which will run all ORM-agnostic specs + the specs for a specific ORM.
  # See spec_ignored/nobrainer_spec.rb for details on why that spec is skipped in CI.
  %w(active_record couch_potato mongoid rom sequel).each do |orm|
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
  rom = RSpec::Core::RakeTask.new(:spec_orm_rom)
  rom.pattern = "spec_orms/rom_spec.rb"
  sequel = RSpec::Core::RakeTask.new(:spec_orm_sequel)
  sequel.pattern = "spec_orms/sequel_spec.rb"

  # See spec_ignored/nobrainer_spec.rb for details on why that spec is skipped in CI.
  nobrainer = RSpec::Core::RakeTask.new(:spec_orm_nobrainer)
  nobrainer.pattern = "spec_ignored/nobrainer_spec.rb"

  # When running all tests you must have CouchDB, and MongoDB running.  See README.md
  desc("Run all ORM specs (requires CouchDB, and MongoDB running)")
  task(spec_orms: %i[
    spec_orm_active_record
    spec_orm_couch_potato
    spec_orm_mongoid
    spec_orm_rom
    spec_orm_sequel
  ])
rescue LoadError
  desc("spec task stub")
  task(:spec) do
    warn("NOTE: rspec isn't installed, or is disabled for #{RUBY_VERSION} in the current environment")
  end
end
# rubocop:enable Rake/DuplicateTask
