# frozen_string_literal: true

require "bundler/gem_tasks"

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
  task(:test) do
    warn("RSpec is disabled")
  end
end

begin
  require "reek/rake/task"
  Reek::Rake::Task.new do |t|
    t.fail_on_error = true
    t.verbose = false
    t.source_files = "{spec,spec_ignored,spec_orms,lib}/**/*.rb"
  end
rescue LoadError
  task(:reek) do
    warn("reek is disabled")
  end
end

begin
  require "yard-junk/rake"

  YardJunk::Rake.define_task
rescue LoadError
  task("yard:junk") do
    warn("yard:junk is disabled")
  end
end

begin
  require "yard"

  YARD::Rake::YardocTask.new(:yard)
rescue LoadError
  task(:yard) do
    warn("yard is disabled")
  end
end

begin
  require "rubocop/lts"
  Rubocop::Lts.install_tasks
rescue LoadError
  task(:rubocop_gradual) do
    warn("RuboCop (Gradual) is disabled")
  end
end

# These tests do not require any services to be running, so this is what we run as default
task default: %i[spec:orm:all rubocop_gradual:autocorrect yard yard:junk]
