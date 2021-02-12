# Changelog

All notable changes to this project will be documented in this file.


The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- README updates, including a rename to README.md

### Removed
- Removed support for DataMapper, which died long ago.
- Cleanup (removal) of unwanted git artifacts

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