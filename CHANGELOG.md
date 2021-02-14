# Changelog

All notable changes to this project will be documented in this file.


The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

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