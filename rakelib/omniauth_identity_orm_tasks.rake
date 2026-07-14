# frozen_string_literal: true

def run_omniauth_identity_specs(env, *paths)
  sh(env, "bundle", "exec", "rspec", *paths)
end

namespace :spec do
  namespace :orm do
    desc "Run ActiveRecord-backed ORM and strategy specs"
    task :active_record do
      run_omniauth_identity_specs(
        {"OMNIAUTH_IDENTITY_ENABLE_SQLITE3" => "true"},
        "spec/omniauth/identity/models/active_record_spec.rb",
        "spec/omniauth/strategies/identity_spec.rb"
      )
    end

    desc "Run CouchPotato-backed ORM specs"
    task :couch_potato do
      run_omniauth_identity_specs(
        {"OMNIAUTH_IDENTITY_ENABLE_COUCHDB" => "true"},
        "spec/omniauth/identity/models/couch_potato_module_spec.rb"
      )
    end

    desc "Run Mongoid-backed ORM specs"
    task :mongoid do
      run_omniauth_identity_specs(
        {"OMNIAUTH_IDENTITY_ENABLE_MONGODB" => "true"},
        "spec/omniauth/identity/models/mongoid_spec.rb"
      )
    end

    desc "Run NoBrainer-backed ORM specs"
    task :nobrainer do
      run_omniauth_identity_specs(
        {"OMNIAUTH_IDENTITY_ENABLE_RETHINKDB" => "true"},
        "spec/omniauth/identity/models/no_brainer_spec.rb"
      )
    end

    desc "Run ROM-backed ORM specs"
    task :rom do
      run_omniauth_identity_specs(
        {"OMNIAUTH_IDENTITY_ENABLE_SQLITE3" => "true"},
        "spec/omniauth/identity/models/rom_spec.rb"
      )
    end

    desc "Run Sequel-backed ORM specs"
    task :sequel do
      run_omniauth_identity_specs(
        {"OMNIAUTH_IDENTITY_ENABLE_SQLITE3" => "true"},
        "spec/omniauth/identity/models/sequel_spec.rb"
      )
    end
  end
end
