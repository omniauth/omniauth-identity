# frozen_string_literal: true

require "bundler/gem_tasks"

begin
  require "rspec/core/rake_task"
  RSpec::Core::RakeTask.new(:test)
  couch_potato = RSpec::Core::RakeTask.new(:spec_orm_couch_potato)
  couch_potato.pattern = "spec_orms/couch_potato_spec.rb"
  mongoid = RSpec::Core::RakeTask.new(:spec_orm_mongoid)
  mongoid.pattern = "spec_orms/mongoid_spec.rb"
  nobrainer = RSpec::Core::RakeTask.new(:spec_orm_nobrainer)
  nobrainer.pattern = "spec_orms/nobrainer_spec.rb"

  # When running all tests you must have RethinkDB, CouchDB, and MongoDB running.  See README.md
  task(spec: %i[
    test
    spec_orm_couch_potato
    spec_orm_mongoid
    spec_orm_nobrainer
  ])
rescue LoadError
  task(:test) do
    warn("RSpec is disabled")
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

# These tests do not require any services to be running, so this is what we run via Github Actions
task default: %i[test rubocop_gradual:autocorrect]
