# Changelog

All notable changes to this project since v2.0 will be documented in this file.

The format is based on [Keep a Changelog v1](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning v2](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Added
### Changed
### Fixed
### Removed

## [3.1.2] - 2025-05-07 ([tag][3.1.2t])
- COVERAGE:  92.02% -- 346/376 lines in 15 files
- BRANCH COVERAGE:  79.49% -- 62/78 branches in 15 files
### Added
- 20 year signing cert expires 2045-04-29 by @pboling
- Added CITATION.cff by @pboling
- Improved documentation
- Greatly improved spec suite and CI config
  - Testing against JRuby 9.2, 9.3, 9.4, 10.0, and head
  - Testing against many more combinations of Databases, ORMs, Rails, and Ruby versions
### Changed
- Upgraded Code of Conduct based on Contributor Covenant v2.1 by @pboling

## [3.1.1] - 2024-11-18 ([tag][3.1.1t])
- COVERAGE:  92.00% -- 345/375 lines in 15 files
- BRANCH COVERAGE:  80.26% -- 61/76 branches in 15 files
- 44.44% documented
### Added
- [PR 130][130] Add SECURITY.md policy by @pboling
- [PR 130][130] Add Maintainer contact email by @pboling
### Changed
- [PR 130][130] Require MFA to publish to RubyGems.org by @pboling

[130]: https://github.com/omniauth/omniauth-identity/pull/130

## [3.1.0] - 2024-11-18 ([tag][3.1.0t])
- COVERAGE:  91.98% -- 344/374 lines in 15 files
- BRANCH COVERAGE:  80.26% -- 61/76 branches in 15 files
- 44.44% documented
### Added
- [PR #123][123] Improve readability in #identity method of OmniAuth::Strategies::Identity by @Xeragus
- [PR #124][124] Modernized gem structure, and updated dependencies for development by @pboling
  - Gem releases are now cryptographically signed
  - All ORM adapters (except NoBrainer) are tested in CI
- [PR #127][127] Improved documentation by @pboling
- [PR #128][128] Instructions for contributing by @pboling
### Changed
- Deprecate `require 'omniauth/identity'` by @pboling
  - in favor of `require 'omniauth-identity'` (matching the gem name)
### Fixed
- [PR #120][120] Fix: handling of SCRIPT_NAME for registration_path by @btalbot
- [PR #122][122] Compatibility with rack v3.1+: use `req.params[]` instead of `req[]` by @emon
  - See: https://github.com/rack/rack/pull/2183

[128]: https://github.com/omniauth/omniauth-identity/pull/128
[127]: https://github.com/omniauth/omniauth-identity/pull/127
[124]: https://github.com/omniauth/omniauth-identity/pull/124
[123]: https://github.com/omniauth/omniauth-identity/pull/123
[122]: https://github.com/omniauth/omniauth-identity/pull/122
[120]: https://github.com/omniauth/omniauth-identity/pull/120

## [3.0.9] - 2021-06-16 ([tag][3.0.9t])
### Fixed
- \[Sequel\] Fixes loading the Sequel adapter, issue reported as [#112](https://github.com/omniauth/omniauth-identity/issues/112)
### Added
- 📝 Document the Database adapters and drivers the gem currently works with

## [3.0.8] - 2021-03-24 ([tag][3.0.8t])
### Fixed
- \[Model\] Fixes 2 issues raised in a comment on PR [#108](https://github.com/omniauth/omniauth-identity/pull/108#issuecomment-804456604)
  - When `options[:on_validation]` is set `new`/`save`/`persisted?` logic is used.
  - When `options[:on_validation]` is not set `create`/`persisted?` logic is used.

## [3.0.7] - 2021-03-23 ([tag][3.0.7t])
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

## [3.0.6] - 2021-03-20 ([tag][3.0.6t])
### Fixed
- Fix breaking changes introduced by [#108](https://github.com/omniauth/omniauth-identity/pull/108) which prevented `:on_validation` from firing
### Added
- New (or finally documented) options:
  - `:create_identity_link_text` defaults to `'Create an Identity'`
  - `:registration_failure_message` defaults to `'One or more fields were invalid'`
  - `:validation_failure_message` defaults to `'Validation failed'`
  - `:title` defaults to `'Identity Verification'`
  - `:registration_form_title` defaults to `'Register Identity'`

## [3.0.5] - 2021-03-19 ([tag][3.0.5t])
### Fixed
- Fix breaking changes introduced by [#86's](https://github.com/omniauth/omniauth-identity/pull/86) introduction of `:on_validation`
### Added
- Define `#save`, `#persisted?` and `::create` on `Omniauth::Identity::Model`
- Add `@since` YARD tags to interface methods
- Refactor `Omniauth::Strategies::Identity.registration_phase` to support `Omniauth::Identity::Model`-inheriting classes that do not define `#save`.
  - This support will be dropped in v4.0.

## [3.0.4] - 2021-02-14 ([tag][3.0.4t])
### Added
- Add support for [sequel ORM](http://sequel.jeremyevans.net/)

## [3.0.3] - 2021-02-14 ([tag][3.0.3t])
### Added
- Add option `:on_validation`, which can be used to add a Captcha
  - See [example here](https://github.com/omniauth/omniauth-identity/pull/86#issue-63225122)
- Add support for nobrainer, an ORM for RethinkDB
- Validation error message on invalid registration form submission
### Removed
- ruby-head build... simply too slow

## [3.0.2] - 2021-02-14 ([tag][3.0.2t])
### Fixed
- Github Actions CI Build for Ruby 2.4, 3.0 and ruby-head
- Updated copyright
- Code style cleanup
- Added Code Climate "Quality"
- Updated Readme

## [3.0.1] - 2021-02-14 ([tag][3.0.1t])
### Fixed
- Github Actions CI Build for various Rubies

## [3.0.0] - 2021-02-13 ([tag][3.0.0t])
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

## [2.0.0] - 2020-09-01 ([tag][2.0.0t])
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
- MongoMapper support; unable to satisfy dependencies of both MongoMapper and Mongoid now that MongoMapper is no longer actively maintained.

[Unreleased]: https://github.com/omniauth/omniauth-identity/compare/v3.1.2...HEAD
[3.1.2]: https://github.com/omniauth/omniauth-identity/compare/v3.1.1...v3.1.2
[3.1.2t]: https://github.com/omniauth/omniauth-identity/tags/v3.1.2
[3.1.1]: https://github.com/omniauth/omniauth-identity/compare/v3.1.0...v3.1.1
[3.1.1t]: https://github.com/omniauth/omniauth-identity/tags/v3.1.1
[3.1.0]: https://github.com/omniauth/omniauth-identity/compare/v3.0.9...v3.1.0
[3.1.0t]: https://github.com/omniauth/omniauth-identity/tags/v3.1.0
[3.0.9]: https://github.com/omniauth/omniauth-identity/compare/v3.0.8...v3.0.9
[3.0.9t]: https://github.com/omniauth/omniauth-identity/tags/v3.0.9
[3.0.8]: https://github.com/omniauth/omniauth-identity/compare/v3.0.7...v3.0.8
[3.0.8t]: https://github.com/omniauth/omniauth-identity/tags/v3.0.8
[3.0.7]: https://github.com/omniauth/omniauth-identity/compare/v3.0.6...v3.0.7
[3.0.7t]: https://github.com/omniauth/omniauth-identity/tags/v3.0.7
[3.0.6]: https://github.com/omniauth/omniauth-identity/compare/v3.0.5...v3.0.6
[3.0.6t]: https://github.com/omniauth/omniauth-identity/tags/v3.0.6
[3.0.5]: https://github.com/omniauth/omniauth-identity/compare/v3.0.4...v3.0.5
[3.0.5t]: https://github.com/omniauth/omniauth-identity/tags/v3.0.5
[3.0.4]: https://github.com/omniauth/omniauth-identity/compare/v3.0.3...v3.0.4
[3.0.4t]: https://github.com/omniauth/omniauth-identity/tags/v3.0.4
[3.0.3]: https://github.com/omniauth/omniauth-identity/compare/v3.0.2...v3.0.3
[3.0.3t]: https://github.com/omniauth/omniauth-identity/tags/v3.0.3
[3.0.2]: https://github.com/omniauth/omniauth-identity/compare/v3.0.1...v3.0.2
[3.0.2t]: https://github.com/omniauth/omniauth-identity/tags/v3.0.2
[3.0.1]: https://github.com/omniauth/omniauth-identity/compare/v3.0.0...v3.0.1
[3.0.1t]: https://github.com/omniauth/omniauth-identity/tags/v3.0.1
[3.0.0]: https://github.com/omniauth/omniauth-identity/compare/v2.0.0...v3.0.0
[3.0.0t]: https://github.com/omniauth/omniauth-identity/tags/v3.0.0
[2.0.0]: https://github.com/omniauth/omniauth-identity/compare/v1.1.1...v2.0.0
[2.0.0t]: https://github.com/omniauth/omniauth-identity/tags/v2.0.0
[1.1.1]: https://github.com/omniauth/omniauth-identity/compare/v1.1.0...v1.1.1
[1.1.1t]: https://github.com/omniauth/omniauth-identity/tags/v1.1.1
[1.1.0]: https://github.com/omniauth/omniauth-identity/compare/v1.0.0...v1.1.0
[1.1.0t]: https://github.com/omniauth/omniauth-identity/tags/v1.0.0
[1.0.0]: https://github.com/omniauth/omniauth-identity/compare/v0.3.0...v1.0.0
[1.0.0t]: https://github.com/omniauth/omniauth-identity/tags/v1.0.0
[0.3.0]: https://github.com/omniauth/omniauth-identity/compare/v0.2.6...v0.3.0
[0.3.0t]: https://github.com/omniauth/omniauth-identity/tags/v0.3.0
[0.2.6]: https://github.com/omniauth/omniauth-identity/compare/v0.2.5...v0.2.6
[0.2.6t]: https://github.com/omniauth/omniauth-identity/tags/v0.2.6
[0.2.5]: https://github.com/omniauth/omniauth-identity/compare/v0.2.4...v0.2.5
[0.2.5t]: https://github.com/omniauth/omniauth-identity/tags/v0.2.5
[0.2.4]: https://github.com/omniauth/omniauth-identity/compare/v0.2.3...v0.2.4
[0.2.4t]: https://github.com/omniauth/omniauth-identity/tags/v0.2.5
[0.2.3]: https://github.com/omniauth/omniauth-identity/compare/v0.2.2...v0.2.3
[0.2.3t]: https://github.com/omniauth/omniauth-identity/tags/v0.2.3
[0.2.2]: https://github.com/omniauth/omniauth-identity/compare/v0.2.1...v0.2.2
[0.2.2t]: https://github.com/omniauth/omniauth-identity/tags/v0.2.2
[0.2.1]: https://github.com/omniauth/omniauth-identity/compare/v0.2.0...v0.2.1
[0.2.1t]: https://github.com/omniauth/omniauth-identity/tags/v0.2.1
[0.2.0]: https://github.com/omniauth/omniauth-identity/compare/v0.1.6...v0.2.0
[0.2.0t]: https://github.com/omniauth/omniauth-identity/tags/v0.2.0
[0.1.6]: https://github.com/omniauth/omniauth-identity/compare/v0.1.5...v0.1.6
[0.1.6t]: https://github.com/omniauth/omniauth-identity/tags/v0.1.6
[0.1.5]: https://github.com/omniauth/omniauth-identity/compare/v0.1.4...v0.1.5
[0.1.5t]: https://github.com/omniauth/omniauth-identity/tags/v0.1.5
[0.1.4]: https://github.com/omniauth/omniauth-identity/compare/v0.1.3...v0.1.4
[0.1.4t]: https://github.com/omniauth/omniauth-identity/tags/v0.1.4
[0.1.3]: https://github.com/omniauth/omniauth-identity/compare/v0.1.1...v0.1.3
[0.1.3t]: https://github.com/omniauth/omniauth-identity/tags/v0.1.3
[0.1.1]: https://github.com/omniauth/omniauth-identity/compare/v0.0.4...v0.1.1
[0.1.1t]: https://github.com/omniauth/omniauth-identity/tags/v0.1.1
[0.0.4]: https://github.com/omniauth/omniauth-identity/compare/v0.0.3...v0.0.4
[0.0.4t]: https://github.com/omniauth/omniauth-identity/tags/v0.0.4
[0.0.3]: https://github.com/omniauth/omniauth-identity/compare/v0.0.1...v0.0.3
[0.0.3t]: https://github.com/omniauth/omniauth-identity/tags/v0.0.3
[0.0.1]: https://github.com/omniauth/omniauth-identity/compare/be7b50aafea590caae6dc9dce550a96b997773cd...v0.0.1
[0.0.1t]: https://github.com/omniauth/omniauth-identity/tags/v0.0.1
