# Changelog

All notable changes to this project since v2.0 will be documented in this file.

The format is based on [Keep a Changelog v1](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning v2](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Added
### Changed
### Fixed
### Removed

## [3.0.9] - 2021-06-16
### Fixed
- \[Sequel\] Fixes loading the Sequel adapter, issue reported as [#112](https://github.com/omniauth/omniauth-identity/issues/112)
### Added
- 📝 Document the Database adapters and drivers the gem currently works with

## [3.0.8] - 2021-03-24
### Fixed
- \[Model\] Fixes 2 issues raised in a comment on PR [#108](https://github.com/omniauth/omniauth-identity/pull/108#issuecomment-804456604)
  - When `options[:on_validation]` is set `new`/`save`/`persisted?` logic is used.
  - When `options[:on_validation]` is not set `create`/`persisted?` logic is used.

## [3.0.7] - 2021-03-23
### Fixed
- \[ActiveRecord\] Fixed [#110](https://github.com/omniauth/omniauth-identity/issues/110) which prevented `OmniAuth::Identity::Models::ActiveRecord`-based records from saving.
- \[CouchPotato\] Fixed `OmniAuth::Identity::Models::CouchPotato`'s `#save`.
- \[Sequel\] Fixed `OmniAuth::Identity::Models::Sequel`'s `#save`.
- \[Model\] Only define `::create`, `#save`, and `#persisted?` when not already defined.
- \[Model\] Restore original `info` functionality which set `name` based on `first_name`, `last_name`, or `nickname`

### Changed
- Upgraded to a newer `OmniAuth::Identity::SecurePassword` ripped from [Rails 6-1-stable](https://github.com/rails/rails/blob/6-1-stable/activemodel/lib/active_model/secure_password.rb)
  - Aeons ago the original was ripped from Rails 3.1, and frozen in time.
    While writing specs, it was discovered to be incompatible with this gem's Sequel adapter.
  - Specs validate that the new version does work.
    In any case, the ripped version is only used when the `has_secure_password` macro is not yet defined in the class.
### Added
- New specs to cover real use cases and implementations of each ORM model adapter that ships with the gem:
  - ActiveRecord (Polyglot - Many Relational Databases)
  - Sequel (Polyglot - Many Relational Databases)
  - CouchPotato (CouchDB)
  - Mongoid (MongoDB)
  - NoBrainer (RethinkDB)

## [3.0.6] - 2021-03-20
### Fixed
- Fix breaking changes introduced by [#108](https://github.com/omniauth/omniauth-identity/pull/108) which prevented `:on_validation` from firing
### Added
- New (or finally documented) options:
  - `:create_identity_link_text` defaults to `'Create an Identity'`
  - `:registration_failure_message` defaults to `'One or more fields were invalid'`
  - `:validation_failure_message` defaults to `'Validation failed'`
  - `:title` defaults to `'Identity Verification'`
  - `:registration_form_title` defaults to `'Register Identity'`

## [3.0.5] - 2021-03-19
### Fixed
- Fix breaking changes introduced by [#86's](https://github.com/omniauth/omniauth-identity/pull/86) introduction of `:on_validation`
### Added
- Define `#save`, `#persisted?` and `::create` on `Omniauth::Identity::Model`
- Add `@since` YARD tags to interface methods
- Refactor `Omniauth::Strategies::Identity.registration_phase` to support `Omniauth::Identity::Model`-inheriting classes that do not define `#save`.
  - This support will be dropped in v4.0.

## [3.0.4] - 2021-02-14
### Added
- Add support for [sequel ORM](http://sequel.jeremyevans.net/)

## [3.0.3] - 2021-02-14
### Added
- Add option `:on_validation`, which can be used to add a Captcha
  - See [example here](https://github.com/omniauth/omniauth-identity/pull/86#issue-63225122)
- Add support for nobrainer, an ORM for RethinkDB
- Validation error message on invalid registration form submission
### Removed
- ruby-head build... simply too slow

## [3.0.2] - 2021-02-14
### Fixed
- Github Actions CI Build for Ruby 2.4, 3.0 and ruby-head
- Updated copyright
- Code style cleanup
- Added Code Climate "Quality"
- Updated Readme

## [3.0.1] - 2021-02-14
### Fixed
- Github Actions CI Build for various Rubies

## [3.0] - 2021-02-13
### Added
- Compatibility with Ruby 3
- Add option `:enable_login` to bypass OmniAuth disabling of GET method (default `true`)
  - NOTE: This restores compatibility between this gem and the current, core, omniauth gem!
- README updates, including a rename to README.md
- CODE_OF_CONDUCT.md using v2
- Rubocop
- Github Actions for Continuous Integration
- Minimum Ruby version = 2.4
- Automatically adds "provider" => "identity" when "provider" column is detected
- Documentation in README.md
### Removed
- Support for Rubies < 2.4
- Support for DataMapper, which died long ago.
- Unwanted git artifacts

## [2.0] - 2020-09-01
### Added
- CHANGELOG to maintain a history of changes.
- Include mongoid-rspec gem.
### Changed
- Fix failing Specs
- Update Spec syntax to RSpec 3
- Fix deprecation Warnings
- Updated mongoid_spec.rb to leverage mongoid-rspec features.
- Fix security warning about missing secret in session cookie.
- Dependency version limits so that the most up-to-date gem dependencies are used. (rspec 3+, mongo 2+, mongoid 7+, rake 13+, rack 2+, json 2+)
- Updated copyright information.
- Updated MongoMapper section of README to reflect its discontinued support.
### Removed
- Gemfile.lock file
- MongoMapper support; unable to satisfy dependencies of both MongoMapper and Mongoig now that MongoMapper is no longer actively maintained.
