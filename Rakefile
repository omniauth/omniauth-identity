# frozen_string_literal: true

require 'bundler/gem_tasks'

begin
  require 'rspec/core/rake_task'
  primary = RSpec::Core::RakeTask.new(:spec)
  active_record = RSpec::Core::RakeTask.new(:spec_orm_active_record)
  active_record.pattern = "spec_orms/active_record_spec.rb"
  couch_potato = RSpec::Core::RakeTask.new(:spec_orm_couch_potato)
  couch_potato.pattern = "spec_orms/couch_potato_spec.rb"
  mongoid = RSpec::Core::RakeTask.new(:spec_orm_mongoid)
  mongoid.pattern = "spec_orms/mongoid_spec.rb"
  no_brainer = RSpec::Core::RakeTask.new(:spec_orm_no_brainer)
  no_brainer.pattern = "spec_orms/no_brainer_spec.rb"
  sequel = RSpec::Core::RakeTask.new(:spec_orm_sequel)
  sequel.pattern = "spec_orms/sequel_spec.rb"
rescue LoadError
  task :spec do
    warn 'RSpec is disabled'
  end
end
task test: :spec

begin
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new
rescue LoadError
  task :rubocop do
    warn 'RuboCop is disabled'
  end
end

task default: [
  :test,
  :spec_orm_active_record,
  :spec_orm_couch_potato,
  :spec_orm_mongoid,
  :spec_orm_no_brainer,
  :spec_orm_sequel
]
